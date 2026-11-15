import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/dialog/missing_chapter_dialog.dart';
import 'package:wuxia/util/tools.dart';

class ChapterItem extends StatelessWidget {
  final ChaptersReply chapters;
  final MangaReply manga;
  final ChapterReply chapter;
  final void Function(int progress) refreshParent;

  /// The source the list is of, and what to do when a chapter it doesn't have is tapped
  /// (see `ChapterReply.missing`).
  final MangaSourceReply? source;
  final VoidCallback? openMissing;

  ChapterItem({
    super.key,
    required this.chapters,
    required this.manga,
    required int index,
    required this.refreshParent,
    this.source,
    this.openMissing,
  }) : chapter = chapters.items[index];

  @override
  Widget build(BuildContext context) {
    if (chapter.missing) {
      final disabled = Theme.of(context).disabledColor;
      return ListTile(
        title: Text('Chapter ${chapterNumberLabel(chapter)}', style: TextStyle(color: disabled)),
        subtitle: source == null
            ? null
            : Text(
                FlutterI18n.translate(context, 'chapter.missing_hint', translationParams: {'source': source!.hostname}),
                style: TextStyle(color: disabled),
              ),
        leading: const SizedBox(width: 3),
        trailing: Padding(padding: const EdgeInsets.all(16.0), child: Icon(Icons.open_in_new, size: 18, color: disabled)),
        minLeadingWidth: 3,
        contentPadding: EdgeInsets.zero,
        onTap: openMissing,
      );
    }
    return ListTile(
      title: Text(
        chapter.title.isEmpty ? 'Chapter ${chapter.number}' : chapter.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Visibility(
        visible: chapter.hasPosted(),
        child: Text(chapter.hasPosted() ? Jiffy.parseFromMillisecondsSinceEpoch(chapter.posted.toInt()).fromNow() : ''),
      ),
      leading: Visibility(
        visible: manga.hasReadingProgress() && isChapterRead(manga, chapter),
        child: const ColoredBox(
          color: Colors.green,
          child: SizedBox(width: 3, height: double.infinity),
        ),
      ),
      // trailing: Padding(
      //   padding: const EdgeInsets.only(right: 16.0),
      //   child: Text(chapter.number
      //       .toStringAsFixed(3)
      //       .replaceFirst(RegExp(r'\.?0+$'), '', chapter.number.toStringAsFixed(3).lastIndexOf('.'))),
      // ),
      trailing: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text(chapter.number
            //     .toStringAsFixed(3)
            //     .replaceFirst(RegExp(r'\.?0+$'), '', chapter.number.toStringAsFixed(3).lastIndexOf('.'))),
            Text(chapter.index.toString()),
          ],
        ),
      ),
      minLeadingWidth: 3,
      contentPadding: EdgeInsets.zero,
      onTap: () async {
        manga.readingProgress = chapter.index.toInt();
        refreshParent(chapter.index.toInt());
      },
    );
  }
}
