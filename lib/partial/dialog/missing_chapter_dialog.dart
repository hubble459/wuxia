import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/tools.dart';

String chapterNumberLabel(ChapterReply chapter) => chapter.number.toStringAsFixed(1).replaceAll('.0', '');

/// For a chapter the current source doesn't have: lets the user pick a source that has it
/// and returns that source with its chapter, or null when there's none or none was picked.
Future<(MangaSourceReply, ChapterReply)?> pickSourceWithChapter(
  BuildContext context,
  MangaReply manga,
  ChapterReply chapter,
) async {
  final sources = manga.sources.where((s) => chapter.availableSourceIds.contains(s.id)).toList();
  if (sources.isEmpty) {
    Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'chapter.not_on_source')).ignore();
    return null;
  }

  final source = await showDialog<MangaSourceReply>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: Text(
        FlutterI18n.translate(ctx, 'chapter.missing_open_on', translationParams: {'number': chapterNumberLabel(chapter)}),
      ),
      children: [
        for (final source in sources)
          SimpleDialogOption(onPressed: () => Navigator.of(ctx).pop(source), child: Text(source.hostname)),
      ],
    ),
  );
  if (source == null) return null;

  try {
    final found = await api.chapter.findEquivalent(
      FindEquivalentRequest(canonicalChapterId: chapter.canonicalChapterId, mangaSourceId: source.id),
    );
    return (source, found);
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString()).ignore();
    return null;
  }
}

/// Like [pickSourceWithChapter], then opens the chapter there. Completes once the reader
/// is closed again (or nothing was picked).
Future<void> openMissingChapter(BuildContext context, MangaReply manga, ChapterReply chapter) async {
  final picked = await pickSourceWithChapter(context, manga, chapter);
  if (picked == null || !context.mounted) return;
  final (source, found) = picked;

  setReadingProgress(manga, found.index.toInt());
  await syncReadingProgress(manga, progress: manga.readingProgress, chapterId: found.id);
  if (!context.mounted) return;
  await Navigator.of(context).push(
    MaterialPageRoute(
      settings: RouteSettings(name: chapterRouteNameFor(mangaId: manga.id, chapter: found)),
      builder: (context) => MangaChapterScreen(manga: manga, chapter: found, source: source),
    ),
  );
}
