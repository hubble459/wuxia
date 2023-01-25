import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/model/simple_manga.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

class ReadingItem extends StatefulWidget {
  final Reading reading;
  final Function(Reading reading) removedItem;

  const ReadingItem({Key? key, required this.reading, required this.removedItem}) : super(key: key);

  @override
  State<ReadingItem> createState() => _ReadingItemState();
}

class _ReadingItemState extends State<ReadingItem> {
  late Reading _reading;
  late SimpleManga _manga;

  @override
  void initState() {
    _reading = widget.reading;
    _manga = widget.reading.manga;

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
              _manga.lastChapter!.fromNow(),
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
        ],
      ),
      leading: _manga.cover != null
          ? CachedNetworkImage(
              imageUrl: _manga.cover.toString(),
              width: 40,
              errorWidget: (context, error, stackTrace) => Container(),
            )
          : null,
      trailing: SizedBox(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            Center(
                child:
                    CircularProgressIndicator(value: _manga.chapterCount != 0 ? 1 / _manga.chapterCount * _reading.progress : 0)),
            Visibility(
              visible: _manga.chapterCount - _reading.progress > 0,
              child: Center(
                child: Text(
                  (_manga.chapterCount - _reading.progress).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MangaScreen(reading: _reading, manga: _manga)))
            .then((value) {
          _manga.update(value);
          setState(() {});
        });
      },
      onLongPress: () {
        showDialog(
          context: context,
          barrierLabel: 'delete reading',
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: I18nText('reading.delete'),
            content: I18nText('reading.delete_content', translationParams: {'title': _manga.title}),
            actions: [
              TextButton(
                child: I18nText('basic.cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  FlutterI18n.translate(context, 'basic.confirm'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () async {
                  await api.removeReading(_reading);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pop();
                  widget.removedItem(_reading);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
