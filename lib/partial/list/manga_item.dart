import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/reading.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

class MangaItem extends StatefulWidget {
  final MangaReply manga;

  const MangaItem({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaItem> createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  late MangaReply _manga;

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
          Text(Uri.parse(_manga.url).host),
          Visibility(
            visible: _manga.hasLast(),
            child: Text(
              _manga.hasLast()
                  ? Jiffy(_manga.last.toInt()).fromNow()
                  : 'Unknown',
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
      // trailing: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Text(),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Container(
      //         height: 5,
      //         width: 5,
      //         decoration: BoxDecoration(
      //           color: _manga.hasReadingProgress()
      //               ? Colors.green
      //               : Colors.transparent,
      //           shape: BoxShape.circle,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      trailing: SizedBox(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            Center(
                child: _manga.hasReadingProgress()
                    ? CircularProgressIndicator(
                        value: _manga.countChapters != 0
                            ? 1 /
                                _manga.countChapters.toInt() *
                                _manga.readingProgress
                            : 0)
                    : Text(_manga.countChapters.toString())),
            Visibility(
              visible: _manga.hasReadingProgress() &&
                  _manga.countChapters - _manga.readingProgress > 0,
              child: Center(
                child: Text(
                  (_manga.countChapters - _manga.readingProgress).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 16.0),
      onTap: () async {
        if (mounted) {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => MangaScreen(
                manga: _manga,
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
