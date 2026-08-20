import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/search.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

class SearchMangaItem extends StatefulWidget {
  final SearchManga searchManga;
  final int index;

  /// When set, this search is happening in the context of an already-added
  /// manga (e.g. from "Add Source") -- tapping a result attaches it as a new
  /// source on that manga instead of creating a disconnected duplicate.
  final int? existingMangaId;

  const SearchMangaItem({super.key, required this.searchManga, required this.index, this.existingMangaId});

  @override
  State<SearchMangaItem> createState() => _SearchMangaItemState();
}

class _SearchMangaItemState extends State<SearchMangaItem> {
  @override
  Widget build(BuildContext context) {
    final searchManga = widget.searchManga;
    return ListTile(
      title: Text(
        searchManga.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Expanded(child: Text(Uri.parse(searchManga.url).host)),
          if (searchManga.hasSuggestedMangaId())
            const Tooltip(
              message: 'Might already be a source for a manga you have',
              child: Icon(Icons.merge_type, size: 16),
            ),
        ],
      ),
      leading: searchManga.hasCover()
          ? Hero(
              tag: HeroScreenType.search.getTag('${searchManga.url}_${widget.index}'),
              child: CachedNetworkImage(
                imageUrl: searchManga.cover,
                filterQuality: FilterQuality.none,
                fit: BoxFit.cover,
                useOldImageOnUrlChange: true,
                width: 40,
              ),
            )
          : null,
      trailing: searchManga.hasPosted() ? Text(Jiffy.parseFromMillisecondsSinceEpoch(searchManga.posted.toInt()).fromNow()) : null,
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          useSafeArea: true,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        try {
          final existingMangaId = widget.existingMangaId;
          if (existingMangaId != null) {
            final manga = await api.manga.addSource(AddSourceRequest(mangaId: existingMangaId, url: searchManga.url));

            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop(manga);
            return;
          }

          final manga = await api.manga.findOrCreate(MangaRequest(url: searchManga.url));
          searchManga.mangaId = manga.id;

          if (!context.mounted) {
            return;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MangaScreen(
                manga: manga,
                type: HeroScreenType.search,
                heroTag: HeroScreenType.search.getTag('${searchManga.url}_${widget.index}'),
              ),
            ),
          );
        } catch (_) {
          if (!mounted) {
            return;
          }
          Navigator.of(context).pop();
        }
      },
    );
  }
}
