import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/reading.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/gen/search.pb.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

class SearchMangaItem extends StatefulWidget {
  final SearchManga searchManga;

  const SearchMangaItem({Key? key, required this.searchManga})
      : super(key: key);

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
      leading: searchManga.cover != null
          ? Image.network(
              searchManga.cover.toString(),
              filterQuality: FilterQuality.none,
              fit: BoxFit.cover,
            )
          : null,
      trailing: searchManga.hasPosted()
          ? Text(Jiffy(searchManga.posted.toInt()).fromNow())
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
          final manga =
              await api.manga.create(MangaRequest(url: searchManga.url));

          if (!mounted) {
            return;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MangaScreen(
                manga: manga,
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
