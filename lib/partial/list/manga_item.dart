import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/dialog/confirm_dialog.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';

typedef ReloadParent = Function(MangaReply manga, bool deleted);

enum HeroScreenType {
  reading,
  latest,
  search,
  downloads;

  String getTag(String url) {
    return '$url$name';
  }
}

class MangaItem extends StatefulWidget {
  final MangaReply manga;
  final HeroScreenType type;
  final ReloadParent reloadParent;

  const MangaItem({super.key, required this.manga, required this.type, required this.reloadParent});

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

  /// Primary source's hostname, falling back to the first available source.
  /// `MangaItem` shows library rows and doesn't track a "current source"
  /// selection the way `MangaScreen` does -- that's picked once you open it.
  String get _hostname {
    final source = _manga.sources.firstWhereOrNull((s) => s.isPrimary) ?? _manga.sources.firstOrNull;
    return source?.hostname ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minVerticalPadding: 4.0,
      contentPadding: EdgeInsets.only(left: 8),
      title: Text(
        _manga.title.replaceAll('\n', ' '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_hostname),
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
              tag: widget.type.getTag(_manga.id.toString()),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                errorListener: (value) => {},
                imageUrl: _manga.cover,
                width: 40,
                height: double.infinity,
                errorWidget: (context, url, error) => ColoredBox(color: Colors.red),
                useOldImageOnUrlChange: true,
                progressIndicatorBuilder: (context, url, progress) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
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
