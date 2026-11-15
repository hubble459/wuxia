import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/partial/download_reconnect.dart';
import 'package:wuxia/partial/download_task_tile.dart';
import 'package:wuxia/util/download_manager.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/tools.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/responsive_content.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  late Future<List<MangaReply>> _future;
  late final StreamSubscription<void> _downloadCompleted;

  @override
  void initState() {
    super.initState();
    _future = _loadDownloaded();
    _downloadCompleted = downloadManager.completed.listen((_) => _reload());
  }

  @override
  void dispose() {
    _downloadCompleted.cancel();
    super.dispose();
  }

  bool _needsPermission = false;

  /// Hostnames of each downloaded manga's downloaded sources, by manga id.
  Map<int, List<String>> _downloadedHostnames = {};

  /// By manga id, how many chapters each downloaded source (by hostname)
  /// has beyond its last finished download. Only holds sources that are
  /// behind, and only manga with at least one such source.
  Map<int, Map<String, int>> _newChapters = {};

  Future<List<MangaReply>> _loadDownloaded() async {
    final needsPermission = await downloadStorage.status() == DownloadStorageStatus.needsPermission;
    if (mounted && needsPermission != _needsPermission) setState(() => _needsPermission = needsPermission);
    if (needsPermission) return [];

    final results = (await listDownloadedManga()).values.toList();
    results.sort((a, b) => a.title.compareTo(b.title));
    final sources = {for (final manga in results) manga.id: await listDownloadedSources(manga.id)};
    final hostnames = <int, List<String>>{
      for (final manga in results)
        manga.id: [
          for (final source in sources[manga.id]!)
            manga.sources.where((s) => s.id == source.sourceId).firstOrNull?.hostname ?? '#${source.sourceId}',
        ],
    };
    if (mounted) setState(() => _downloadedHostnames = hostnames);
    unawaited(_checkUpdates(results, sources, hostnames));
    return results;
  }

  /// Fills [_newChapters] from each manga's current chapter counts, falling
  /// back to its download-time snapshot when it can't be fetched.
  Future<void> _checkUpdates(
    List<MangaReply> mangas,
    Map<int, List<DownloadedSource>> sources,
    Map<int, List<String>> hostnames,
  ) async {
    final updates = await Future.wait(
      mangas.map((manga) async {
        MangaReply current;
        try {
          current = await api.manga.get(GetMangaRequest(id: manga.id));
        } catch (_) {
          current = manga;
        }
        final behind = <String, int>{};
        final downloaded = sources[manga.id]!;
        for (var i = 0; i < downloaded.length; i++) {
          final source = current.sources.where((s) => s.id == downloaded[i].sourceId).firstOrNull;
          final missing = source == null ? 0 : source.countChapters.toInt() - downloaded[i].completedChapters;
          if (missing > 0) behind[hostnames[manga.id]![i]] = missing;
        }
        return MapEntry(manga.id, behind);
      }),
    );
    if (mounted) setState(() => _newChapters = Map.fromEntries(updates.where((e) => e.value.isNotEmpty)));
  }

  void _reload() {
    setState(() {
      _future = _loadDownloaded();
    });
  }

  Widget _reconnectPrompt() {
    return FutureBuilder<String?>(
      future: downloadStorage.location(),
      builder: (context, snapshot) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.folder_off, size: 48),
              const SizedBox(height: 12),
              Text(
                FlutterI18n.translate(context, 'downloads.reconnect_message', translationParams: {'folder': snapshot.data ?? ''}),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  if (await reconnectDownloads(context)) _reload();
                },
                child: Text(FlutterI18n.translate(context, 'downloads.reconnect')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContent(
      child: ListenableBuilder(
        listenable: downloadManager,
        builder: (context, _) => FutureBuilder<List<MangaReply>>(
          future: _future,
          builder: (context, snapshot) {
            final tasks = downloadManager.tasks;
            if (snapshot.connectionState != ConnectionState.done && tasks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_needsPermission) return _reconnectPrompt();
            final items = snapshot.data ?? [];
            if (items.isEmpty && tasks.isEmpty) {
              return Center(child: Text(FlutterI18n.translate(context, 'empty')));
            }
            final theme = Theme.of(context);
            Widget header(String key) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(FlutterI18n.translate(context, key), style: theme.textTheme.titleSmall),
            );
            Widget item(MangaReply manga) => MangaItem(
              key: Key('dl_${manga.id}'),
              manga: manga,
              type: HeroScreenType.downloads,
              reloadParent: (_, _) => _reload(),
              hostnames: _downloadedHostnames[manga.id],
              newChapters: _newChapters[manga.id],
            );
            final updatable = items.where((m) => _newChapters.containsKey(m.id)).toList();
            final upToDate = items.where((m) => !_newChapters.containsKey(m.id)).toList();
            final sectioned = tasks.isNotEmpty || updatable.isNotEmpty;
            return RefreshIndicator(
              onRefresh: () async => _reload(),
              child: ListView(
                children: [
                  if (tasks.isNotEmpty) ...[
                    header('downloads.queue'),
                    for (final task in tasks) DownloadTaskTile(key: ObjectKey(task), task: task),
                  ],
                  if (updatable.isNotEmpty) ...[header('downloads.update_available'), for (final manga in updatable) item(manga)],
                  if (upToDate.isNotEmpty) ...[
                    if (sectioned) header('downloads.downloaded'),
                    for (final manga in upToDate) item(manga),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
