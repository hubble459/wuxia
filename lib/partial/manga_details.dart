import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/simple_future_builder.dart';

class MangaDetails extends StatelessWidget {
  final MangaReply manga;

  const MangaDetails({Key? key, required this.manga}) : super(key: key);

  Jiffy get nextUpdate {
    return Jiffy.parseFromMillisecondsSinceEpoch(manga.next.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          manga.genres.join(', '),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          manga.title.replaceAll('\n', ' '),
          style: Theme.of(context).textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
        Visibility(
          visible: manga.authors.isNotEmpty,
          child: Text(
            'By ${manga.authors.join(', ')}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Divider(),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(manga.isOngoing ? Icons.update : Icons.update_disabled),
            Text((manga.isOngoing ? 'Ongoing' : manga.status) + ';'),
            manga.hasNext()
                ? Text(
                    FlutterI18n.translate(
                        context, nextUpdate.isBefore(Jiffy.now()) ? 'manga.expected-update' : 'manga.will-update',
                        translationParams: {'date': nextUpdate.fromNow()}),
                    style: nextUpdate.isBefore(Jiffy.now()) ? const TextStyle(color: Colors.red) : null,
                  )
                : Container()
          ],
        ),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.tag),
            Text(
              (manga.hasReadingProgress() ? '${manga.readingProgress}/' : '') +
                  FlutterI18n.translate(context, 'manga.chapters', translationParams: {'amount': manga.countChapters.toString()}),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(manga.description),
        ),
        SimpleFutureBuilder<MangasReply>(
          future: api.manga.similar(Id(id: manga.id)),
          onLoadedBuilder: (context, similar) {
            return Visibility(
              visible: similar.items.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Text(
                    FlutterI18n.translate(context, 'manga.similar'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: similar.items.length,
                    itemBuilder: (context, index) =>
                        MangaItem(manga: similar.items[index], type: HeroScreenType.latest, reloadParent: (manga, _) {}),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
