import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/search.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/tools.dart';

class SearchMangaItem extends StatefulWidget {
  final SearchManga searchManga;

  const SearchMangaItem({super.key, required this.searchManga});

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
      subtitle: Text(Uri.parse(searchManga.url).host),
      leading: searchManga.hasCover()
          ? Hero(
              tag: HeroScreenType.search.getTag(searchManga.url),
              child: CachedNetworkImage(
                imageUrl: searchManga.cover,
                filterQuality: FilterQuality.none,
                fit: BoxFit.cover,
                useOldImageOnUrlChange: true,
                httpHeaders: {
                  'Referer': getReferer(searchManga),
                  'Origin': Uri.parse(searchManga.url).origin,
                },
                width: 40,
              ),
            )
          : null,
      trailing:
          searchManga.hasPosted()
            ? Text(Jiffy.parseFromMillisecondsSinceEpoch(searchManga.posted.toInt()).fromNow()) 
            : null,
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
