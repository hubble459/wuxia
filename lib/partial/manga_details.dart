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
                    manga.altTitles.isNotEmpty ? manga.altTitles.join(';\n') : 'None',
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
            ...(manga.hasReadingProgress()
                ? [
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
                            manga.readingProgress.toString(),
                          ),
                        ),
                      ],
                    )
                  ]
                : []),
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
                    manga.hasLast() ? Jiffy.unixFromMillisecondsSinceEpoch(manga.last.toInt()).fromNow() : 'Unknown',
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
                    manga.hasNext() ? Jiffy.unixFromMillisecondsSinceEpoch(manga.next.toInt()).fromNow() : 'Unknown',
                    style: manga.hasNext() && manga.next < DateTime.now().millisecondsSinceEpoch
                        ? const TextStyle(color: Colors.red)
                        : null,
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(manga.description),
      )
    ]);
  }
}
