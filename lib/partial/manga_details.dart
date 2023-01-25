import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/model/manga.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/model/simple_manga.dart';

class MangaDetails extends StatelessWidget {
  final SimpleManga manga;
  final Reading? reading;

  const MangaDetails({Key? key, required this.manga, this.reading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Manga manga = this.manga is Manga ? this.manga as Manga : this.manga.toManga();

    return Column(children: [
      Table(
          border: TableBorder.symmetric(
            inside: const BorderSide(width: 1),
          ),
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.alt_titles'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.altTitles.join(';\n'),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.authors'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.authors.join('; '),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.genres'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.genres.join('; '),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'manga.chapters'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(manga.chapterCount.toString()),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.read'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    (reading != null ? reading!.progress : FlutterI18n.translate(context, 'details.unread')).toString(),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.updated'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.lastChapter == null ? 'Unknown' : manga.lastChapter!.fromNow(),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.next_chapter'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.nextChapter == null ? 'Unknown' : manga.nextChapter!.fromNow(),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    FlutterI18n.translate(context, 'details.status'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    manga.ongoing
                        ? FlutterI18n.translate(context, 'details.ongoing')
                        : FlutterI18n.translate(context, 'details.finished'),
                  ),
                )
              ],
            ),
          ]),
    ]);
  }
}
