import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/search.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/tools.dart';

class SearchMangaItem extends StatefulWidget {
  final SearchManga searchManga;

  const SearchMangaItem({Key? key, required this.searchManga}) : super(key: key);

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
                httpHeaders: {
                  'Referer': getReferer(searchManga),
                },
                width: 40,
              ),
            )
          : null,
      trailing: searchManga.hasPosted() ? Text(Jiffy.unixFromMillisecondsSinceEpoch(searchManga.posted.toInt()).fromNow()) : null,
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

          if (!mounted) {
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
