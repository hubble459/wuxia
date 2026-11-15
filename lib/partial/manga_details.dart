import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/anilist_status_button.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/util/tools.dart';

class MangaDetails extends StatelessWidget {
  final MangaReply manga;

  /// Whether to render the title/alt-titles block. Set to false on desktop,
  /// where MangaScreen renders that block itself alongside the cover.
  final bool showTitle;

  const MangaDetails({super.key, required this.manga, this.showTitle = true});

  Jiffy get nextUpdate {
    return Jiffy.parseFromMillisecondsSinceEpoch(manga.next.toInt());
  }

  /// The AniList score (or just "AniList"), opening the AniList page when tapped.
  Widget _anilistLink(BuildContext context) {
    final text = manga.anilist.hasScore()
        ? FlutterI18n.translate(context, 'anilist.score', translationParams: {'score': '${manga.anilist.score}'})
        : 'AniList';
    final parts = text.split('AniList');
    final linkStyle = TextStyle(color: Theme.of(context).colorScheme.primary);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrlString(manga.anilist.url, mode: LaunchMode.externalApplication),
        child: Text.rich(
          TextSpan(
            children: [
              for (var i = 0; i < parts.length; i++) ...[
                TextSpan(text: parts[i]),
                if (i < parts.length - 1) TextSpan(text: 'AniList', style: linkStyle),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          [
            if (manga.origin != MangaOrigin.ORIGIN_UNKNOWN) FlutterI18n.translate(context, 'origin.${manga.origin.key}'),
            ...manga.genres,
          ].join(', '),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (showTitle) ...[
          Text(
            manga.title.replaceAll('\n', ' '),
            style: Theme.of(context).textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
          if (manga.altTitles.isNotEmpty)
            Text(
              manga.altTitles.join(' · '),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
        ],
        Visibility(
          visible: manga.authors.isNotEmpty,
          child: Text('By ${manga.authors.join(', ')}', style: Theme.of(context).textTheme.bodyMedium),
        ),
        Divider(),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(manga.isOngoing ? Icons.update : Icons.update_disabled),
            Text('${manga.isOngoing ? 'Ongoing' : manga.status};'),
            manga.isOngoing && manga.hasNext()
                ? Text(
                    FlutterI18n.translate(
                      context,
                      nextUpdate.isBefore(Jiffy.now()) ? 'manga.expected-update' : 'manga.will-update',
                      translationParams: {'date': nextUpdate.fromNow()},
                    ),
                    style: nextUpdate.isBefore(Jiffy.now()) ? const TextStyle(color: Colors.red) : null,
                  )
                : manga.hasLast()
                ? Text(
                    FlutterI18n.translate(
                      context,
                      'manga.last-updated',
                      translationParams: {'date': Jiffy.parseFromMillisecondsSinceEpoch(manga.last.toInt()).fromNow()},
                    ),
                  )
                : Container(),
          ],
        ),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.tag),
            Text(
              (isInReadingList(manga) ? '${manga.readingProgress}/' : '') +
                  FlutterI18n.translate(context, 'manga.chapters', translationParams: {'amount': manga.countChapters.toString()}),
            ),
          ],
        ),
        if (manga.hasAnilist())
          Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.star_outline),
              _anilistLink(context),
              AnilistStatusButton(mangaId: manga.id),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(manga.description.trim().isEmpty && manga.hasAnilist() ? manga.anilist.description : manga.description),
        ),
        SimpleFutureBuilder<MangasReply>(
          future: api.manga.similar(SimilarMangaRequest(id: manga.id)),
          onErrorBuilder: (_, _) => const SizedBox.shrink(),
          onLoadedBuilder: (context, similar) {
            return Visibility(
              visible: similar.items.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Text(FlutterI18n.translate(context, 'manga.similar'), style: Theme.of(context).textTheme.titleLarge),
                  for (final item in similar.items)
                    MangaItem(
                      key: Key(item.id.toString()),
                      manga: item,
                      type: HeroScreenType.latest,
                      reloadParent: (manga, _) {},
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
