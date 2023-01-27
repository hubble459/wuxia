import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/manga.pb.dart';

class MangaDetails extends StatelessWidget {
  final MangaReply manga;

  const MangaDetails({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Text(manga.countChapters.toString()),
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
                    (manga.hasReadingProgress()
                            ? manga.readingProgress
                            : FlutterI18n.translate(context, 'details.unread'))
                        .toString(),
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
                    manga.hasLast()
                        ? 'Unknown'
                        : Jiffy(manga.last.toInt()).fromNow(),
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
                    manga.hasNext()
                        ? 'Unknown'
                        : Jiffy(manga.next.toInt()).fromNow(),
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
                    manga.isOngoing
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
