import 'package:flutter/material.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/util/session.dart';

class _ChapterRouteData {
  final MangaReply manga;
  final MangaSourceReply source;
  final ChapterReply chapter;

  const _ChapterRouteData({required this.manga, required this.source, required this.chapter});
}

/// Resolves `manga/<id>/source/<sourceId>/chapter/<index>` -- see
/// MangaRouteLoader for why this fetches instead of taking objects directly.
class MangaChapterRouteLoader extends StatefulWidget {
  final int mangaId;
  final int sourceId;
  final int chapterIndex;

  const MangaChapterRouteLoader({super.key, required this.mangaId, required this.sourceId, required this.chapterIndex});

  @override
  State<MangaChapterRouteLoader> createState() => _MangaChapterRouteLoaderState();
}

class _MangaChapterRouteLoaderState extends State<MangaChapterRouteLoader> {
  late final Future<_ChapterRouteData> _future = _load();

  Future<_ChapterRouteData> _load() async {
    await restoreSession();
    if (!API.isLoggedIn) {
      throw StateError('not logged in');
    }

    final manga = await api.manga.get(GetMangaRequest(id: widget.mangaId));
    final source = manga.sources.firstWhere((s) => s.id == widget.sourceId);
    final chapter = await api.chapter.get(ChapterRequest(mangaSourceId: widget.sourceId, index: widget.chapterIndex));

    return _ChapterRouteData(manga: manga, source: source, chapter: chapter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ChapterRouteData>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          if (!API.isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) Navigator.of(context).pushReplacementNamed('login');
            });
            return const Scaffold(body: SizedBox.shrink());
          }
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        final data = snapshot.requireData;
        return MangaChapterScreen(manga: data.manga, chapter: data.chapter, source: data.source);
      },
    );
  }
}
