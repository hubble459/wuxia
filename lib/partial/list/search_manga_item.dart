import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/model/search_manga.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

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
      subtitle: Text(searchManga.url.host),
      leading: searchManga.cover != null
          ? Image.network(
              searchManga.cover.toString(),
              filterQuality: FilterQuality.none,
              fit: BoxFit.cover,
            )
          : null,
      trailing: searchManga.updated != null ? Text(searchManga.updated!.fromNow()) : null,
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
          log(searchManga.url.toString());
          final manga = await api.addManga(searchManga.url);
          Reading? reading;
          if (manga.reading) {
            reading = await api.reading(manga.id);
          }

          if (!mounted) {
            return;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MangaScreen(
                manga: manga,
                reading: reading,
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
