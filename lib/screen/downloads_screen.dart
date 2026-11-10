import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/partial/download_reconnect.dart';
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

  @override
  void initState() {
    super.initState();
    _future = _loadDownloaded();
  }

  bool _needsPermission = false;

  Future<List<MangaReply>> _loadDownloaded() async {
    final needsPermission = await downloadStorage.status() == DownloadStorageStatus.needsPermission;
    if (mounted && needsPermission != _needsPermission) setState(() => _needsPermission = needsPermission);
    if (needsPermission) return [];

    final results = (await listDownloadedManga()).values.toList();
    results.sort((a, b) => a.title.compareTo(b.title));
    return results;
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
                FlutterI18n.translate(context, 'downloads.reconnect_message',
                    translationParams: {'folder': snapshot.data ?? ''}),
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
      child: FutureBuilder<List<MangaReply>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_needsPermission) return _reconnectPrompt();
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return Center(child: Text(FlutterI18n.translate(context, 'empty')));
          }
          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final manga = items[index];
                return MangaItem(
                  key: Key('dl_${manga.id}'),
                  manga: manga,
                  type: HeroScreenType.downloads,
                  reloadParent: (_, _) => _reload(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
