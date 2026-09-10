import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';

enum _SourceAdminAction { setPrimary, remove }

/// Shared "pick a source" list, reused by the manga screen, the chapter reader, and the
/// dead-provider recovery dialog. When [allowAdminActions] is set (only passed from the
/// manga screen's own source switcher - not the move-source pickers or the dead-provider
/// recovery flow, where a source's primary/removed state isn't what's being decided), an
/// admin can long-press a source to set it primary or remove it outright. [onSourcesChanged]
/// fires after either of those actually mutates something server-side, so the caller can
/// refresh its own manga data - it's never called for a plain tap-to-switch pick.
Future<MangaSourceReply?> showSourcePickerDialog(
  BuildContext context,
  List<MangaSourceReply> sources, {
  bool allowAdminActions = false,
  VoidCallback? onSourcesChanged,
}) {
  return showDialog<MangaSourceReply>(
    context: context,
    builder: (ctx) => _SourcePickerDialog(
      sources: sources,
      allowAdminActions: allowAdminActions && API.loggedIn.isAdmin,
      onSourcesChanged: onSourcesChanged,
    ),
  );
}

class _SourcePickerDialog extends StatefulWidget {
  final List<MangaSourceReply> sources;
  final bool allowAdminActions;
  final VoidCallback? onSourcesChanged;

  const _SourcePickerDialog({
    required this.sources,
    required this.allowAdminActions,
    required this.onSourcesChanged,
  });

  @override
  State<_SourcePickerDialog> createState() => _SourcePickerDialogState();
}

class _SourcePickerDialogState extends State<_SourcePickerDialog> {
  late final List<MangaSourceReply> _sources = widget.sources.toList();

  // null = still loading (or failed - not worth surfacing an error for a
  // count that's a nice-to-have, so a source's row just stays blank).
  final Map<int, int?> _chapterCounts = {};

  @override
  void initState() {
    super.initState();
    for (final source in _sources) {
      _loadChapterCount(source);
    }
  }

  Future<void> _loadChapterCount(MangaSourceReply source) async {
    try {
      // perPage: 1 - only PaginateReply.total is actually wanted here.
      final result = await api.chapter.index(PaginateChapterQuery(
        mangaSourceId: source.id,
        paginateQuery: PaginateQuery(page: Int64.ZERO, perPage: Int64.ONE),
      ));
      if (mounted) setState(() => _chapterCounts[source.id] = result.pagination.total.toInt());
    } catch (_) {
      // Leave it blank - see _chapterCounts doc comment above.
    }
  }

  Future<void> _setPrimary(MangaSourceReply source) async {
    try {
      await api.manga.setPrimarySource(SetPrimarySourceRequest(mangaSourceId: source.id));
      if (!mounted) return;
      setState(() {
        for (final s in _sources) {
          s.isPrimary = s.id == source.id;
        }
      });
      widget.onSourcesChanged?.call();
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _remove(MangaSourceReply source) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(FlutterI18n.translate(ctx, 'manga.remove-source-confirm-title')),
            content: Text(FlutterI18n.translate(
              ctx,
              'manga.remove-source-confirm-body',
              translationParams: {'hostname': source.hostname},
            )),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(FlutterI18n.translate(ctx, 'basic.cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(FlutterI18n.translate(ctx, 'basic.confirm')),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !mounted) return;

    try {
      await api.manga.removeSource(RemoveSourceRequest(mangaSourceId: source.id));
      if (!mounted) return;
      setState(() {
        _sources.removeWhere((s) => s.id == source.id);
      });
      widget.onSourcesChanged?.call();
      if (_sources.isEmpty && mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _showAdminMenu(MangaSourceReply source) async {
    final action = await showDialog<_SourceAdminAction>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(source.hostname),
        children: [
          if (!source.isPrimary)
            SimpleDialogOption(
              onPressed: () => Navigator.of(ctx).pop(_SourceAdminAction.setPrimary),
              child: Text(FlutterI18n.translate(ctx, 'manga.set-primary-source')),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(ctx).pop(_SourceAdminAction.remove),
            child: Text(
              FlutterI18n.translate(ctx, 'manga.remove-source'),
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (!mounted) return;

    switch (action) {
      case _SourceAdminAction.setPrimary:
        await _setPrimary(source);
      case _SourceAdminAction.remove:
        await _remove(source);
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(FlutterI18n.translate(context, 'manga.switch_source')),
      children: _sources.map((source) {
        final chapterCount = _chapterCounts[source.id];
        return InkWell(
          onTap: () => Navigator.of(context).pop(source),
          onLongPress: widget.allowAdminActions ? () => _showAdminMenu(source) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${source.hostname} (${source.language})'),
                      if (chapterCount != null)
                        Text(
                          FlutterI18n.translate(context, 'manga.chapters', translationParams: {'amount': chapterCount.toString()}),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                        ),
                    ],
                  ),
                ),
                if (source.isPrimary)
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(Icons.star, size: 16),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
