import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';

class ChapterItem extends StatelessWidget {
  final ChaptersReply chapters;
  final MangaReply manga;
  final ChapterReply chapter;
  final void Function(int progress) refreshParent;

  ChapterItem({super.key, required this.chapters, required this.manga, required int index, required this.refreshParent})
      : chapter = chapters.items[index];

  /// `chapter.index` is a purely per-source position and `readingProgress` is a canonical
  /// rank - the two only coincidentally lined up before multi-source existed. Ordinal is the
  /// one scale genuinely comparable across sources; fall back to the old index comparison
  /// only when ordinal data isn't available (e.g. a manually-unlinked chapter).
  bool get _isRead {
    if (manga.hasProgressOrdinal() && chapter.hasOrdinal()) {
      return manga.progressOrdinal >= chapter.ordinal;
    }
    return manga.readingProgress >= chapter.index.toInt();
  }

  @override
  Widget build(BuildContext context) {
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
        visible: manga.hasReadingProgress() && _isRead,
        child: const ColoredBox(
          color: Colors.green,
          child: SizedBox(
            width: 3,
            height: double.infinity,
          ),
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
            Text(chapter.index.toString())
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
