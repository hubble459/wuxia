import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/partial/action/export_cbz_action.dart';
import 'package:wuxia/partial/dialog/confirm_dialog.dart';
import 'package:wuxia/partial/cover_image.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/source_health.dart';
import 'package:wuxia/util/tools.dart';

typedef ReloadParent = Function(MangaReply manga, bool deleted);

/// Asks for confirmation before deleting [manga] for everyone (not just from your reading list).
Future<bool> confirmDeleteManga(BuildContext context, MangaReply manga) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => ConfirmDialog(
      message: FlutterI18n.translate(context, 'dialog.confirm.delete_manga', translationParams: {'title': manga.title}),
    ),
  );
  return confirmed == true;
}

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

  /// Shown instead of the primary source's hostname, e.g. the downloaded
  /// sources on the downloads screen.
  final List<String>? hostnames;

  /// How many new chapters each of [hostnames] has beyond its download,
  /// shown as "+N" next to it. Hostnames that aren't behind are left out.
  final Map<String, int>? newChapters;

  const MangaItem({
    super.key,
    required this.manga,
    required this.type,
    required this.reloadParent,
    this.hostnames,
    this.newChapters,
  });

  @override
  State<MangaItem> createState() => _MangaItemState();
}

class _MangaItemState extends State<MangaItem> {
  late MangaReply _manga;

  @override
  void initState() {
    _manga = widget.manga;
    SourceHealth.refresh();
    super.initState();
  }

  @override
  void didUpdateWidget(MangaItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.manga.id != _manga.id) {
      _manga = widget.manga;
    }
  }

  bool get isReading {
    return isInReadingList(_manga);
  }

  /// [MangaItem.hostnames] when given, otherwise the primary source's
  /// hostname, falling back to the first available source.
  /// `MangaItem` shows library rows and doesn't track a "current source"
  /// selection the way `MangaScreen` does -- that's picked once you open it.
  String get _hostname {
    final hostnames = widget.hostnames;
    if (hostnames != null && hostnames.isNotEmpty) return hostnames.join(', ');
    final source = _manga.sources.firstWhereOrNull((s) => s.isPrimary) ?? _manga.sources.firstOrNull;
    return source?.hostname ?? '';
  }

  /// [_hostname], with "+N" after each hostname in [MangaItem.newChapters].
  Widget _hostnameText(BuildContext context) {
    final hostnames = widget.hostnames;
    final newChapters = widget.newChapters;
    if (hostnames == null || hostnames.isEmpty || newChapters == null || newChapters.isEmpty) {
      return Text(_hostname, overflow: TextOverflow.ellipsis);
    }
    final highlight = TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold);
    return Text.rich(
      TextSpan(
        children: [
          for (final (i, hostname) in hostnames.indexed) ...[
            if (i > 0) const TextSpan(text: ', '),
            TextSpan(text: hostname),
            if ((newChapters[hostname] ?? 0) > 0) TextSpan(text: ' +${newChapters[hostname]}', style: highlight),
          ],
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// With more than one downloaded source, asks which one, titled
  /// [titleKey], offering "All sources" too when [allOption] is set.
  /// Returns its source id, `0` for all sources (or when there's only one),
  /// or `null` when cancelled.
  Future<int?> _pickDownloadedSource(String titleKey, {bool allOption = false}) async {
    final sources = await listDownloadedSources(_manga.id);
    if (sources.length <= 1 || !mounted) return 0;
    String hostname(int id) => _manga.sources.where((s) => s.id == id).firstOrNull?.hostname ?? '#$id';
    return showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(FlutterI18n.translate(ctx, titleKey)),
        children: [
          for (final source in sources)
            SimpleDialogOption(onPressed: () => Navigator.of(ctx).pop(source.sourceId), child: Text(hostname(source.sourceId))),
          if (allOption)
            SimpleDialogOption(
              onPressed: () => Navigator.of(ctx).pop(0),
              child: Text(FlutterI18n.translate(ctx, 'downloads.delete_all_sources')),
            ),
        ],
      ),
    );
  }

  /// Offers exporting next to deleting. Returns whether delete was chosen.
  Future<bool> _downloadMenu() async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.archive),
              title: Text(FlutterI18n.translate(ctx, 'downloads.export_cbz')),
              onTap: () => Navigator.of(ctx).pop('export'),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(FlutterI18n.translate(ctx, 'downloads.delete'), style: const TextStyle(color: Colors.red)),
              onTap: () => Navigator.of(ctx).pop('delete'),
            ),
          ],
        ),
      ),
    );
    if (action == 'export') {
      final sourceId = await _pickDownloadedSource('downloads.export_which');
      if (sourceId != null && mounted) await exportMangaCbz(context, _manga.id, sourceId: sourceId == 0 ? null : sourceId);
    }
    return action == 'delete';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: SourceHealth.down,
      builder: (context, down, _) {
        final unavailable = SourceHealth.allSourcesDown(_manga, down);
        final tile = _buildTile(context, unavailable: unavailable);
        return unavailable ? Opacity(opacity: 0.5, child: tile) : tile;
      },
    );
  }

  Widget _buildTile(BuildContext context, {required bool unavailable}) {
    return ListTile(
      dense: true,
      minVerticalPadding: 4.0,
      contentPadding: EdgeInsets.only(left: 8),
      title: Text(_manga.title.replaceAll('\n', ' '), maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (unavailable)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Tooltip(
                    message: FlutterI18n.translate(context, 'manga.source_down'),
                    child: const Icon(Icons.cloud_off, size: 14),
                  ),
                ),
              Flexible(child: _hostnameText(context)),
            ],
          ),
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
              child: CoverImage(
                manga: _manga,
                fit: BoxFit.fill,
                width: 40,
                height: double.infinity,
                useOldImageOnUrlChange: true,
                progressIndicatorBuilder: (context, url, progress) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(value: progress.progress),
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
                      value: _manga.countChapters != 0 ? 1 / _manga.countChapters.toInt() * _manga.readingProgress : 0,
                    )
                  : Text(_manga.countChapters.toString()),
            ),
            Visibility(
              visible: isReading && _manga.countChapters - _manga.readingProgress > 0,
              child: Center(child: Text((_manga.countChapters - _manga.readingProgress).toString(), textAlign: TextAlign.center)),
            ),
          ],
        ),
      ),
      onTap: () async {
        final manga = await Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(name: mangaRouteName(_manga.id)),
            builder: (context) => MangaScreen(manga: _manga, type: widget.type),
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
        if (widget.type == HeroScreenType.downloads) {
          if (!await _downloadMenu()) return;
          final sourceId = await _pickDownloadedSource('downloads.delete_which', allOption: true);
          if (sourceId == null || !context.mounted) return;
          final hostname = _manga.sources.where((s) => s.id == sourceId).firstOrNull?.hostname ?? '#$sourceId';
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => ConfirmDialog(
              message: sourceId == 0
                  ? FlutterI18n.translate(context, 'dialog.confirm.delete_download', translationParams: {'title': _manga.title})
                  : FlutterI18n.translate(
                      context,
                      'dialog.confirm.delete_download_source',
                      translationParams: {'title': _manga.title, 'hostname': hostname},
                    ),
            ),
          );
          if (confirmed != true) return;
          if (sourceId == 0) {
            await deleteDownloadedManga(_manga.id);
          } else {
            await deleteDownloadedSource(_manga.id, sourceId);
          }
          widget.reloadParent(_manga, true);
        } else if (isReading) {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => ConfirmDialog(
              message: FlutterI18n.translate(context, 'dialog.confirm.delete', translationParams: {'title': _manga.title}),
            ),
          );
          if (confirmed == true) {
            await api.reading.delete(DeleteReadingRequest(mangaId: _manga.id));
            widget.reloadParent(_manga, true);
          }
        } else if (API.loggedIn.isModOrAdmin) {
          if (!await confirmDeleteManga(context, _manga)) return;
          try {
            await api.manga.delete(DeleteMangaRequest(id: _manga.id));
            widget.reloadParent(_manga, true);
          } catch (e) {
            Fluttertoast.showToast(msg: e.toString());
          }
        }
      },
    );
  }
}
