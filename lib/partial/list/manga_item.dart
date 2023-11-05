import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/partial/dialog/confirm_dialog.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/tools.dart';

typedef ReloadParent = Function(MangaReply manga, bool deleted);

enum HeroScreenType {
  reading,
  latest,
  search;

  getTag(String url) {
    return '$url$name';
  }
}

class MangaItem extends StatefulWidget {
  final MangaReply manga;
  final HeroScreenType type;
  final ReloadParent reloadParent;

  const MangaItem({Key? key, required this.manga, required this.type, required this.reloadParent}) : super(key: key);

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

  bool get isReading {
    return _manga.hasReadingProgress();
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
              _manga.hasLast() ? Jiffy.parseFromMillisecondsSinceEpoch(_manga.last.toInt()).fromNow() : 'Unknown',
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
        ],
      ),
      leading: _manga.hasCover()
          ? Hero(
              tag: widget.type.getTag(_manga.url),
              child: CachedNetworkImage(
                imageUrl: _manga.cover,
                width: 40,
                httpHeaders: {
                  'Referer': getReferer(_manga),
                },
              ),
            )
          : null,
      trailing: SizedBox(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            Center(
              child: isReading
                  ? CircularProgressIndicator(
                      value: _manga.countChapters != 0 ? 1 / _manga.countChapters.toInt() * _manga.readingProgress : 0)
                  : Text(_manga.countChapters.toString()),
            ),
            Visibility(
              visible: isReading && _manga.countChapters - _manga.readingProgress > 0,
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
        final manga = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MangaScreen(
              manga: _manga,
              type: widget.type,
            ),
          ),
        );
        if (mounted) {
          final deletedManga = manga == null;
          if (!deletedManga) {
            _manga = manga;
            setState(() {});
          }
          widget.reloadParent(_manga, deletedManga);
        }
      },
      onLongPress: () async {
        if (isReading) {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => ConfirmDialog(
              message: FlutterI18n.translate(context, 'dialog.confirm.delete', translationParams: {'title': _manga.title}),
            ),
          );
          if (confirmed == true) {
            await api.reading.delete(Id(id: _manga.id));
            widget.reloadParent(_manga, true);
          }
        }
      },
    );
  }
}
