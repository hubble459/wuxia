import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/scrape_error.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/util/download_migration.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/page_unload/page_unload.dart';
import 'package:wuxia/util/session.dart';
import 'package:wuxia/util/store.dart';
import 'package:wuxia/util/tools.dart';

/// Id of the cancel button on the foreground-service notification; the
/// service isolate forwards presses of it to the main isolate as this
/// string (see `downloadForegroundTaskCallback` in main.dart).
const downloadNotificationCancelButton = 'cancel_download';

enum DownloadStatus { queued, running, failed }

/// One chapter currently inside `_chapterConcurrency`'s active pool, with
/// its own page-download progress so the queue can show each concurrently
/// downloading chapter alongside the overall progress.
class ActiveChapterProgress {
  ActiveChapterProgress(this.chapter, this.total);

  final ChapterReply chapter;
  final int total;
  final ValueNotifier<int> downloaded = ValueNotifier<int>(0);

  /// Chapter number formatted the same way as the chapter's download folder.
  String get label => chapterFolderName(chapter.number);
}

/// A single manga queued for (or in the middle of) an offline download.
/// Lives in `DownloadManager.tasks` until it completes or is cancelled;
/// a failed task stays there so it can be retried or dismissed.
class DownloadTask extends ChangeNotifier {
  DownloadTask._(this.manga, this.source);

  final MangaReply manga;
  final MangaSourceReply source;

  int get totalChapters => manga.countChapters.toInt();

  DownloadStatus _status = DownloadStatus.queued;
  DownloadStatus get status => _status;

  Object? _error;

  /// The error that made this task fail, when `status` is `failed`.
  Object? get error => _error;

  /// Whether the chapter list has been fetched and chapters are downloading;
  /// before that the task is running but has no meaningful progress yet.
  bool _started = false;
  bool get started => _started;

  final ValueNotifier<int> progress = ValueNotifier<int>(0);
  final ValueNotifier<List<ActiveChapterProgress>> activeChapters = ValueNotifier<List<ActiveChapterProgress>>([]);

  bool _cancelled = false;

  // Elapsed real time / chapters-so-far gives an average per-chapter rate
  // to extrapolate an ETA from. Only chapters that actually needed a
  // network fetch count here -- chapters skipped almost instantly because
  // they're already downloaded (see `_downloadChapterImage`) would
  // otherwise drag the average down and make the ETA look far faster than
  // the real download rate once it runs out of already-downloaded chapters
  // to fly through. Kept across retries so a transient failure doesn't
  // throw it off.
  //
  // A single continuous stopwatch (started once real downloading begins),
  // not one timer per chapter summed together -- chapters download
  // `_chapterConcurrency` at a time, so per-chapter timers would overlap
  // and double-count the same wall-clock time, understating throughput.
  int _ratedChapters = 0;
  Stopwatch? _ratedStopwatch;

  /// Estimated time left, or null until at least one chapter has actually
  /// been fetched over the network.
  Duration? get eta {
    final remaining = totalChapters - progress.value;
    final stopwatch = _ratedStopwatch;
    if (_ratedChapters == 0 || remaining <= 0 || stopwatch == null) return null;
    return stopwatch.elapsed * (remaining / _ratedChapters);
  }

  void _setStatus(DownloadStatus status, {Object? error}) {
    _status = status;
    _error = error;
    notifyListeners();
  }

  void _setStarted(bool started) {
    if (_started == started) return;
    _started = started;
    notifyListeners();
  }

  @override
  void dispose() {
    progress.dispose();
    activeChapters.dispose();
    super.dispose();
  }
}

/// App-wide queue of manga downloads. Downloads run one manga at a time
/// (each one already fetches `_chapterConcurrency` chapters in parallel),
/// independent of whichever screen started them. While the queue is
/// running the device is kept awake and, on Android, the app is promoted
/// to a foreground service so downloads keep going in the background.
///
/// The queue is saved to the `Store` on every change and restored on
/// startup (see `restore`); a download interrupted by a restart is queued
/// again, and resumes cheaply since every page already on disk is skipped.
class DownloadManager extends ChangeNotifier {
  DownloadManager._();

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

  final List<DownloadTask> _tasks = [];

  /// Queued, running and failed downloads, in queue order.
  List<DownloadTask> get tasks => List.unmodifiable(_tasks);

  /// Number of downloads that are queued or running.
  int get activeCount => _tasks.where((t) => t.status != DownloadStatus.failed).length;

  final StreamController<DownloadTask> _completed = StreamController<DownloadTask>.broadcast();

  /// Emits each task right after it finishes downloading successfully.
  Stream<DownloadTask> get completed => _completed.stream;

  bool _running = false;

  /// Set once the web page starts unloading. The browser then aborts every
  /// in-flight request, and those errors must not mark the running task as
  /// failed -- it stays queued in the saved queue and resumes on next load.
  bool _unloading = false;

  /// Saves the queue on every change, so it can be restored after a restart.
  @override
  void notifyListeners() {
    _persist();
    super.notifyListeners();
  }

  void _persist() {
    final encoded = [
      for (final task in _tasks)
        jsonEncode({
          'manga': base64Encode(task.manga.writeToBuffer()),
          'source': base64Encode(task.source.writeToBuffer()),
          if (task.status == DownloadStatus.failed) 'error': '${task.error}',
        }),
    ];
    Store.getStoreInstance().setDownloadQueue(encoded).ignore();
  }

  /// Loads the queue saved by a previous run and starts it once the login
  /// session is restored. A task that was
  /// running when the app stopped is queued again; failed tasks stay
  /// failed. Entries that can't be decoded (e.g. from an incompatible
  /// version) are dropped.
  void restore() {
    if (!downloadsSupported) return;
    onPageUnload(() => _unloading = true);
    for (final entry in Store.getStoreInstance().getDownloadQueue()) {
      try {
        final json = jsonDecode(entry) as Map<String, dynamic>;
        final task = DownloadTask._(
          MangaReply.fromBuffer(base64Decode(json['manga'] as String)),
          MangaSourceReply.fromBuffer(base64Decode(json['source'] as String)),
        );
        final error = json['error'] as String?;
        if (error != null) task._setStatus(DownloadStatus.failed, error: error);
        _tasks.add(task);
      } catch (e) {
        debugPrint('dropping unreadable download queue entry: $e');
      }
    }
    notifyListeners();
    // The queue's API calls need the saved login, which isn't restored yet
    // this early in startup; wait for it, and leave the queue waiting when
    // logged out or offline (logging in calls `resume`).
    restoreSession().then((_) {
      if (API.isLoggedIn && !sessionOffline) resume();
    });
  }

  /// Starts working through the queue if it isn't already. A no-op while
  /// download storage needs its access re-granted (web folder access is
  /// reset between visits); `reconnectDownloads` calls this once it is.
  void resume() {
    if (_nextQueued != null) _pump();
  }

  DownloadTask? taskFor(int mangaId) => _tasks.firstWhereOrNull((t) => t.manga.id == mangaId);

  /// Adds [manga] to the download queue. Returns false (and queues nothing)
  /// when storage access isn't granted, the manga has no chapters, or it's
  /// already in the queue.
  Future<bool> enqueue(BuildContext context, MangaReply manga, MangaSourceReply source) async {
    if (!downloadsSupported) return false;
    if (await downloadStorage.status() == DownloadStorageStatus.needsPermission && !await downloadStorage.requestPermission()) {
      return false;
    }
    if (!context.mounted) return false;
    if (manga.countChapters.toInt() == 0) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.no-chapters')).ignore();
      return false;
    }
    if (taskFor(manga.id) != null) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'downloads.already_queued')).ignore();
      return false;
    }

    _tasks.add(DownloadTask._(manga, source));
    notifyListeners();
    Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'downloads.queued_toast')).ignore();
    _pump();
    return true;
  }

  /// Removes a queued or failed task, or stops a running one (pages already
  /// on disk are kept, so starting it again later resumes cheaply).
  void cancel(DownloadTask task) {
    if (task.status == DownloadStatus.running) {
      task._cancelled = true;
      return;
    }
    _remove(task);
  }

  void retry(DownloadTask task) {
    if (task.status != DownloadStatus.failed) return;
    task._cancelled = false;
    task._setStatus(DownloadStatus.queued);
    notifyListeners();
    _pump();
  }

  void _remove(DownloadTask task) {
    if (!_tasks.remove(task)) return;
    notifyListeners();
    task.dispose();
  }

  DownloadTask? get _nextQueued => _tasks.firstWhereOrNull((t) => t.status == DownloadStatus.queued);

  Future<void> _pump() async {
    if (_running) return;
    _running = true;
    if (await downloadStorage.status() == DownloadStorageStatus.needsPermission) {
      _running = false;
      return;
    }
    await ensureDownloadsMigrated();
    await WakelockPlus.enable();
    await _startForegroundService();
    try {
      for (var task = _nextQueued; task != null && !_unloading; task = _nextQueued) {
        await _run(task);
      }
    } finally {
      await WakelockPlus.disable();
      await _stopForegroundService();
      _running = false;
    }
    // A task enqueued while the service was being stopped found `_running`
    // still set and returned early, so pick it up here.
    if (_nextQueued != null && !_unloading) _pump();
  }

  Future<void> _run(DownloadTask task) async {
    task._setStatus(DownloadStatus.running);
    notifyListeners();
    void onProgress() => _updateForegroundService(task);
    task.progress.addListener(onProgress);
    _updateForegroundService(task);

    final client = http.Client();
    Object? error;
    try {
      await _download(task, client);
    } catch (e, st) {
      debugPrint('download error: $e\n$st');
      error = e;
    } finally {
      client.close();
      task.progress.removeListener(onProgress);
    }

    if (_unloading) return;
    if (task._cancelled) {
      _remove(task);
    } else if (error != null) {
      task._setStarted(false);
      task.activeChapters.value = [];
      task._setStatus(DownloadStatus.failed, error: error);
      notifyListeners();
      _toast('downloads.failed_toast', {'title': task.manga.title});
    } else {
      _completed.add(task);
      _remove(task);
      _toast('downloads.complete_toast', {'title': task.manga.title});
    }
  }

  /// Translates [key] through the app's root context, for code that runs
  /// outside any widget; [fallback] covers the moment before the app's
  /// first frame.
  String _translate(String key, String fallback, [Map<String, String>? params]) {
    final context = navigatorKey.currentContext;
    if (context == null) return fallback;
    return FlutterI18n.translate(context, key, translationParams: params);
  }

  void _toast(String key, Map<String, String> params) {
    if (navigatorKey.currentContext == null) return;
    Fluttertoast.showToast(msg: _translate(key, '', params)).ignore();
  }

  /// Downloads every chapter of [task]'s manga. Already-downloaded pages
  /// are skipped almost for free (see `_downloadChapterImage`), so running
  /// this again after a failure picks up roughly where it left off.
  Future<void> _download(DownloadTask task, http.Client client) async {
    task.progress.value = 0;
    final manga = task.manga;
    final mangaDir = mangaFolderName(manga.id);
    final sourceDir = '$mangaDir/${sourceFolderName(task.source.id)}';

    final chapters = ChaptersReply(items: await _fetchAllChapters(task.source, task.totalChapters));

    await downloadStorage.write('$mangaDir/manga.pb', manga.writeToBuffer());
    await downloadStorage.write('$sourceDir/chapters.pb', chapters.writeToBuffer());

    Future<bool> downloadChapter(ChapterReply chapter) async {
      final chapterDir = '$sourceDir/${chapterFolderName(chapter.number)}';

      final images = await _fetchChapterImages(chapter);
      final active = ActiveChapterProgress(chapter, images.items.length);
      task.activeChapters.value = [...task.activeChapters.value, active];
      try {
        var chapterDownloaded = false;
        // A worker pool, not batches -- a batch would wait for all
        // `_downloadConcurrency` pages to finish before starting the next
        // group, so one slow page stalls slots that already finished. Each
        // worker instead pulls the next page off the shared `nextPage`
        // cursor as soon as it's free.
        var nextPage = 0;
        Future<void> pageWorker() async {
          while (!task._cancelled) {
            final index = nextPage;
            if (index >= images.items.length) return;
            nextPage++;
            final fetched = await _downloadChapterImage(client, images.items[index].url, chapterDir, index);
            if (fetched) chapterDownloaded = true;
            active.downloaded.value++;
          }
        }

        await Future.wait(List.generate(_downloadConcurrency, (_) => pageWorker()));
        return chapterDownloaded;
      } finally {
        task.activeChapters.value = task.activeChapters.value.where((c) => c != active).toList();
        active.downloaded.dispose();
      }
    }

    task._setStarted(true);
    // Same worker-pool reasoning as `pageWorker` above, one level up:
    // `_chapterConcurrency` workers each pull the next chapter off the
    // shared `nextChapter` cursor as soon as they finish their current one.
    var nextChapter = 0;
    Object? failure;
    StackTrace? failureStack;
    Future<void> chapterWorker() async {
      while (!task._cancelled && failure == null) {
        final index = nextChapter;
        if (index >= chapters.items.length) return;
        nextChapter++;
        bool chapterDownloaded;
        try {
          chapterDownloaded = await downloadChapter(chapters.items[index]);
        } catch (e, st) {
          // Stop every worker as soon as any one of them hits an error
          // that survived the per-request retries, rather than letting the
          // others quietly run the remaining chapters with fewer workers.
          failure ??= e;
          failureStack ??= st;
          return;
        }
        if (chapterDownloaded) {
          task._ratedChapters++;
          task._ratedStopwatch ??= Stopwatch()..start();
        }
        task.progress.value++;
      }
    }

    await Future.wait(List.generate(_chapterConcurrency, (_) => chapterWorker()));
    final error = failure;
    if (error != null) Error.throwWithStackTrace(error, failureStack!);
    if (!task._cancelled) await writeDownloadCompleteMarker(sourceDir, task.totalChapters);
  }

  /// rumgap clamps `per_page` to 50 server-side (chapter.rs) regardless of
  /// what's requested, so one call with `perPage: totalChapters` only ever
  /// returns the first page -- paginate through as many pages as it takes
  /// to collect every chapter.
  Future<List<ChapterReply>> _fetchAllChapters(MangaSourceReply source, int totalChapters) async {
    final allChapters = <ChapterReply>[];
    for (var page = 0; allChapters.length < totalChapters; page++) {
      final result = await api.chapter.index(
        PaginateChapterQuery(
          mangaSourceId: source.id,
          reversed: true,
          paginateQuery: PaginateQuery(page: Int64(page), perPage: Int64(totalChapters)),
        ),
      );
      if (result.items.isEmpty) break;
      allChapters.addAll(result.items);
    }
    return allChapters;
  }

  /// Whether a `GrpcError` from a chapter scrape is worth one retry:
  /// `ReqwestError` (a transient HTTP failure on rumgap's side -- e.g. the
  /// source site returning a 520) or `CloudflareIUAM` (the source site's
  /// challenge page, which sometimes clears within a few seconds). Anything
  /// else (a selector/parsing error, an unsupported website, ...) won't be
  /// fixed by retrying, so it fails the task instead.
  bool _isRetryableScrapeError(GrpcError e) {
    final details = e.details;
    if (details == null || details.isEmpty) return false;
    final error = ScrapeError.fromBuffer((details[0] as dynamic).value);
    return error.type == ScrapeErrorType.ReqwestError || error.type == ScrapeErrorType.CloudflareIUAM;
  }

  /// Fetches a chapter's page list, retrying once (after a short pause) on
  /// a transient scrape failure -- see `_isRetryableScrapeError`.
  Future<ImagesReply> _fetchChapterImages(ChapterReply chapter) async {
    try {
      return await api.chapter.images(ChapterImagesRequest(chapterId: chapter.id));
    } on GrpcError catch (e) {
      if (!_isRetryableScrapeError(e)) rethrow;
      await Future.delayed(const Duration(seconds: 2));
      return await api.chapter.images(ChapterImagesRequest(chapterId: chapter.id));
    }
  }

  /// Worth one immediate retry: any 5xx (a transient origin/proxy hiccup)
  /// or Cloudflare's IUAM ("I'm Under Attack Mode") challenge response,
  /// which Cloudflare marks with a `cf-mitigated: challenge` header even
  /// when the status itself isn't a 5xx.
  bool _isTransientError(http.Response response) {
    if (response.statusCode >= 500 && response.statusCode < 600) return true;
    return response.headers['cf-mitigated']?.toLowerCase() == 'challenge';
  }

  /// Skips the request entirely if the page is already on disk, so
  /// re-running a download over a chapter that's already complete costs
  /// only a metadata call and local existence checks, not a re-fetch of
  /// every page's bytes. Returns whether a fetch actually happened (`false`
  /// for a skip), so callers can tell real download work apart from a
  /// near-instant skip -- see `DownloadTask.eta`.
  Future<bool> _downloadChapterImage(http.Client client, String url, String chapterDir, int index) async {
    final path = '$chapterDir/$index.${_imageExtension(url)}';
    if (await downloadStorage.exists(path)) return false;

    final uri = Uri.parse(url);
    var response = await client.get(uri);
    if (_isTransientError(response)) {
      await Future.delayed(const Duration(seconds: 1));
      response = await client.get(uri);
    }
    await downloadStorage.write(path, response.bodyBytes);
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

  static bool get _usesForegroundService => !kIsWeb && Platform.isAndroid;

  void _onTaskData(Object data) {
    if (data != downloadNotificationCancelButton) return;
    final running = _tasks.firstWhereOrNull((t) => t.status == DownloadStatus.running);
    if (running != null) cancel(running);
  }

  /// Promotes the app to a foreground service with a persistent notification
  /// so Android doesn't throttle/kill the download loop when the app is
  /// backgrounded -- `WakelockPlus` alone only keeps the screen from
  /// sleeping, it doesn't survive that. Android-only; iOS has no equivalent
  /// mechanism.
  Future<void> _startForegroundService() async {
    if (!_usesForegroundService) return;

    if (await FlutterForegroundTask.checkNotificationPermission() != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    FlutterForegroundTask.addTaskDataCallback(_onTaskData);
    await FlutterForegroundTask.startService(
      serviceId: 288,
      serviceTypes: [ForegroundServiceTypes.dataSync],
      notificationTitle: _translate('manga.downloading', 'Downloading'),
      notificationText: '',
      notificationIcon: const NotificationIcon(metaDataName: 'io.wuxia.download_notification_icon'),
      notificationButtons: [NotificationButton(id: downloadNotificationCancelButton, text: _translate('basic.cancel', 'Cancel'))],
      callback: downloadForegroundTaskCallback,
    );
  }

  void _updateForegroundService(DownloadTask task) {
    if (!_usesForegroundService) return;
    final queued = _tasks.where((t) => t.status == DownloadStatus.queued).length;
    var text = '${task.progress.value} / ${task.totalChapters}';
    if (queued > 0) text += ' · ${_translate('downloads.queued_count', '$queued queued', {'count': '$queued'})}';
    FlutterForegroundTask.updateService(notificationTitle: task.manga.title, notificationText: text);
  }

  Future<void> _stopForegroundService() async {
    if (!_usesForegroundService) return;
    FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }
}

final downloadManager = DownloadManager._();
