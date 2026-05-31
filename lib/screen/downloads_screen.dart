import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/util/tools.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';

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

  Future<List<MangaReply>> _loadDownloaded() async {
    final dir = await getDownloadDirectory();
    final results = <MangaReply>[];

    await for (final entry in dir.list()) {
      if (entry is! Directory) continue;
      final pbFile = File('${entry.path}/manga.pb');
      if (!await pbFile.exists()) continue;
      try {
        final bytes = await pbFile.readAsBytes();
        results.add(MangaReply.fromBuffer(bytes));
      } catch (_) {}
    }

    results.sort((a, b) => a.title.compareTo(b.title));
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MangaReply>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(child: Text(FlutterI18n.translate(context, 'empty')));
        }
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _future = _loadDownloaded();
            });
          },
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final manga = items[index];
              return MangaItem(
                key: Key('dl_${manga.id}'),
                manga: manga,
                type: HeroScreenType.downloads,
                reloadParent: (_, __) {
                  setState(() {
                    _future = _loadDownloaded();
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
