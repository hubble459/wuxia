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

  /// How many page images to fetch at once per chapter -- bounded so a
  /// fresh download doesn't open dozens of connections at once, but high
  /// enough that a slow/high-latency connection isn't paying full
  /// round-trip cost for every page in sequence.
  static const _downloadConcurrency = 4;

  Future<void> download(BuildContext context) async {
    if (kIsWeb) return;

    final totalChapters = manga.countChapters.toInt();
    if (totalChapters == 0) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.no-chapters')).ignore();
      return;
    }

    final progress = ValueNotifier<int>(0);
    var cancelled = false;

    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(FlutterI18n.translate(ctx, 'manga.download')),
        content: ValueListenableBuilder<int>(
          valueListenable: progress,
          builder: (_, downloaded, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: downloaded / totalChapters),
              const SizedBox(height: 8),
              Text('$downloaded / $totalChapters'),
            ],
          ),
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

          final chapters = await api.chapter.index(PaginateChapterQuery(
            mangaSourceId: source.id,
            reversed: false,
            paginateQuery: PaginateQuery(page: Int64(0), perPage: Int64(totalChapters)),
          ));

          await mangaDir.create(recursive: true);
          await File('${mangaDir.path}/manga.pb').writeAsBytes(manga.writeToBuffer());
          await File('${mangaDir.path}/chapters.pb').writeAsBytes(chapters.writeToBuffer());

          for (final chapter in chapters.items) {
            if (cancelled) break;

            final chapterDir = Directory('${mangaDir.path}/${chapter.number.toStringAsFixed(1).replaceAll('.0', '')}');
            await chapterDir.create(recursive: true);

            final images = await api.chapter.images(ChapterImagesRequest(chapterId: chapter.id));
            for (var start = 0; start < images.items.length; start += _downloadConcurrency) {
              if (cancelled) break;
              final batch = images.items.skip(start).take(_downloadConcurrency).toList();
              await Future.wait(batch.mapIndexed(
                (offset, image) => _downloadChapterImage(client, image.url, chapterDir, start + offset),
              ));
            }

            progress.value++;
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
  /// every page's bytes.
  Future<void> _downloadChapterImage(http.Client client, String url, Directory chapterDir, int index) async {
    final file = File('${chapterDir.path}/$index.${_imageExtension(url)}');
    if (await file.exists()) return;

    final response = await client.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
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
