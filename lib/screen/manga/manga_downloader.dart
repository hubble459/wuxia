import 'dart:io';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/util/tools.dart';

/// Downloads every chapter of a manga for offline reading, showing a
/// progress dialog and (on Android) keeping the device/app alive via a
/// wakelock and foreground service for the duration.
class MangaDownloader {
  MangaDownloader({required this.manga, required this.source});

  final MangaReply manga;
  final MangaSourceReply source;

  /// How many page images to fetch at once per chapter -- kept low since
  /// it multiplies with `_chapterConcurrency` for the total number of
  /// in-flight connections (currently 2 * 8 = 16), bounded so a fresh
  /// download doesn't open dozens of connections at once.
  static const _downloadConcurrency = 2;

  /// How many chapters to process at once. Chapter N+1's image list (and
  /// thus its first image requests, which are what actually trigger
  /// rumgap's scrape-and-cache work for a not-yet-cached page) doesn't have
  /// to wait for chapter N's images to fully finish downloading first.
  /// Weighted higher than `_downloadConcurrency` so more chapters start
  /// scraping sooner, rather than a few chapters each fetching pages fast.
  static const _chapterConcurrency = 8;

  /// rumgap clamps `per_page` to 50 server-side (chapter.rs) regardless of
  /// what's requested, so one call with `perPage: totalChapters` silently
  /// only ever returns the first page -- paginate through as many pages as
  /// it takes to actually collect every chapter.
  Future<List<ChapterReply>> _fetchAllChapters(int totalChapters) async {
    final allChapters = <ChapterReply>[];
    for (var page = 0; allChapters.length < totalChapters; page++) {
      final result = await api.chapter.index(PaginateChapterQuery(
        mangaSourceId: source.id,
        reversed: false,
        paginateQuery: PaginateQuery(page: Int64(page), perPage: Int64(totalChapters)),
      ));
      if (result.items.isEmpty) break;
      allChapters.addAll(result.items);
    }
    return allChapters;
  }

  String _formatEta(Duration eta) {
    if (eta.inHours > 0) return '${eta.inHours}h ${eta.inMinutes.remainder(60)}m';
    if (eta.inMinutes > 0) return '${eta.inMinutes}m';
    return '${eta.inSeconds}s';
  }

  Future<void> download(BuildContext context) async {
    if (kIsWeb) return;

    final totalChapters = manga.countChapters.toInt();
    if (totalChapters == 0) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.no-chapters')).ignore();
      return;
    }

    final progress = ValueNotifier<int>(0);
    var cancelled = false;
    // Elapsed real time / chapters-so-far gives an average per-chapter rate
    // to extrapolate an ETA from. Only chapters that actually needed a
    // network fetch count here -- chapters skipped almost instantly because
    // they're already downloaded (see `_downloadChapterImage`) would
    // otherwise drag the average down and make the ETA look far faster than
    // the real download rate once it runs out of already-downloaded
    // chapters to fly through. Kept running across retries (not reset
    // alongside `progress`) so a transient failure doesn't throw it off.
    //
    // A single continuous stopwatch (started once real downloading begins),
    // not one timer per chapter summed together -- chapters download
    // `_chapterConcurrency` at a time, so per-chapter timers would overlap
    // and double-count the same wall-clock time, understating throughput.
    var ratedChapters = 0;
    Stopwatch? ratedStopwatch;

    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(FlutterI18n.translate(ctx, 'manga.download')),
        content: ValueListenableBuilder<int>(
          valueListenable: progress,
          builder: (_, downloaded, __) {
            final remaining = totalChapters - downloaded;
            final rateStopwatch = ratedStopwatch;
            final eta = ratedChapters > 0 && remaining > 0 && rateStopwatch != null
                ? _formatEta(rateStopwatch.elapsed * (remaining / ratedChapters))
                : null;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: downloaded / totalChapters),
                const SizedBox(height: 8),
                Text('$downloaded / $totalChapters'),
                if (eta != null)
                  Text(
                    FlutterI18n.translate(ctx, 'manga.download-eta', translationParams: {'eta': eta}),
                    style: Theme.of(ctx).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              cancelled = true;
              Navigator.of(ctx).pop();
            },
            child: Text(FlutterI18n.translate(ctx, 'basic.cancel')),
          ),
        ],
      ),
    );

    var failed = false;
    await WakelockPlus.enable();
    await _startDownloadForegroundService(totalChapters);
    progress.addListener(() => _updateDownloadForegroundService(progress.value, totalChapters));
    final client = http.Client();
    try {
      // Already-downloaded chapters/images are skipped almost for free (see
      // `_downloadChapterImage`), so on a transient failure (e.g. the source
      // site erroring on one chapter) the cheapest way to pick up where it
      // left off is just re-running the whole thing from chapter 1.
      while (true) {
        progress.value = 0;
        try {
          final dir = await getDownloadDirectory();
          final safeName = manga.title.replaceAll(RegExp(r'[^\w\s\-]'), '_');
          final mangaDir = Directory('${dir.path}/$safeName');

          final chapters = ChaptersReply(items: await _fetchAllChapters(totalChapters));

          await mangaDir.create(recursive: true);
          await File('${mangaDir.path}/manga.pb').writeAsBytes(manga.writeToBuffer());
          await File('${mangaDir.path}/chapters.pb').writeAsBytes(chapters.writeToBuffer());

          Future<bool> downloadChapter(ChapterReply chapter) async {
            final chapterDir = Directory('${mangaDir.path}/${chapter.number.toStringAsFixed(1).replaceAll('.0', '')}');
            await chapterDir.create(recursive: true);

            final images = await api.chapter.images(ChapterImagesRequest(chapterId: chapter.id));
            var chapterDownloaded = false;
            for (var start = 0; start < images.items.length; start += _downloadConcurrency) {
              if (cancelled) break;
              final batch = images.items.skip(start).take(_downloadConcurrency).toList();
              final results = await Future.wait(batch.mapIndexed(
                (offset, image) => _downloadChapterImage(client, image.url, chapterDir, start + offset),
              ));
              if (results.contains(true)) chapterDownloaded = true;
            }
            return chapterDownloaded;
          }

          for (var start = 0; start < chapters.items.length; start += _chapterConcurrency) {
            if (cancelled) break;

            final batch = chapters.items.skip(start).take(_chapterConcurrency).toList();
            final results = await Future.wait(batch.map(downloadChapter));
            for (final chapterDownloaded in results) {
              if (chapterDownloaded) {
                ratedChapters++;
                ratedStopwatch ??= Stopwatch()..start();
              }
              progress.value++;
            }
          }
          break;
        } catch (e, st) {
          print('download error: $e\n$st');
          // ignore: use_build_context_synchronously
          if (cancelled || !await _confirmRetryDownload(context, e)) {
            failed = true;
            Fluttertoast.showToast(msg: e.toString()).ignore();
            break;
          }
        }
      }
    } finally {
      client.close();
      await WakelockPlus.disable();
      await _stopDownloadForegroundService();
      progress.dispose();
      if (context.mounted && !cancelled) {
        Navigator.of(context).pop();
        if (!failed) {
          Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.download-complete')).ignore();
        }
      }
    }
  }

  Future<bool> _confirmRetryDownload(BuildContext context, Object error) async {
    if (!context.mounted) return false;
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text(FlutterI18n.translate(ctx, 'manga.download-failed')),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(FlutterI18n.translate(ctx, 'basic.cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(FlutterI18n.translate(ctx, 'basic.retry')),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Promotes the app to a foreground service with a persistent notification
  /// so Android doesn't throttle/kill the download loop when the app is
  /// backgrounded (e.g. the user switches to another app) -- `WakelockPlus`
  /// alone only keeps the screen from sleeping, it doesn't survive that.
  /// Android-only; iOS has no equivalent mechanism.
  Future<void> _startDownloadForegroundService(int totalChapters) async {
    if (!Platform.isAndroid) return;

    if (await FlutterForegroundTask.checkNotificationPermission() != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    await FlutterForegroundTask.startService(
      serviceId: 288,
      serviceTypes: [ForegroundServiceTypes.dataSync],
      notificationTitle: manga.title,
      notificationText: '0 / $totalChapters',
      callback: downloadForegroundTaskCallback,
    );
  }

  void _updateDownloadForegroundService(int downloaded, int totalChapters) {
    if (!Platform.isAndroid) return;
    FlutterForegroundTask.updateService(notificationText: '$downloaded / $totalChapters');
  }

  Future<void> _stopDownloadForegroundService() async {
    if (!Platform.isAndroid) return;
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }

  /// Skips the request entirely if the page is already on disk, so
  /// re-running a download over a chapter that's already complete costs
  /// only a metadata call and local existence checks, not a re-fetch of
  /// every page's bytes. Returns whether a fetch actually happened (`false`
  /// for a skip), so callers can tell real download work apart from a
  /// near-instant skip -- see the ETA rate-tracking in `download`.
  Future<bool> _downloadChapterImage(http.Client client, String url, Directory chapterDir, int index) async {
    final file = File('${chapterDir.path}/$index.${_imageExtension(url)}');
    if (await file.exists()) return false;

    final response = await client.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return true;
  }

  /// Some source sites serve images from paths with no extension on the
  /// final segment (e.g. `.../images/150789/0`), and the domain itself
  /// always has dots -- so the extension must come from just the last path
  /// segment, never from splitting the whole URL, or a slash-containing
  /// remainder of the domain/path ends up in the write path. Falls back to
  /// `jpg` when the last segment has no dot.
  String _imageExtension(String url) {
    final lastSegment = Uri.parse(url).pathSegments.lastOrNull ?? '';
    final dot = lastSegment.lastIndexOf('.');
    return dot == -1 ? 'jpg' : lastSegment.substring(dot + 1);
  }
}
