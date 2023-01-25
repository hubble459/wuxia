import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/model/manga.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

class MangaItem extends StatefulWidget {
  final Manga manga;

  const MangaItem({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaItem> createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  late Manga _manga;

  @override
  void initState() {
    _manga = widget.manga;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _manga.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_manga.url.host),
          Visibility(
            visible: _manga.lastChapter != null,
            child: Text(
              _manga.lastChapter?.fromNow() ?? 'Unknown',
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
        ],
      ),
      leading: _manga.cover != null
          ? CachedNetworkImage(
              imageUrl: _manga.cover.toString(),
              width: 40,
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_manga.chapterCount.toString()),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                color: _manga.reading ? Colors.green : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(left: 16.0),
      onTap: () async {
        Reading? reading;
        if (_manga.reading) {
          reading = await api.reading.get(Id(id: _manga.id));
        }
        if (mounted) {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => MangaScreen(
                manga: _manga,
                reading: reading,
              ),
            ),
          )
              .then((value) async {
            _manga = value;
            setState(() {});
          });
        }
      },
    );
  }
}
