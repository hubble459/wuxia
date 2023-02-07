import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/chapter.pb.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';

class ChapterItem extends StatelessWidget {
  final ChaptersReply chapters;
  final MangaReply manga;
  final ChapterReply chapter;
  final void Function(int progress) refreshParent;

  ChapterItem({Key? key, required this.chapters, required this.manga, required int index, required this.refreshParent})
      : chapter = chapters.items[index],
        super(key: key);

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
        child: Text(chapter.hasPosted() ? Jiffy.unixFromMillisecondsSinceEpoch(chapter.posted.toInt()).fromNow() : ''),
      ),
      leading: Visibility(
        visible: manga.hasReadingProgress() && manga.readingProgress >= chapter.index.toInt(),
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
      onTap: () {
        manga.readingProgress = chapter.index.toInt();
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => MangaChapterScreen(
              manga: manga,
              chapter: chapter,
            ),
          ),
        )
            .then((data) {
          refreshParent(chapter.index.toInt());
        });
      },
    );
  }
}
