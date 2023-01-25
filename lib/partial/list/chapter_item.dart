import 'package:flutter/material.dart';
import 'package:wuxia/model/chapter.dart';
import 'package:wuxia/model/paginate.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';

class ChapterItem extends StatelessWidget {
  final Paginate<Chapter> chapters;
  final Reading reading;
  final Chapter chapter;
  final void Function(int progress) refreshParent;

  ChapterItem({Key? key, required this.chapters, required this.reading, required int index, required this.refreshParent})
      : chapter = chapters.data[index],
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
        visible: chapter.posted != null,
        child: Text(chapter.posted?.fromNow() ?? ''),
      ),
      leading: Visibility(
        visible: reading.progress >= chapter.index,
        child: const ColoredBox(
          color: Colors.green,
          child: SizedBox(
            width: 3,
            height: double.infinity,
          ),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Text(chapter.number.toString().replaceFirst('.0', '')),
      ),
      minLeadingWidth: 3,
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => MangaChapterScreen(
              reading: reading,
              chapter: chapter,
            ),
          ),
        )
            .then((data) {
          refreshParent(chapter.index);
        });
      },
    );
  }
}
