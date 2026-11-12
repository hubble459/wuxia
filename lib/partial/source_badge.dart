import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/util/source_health.dart';
import 'package:wuxia/util/tools.dart';

/// Floating pill naming the selected source, in the top right corner just below the app
/// bar, that unfolds into a list of the manga's sources to switch between. Mods and admins
/// can long-press a source to make it the primary one.
///
/// Fills its parent (put it in a `Positioned.fill` over the screen's body): while the list
/// is open, a tap anywhere else closes it.
class SourceBadge extends StatefulWidget {
  final int mangaId;
  final List<MangaSourceReply> sources;
  final MangaSourceReply selected;
  final ValueChanged<MangaSourceReply> onSelected;

  /// After a source was made primary.
  final VoidCallback onSourcesChanged;

  /// Distance from the top of the parent, i.e. the app bar's height.
  final double top;

  const SourceBadge({
    super.key,
    required this.mangaId,
    required this.sources,
    required this.selected,
    required this.onSelected,
    required this.onSourcesChanged,
    required this.top,
  });

  @override
  State<SourceBadge> createState() => _SourceBadgeState();
}

class _SourceBadgeState extends State<SourceBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    reverseDuration: const Duration(milliseconds: 160),
  );
  late final Animation<double> _unfold = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );

  bool get _open => _controller.status == AnimationStatus.forward || _controller.status == AnimationStatus.completed;

  Set<int> _downloaded = {};

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_open) {
      _controller.reverse();
      return;
    }
    SourceHealth.refresh();
    _loadDownloaded();
    _controller.forward();
  }

  Future<void> _loadDownloaded() async {
    if (!downloadsSupported) return;
    final downloaded = {for (final source in await listDownloadedSources(widget.mangaId)) source.sourceId};
    if (mounted) setState(() => _downloaded = downloaded);
  }

  void _select(MangaSourceReply source) {
    _controller.reverse();
    if (source.id != widget.selected.id) widget.onSelected(source);
  }

  Future<void> _makePrimary(MangaSourceReply source) async {
    if (!API.loggedIn.isModOrAdmin || source.isPrimary) return;
    HapticFeedback.mediumImpact().ignore();
    try {
      await api.manga.setPrimarySource(SetPrimarySourceRequest(mangaSourceId: source.id));
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, 'manga.primary_set', translationParams: {'hostname': source.hostname}),
      ).ignore();
      widget.onSourcesChanged();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString()).ignore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 24).clamp(0.0, 360.0);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.6;

    return Stack(
      children: [
        if (_open)
          Positioned.fill(
            child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: _toggle),
          ),
        Positioned(
          top: widget.top + 8,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _pill(context),
              if (_controller.status != AnimationStatus.dismissed)
                SizeTransition(
                  sizeFactor: _unfold,
                  alignment: Alignment.topRight,
                  child: FadeTransition(
                    opacity: _unfold,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width, minWidth: width, maxHeight: maxHeight),
                        child: _list(context),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pill(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.secondaryContainer.withValues(alpha: 0.92),
      elevation: 4,
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: _toggle,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  widget.selected.hostname,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: scheme.onSecondaryContainer),
                ),
              ),
              AnimatedRotation(
                turns: _open ? 0.5 : 0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Icon(Icons.expand_more, size: 20, color: scheme.onSecondaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.surfaceContainerHigh,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 6),
        children: [
          for (final source in widget.sources) _row(context, source),
          if (API.loggedIn.isModOrAdmin && widget.sources.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
              child: Text(
                FlutterI18n.translate(context, 'manga.long_press_primary'),
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, MangaSourceReply source) {
    final theme = Theme.of(context);
    final selected = source.id == widget.selected.id;
    final muted = theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return InkWell(
      onTap: () => _select(source),
      onLongPress: API.loggedIn.isModOrAdmin && !source.isPrimary ? () => _makePrimary(source) : null,
      child: Container(
        color: selected ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.5) : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 36,
                height: 52,
                child: source.hasCover()
                    ? CachedNetworkImage(
                        imageUrl: source.cover,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const SizedBox.shrink(),
                      )
                    : ColoredBox(color: theme.colorScheme.surfaceContainerHighest),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${source.hostname} (${source.language})',
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: selected ? FontWeight.w600 : null),
                  ),
                  if (source.title.isNotEmpty)
                    Text(source.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall),
                  if (source.title.isNotEmpty)
                    Text(
                      FlutterI18n.translate(context, 'manga.chapters', translationParams: {'amount': '${source.countChapters}'}),
                      style: muted,
                    ),
                ],
              ),
            ),
            ValueListenableBuilder<Set<String>>(
              valueListenable: SourceHealth.down,
              builder: (context, down, _) => down.contains(source.hostname)
                  ? Tooltip(
                      message: FlutterI18n.translate(context, 'manga.source_down'),
                      child: const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.cloud_off, size: 16)),
                    )
                  : const SizedBox.shrink(),
            ),
            if (_downloaded.contains(source.id))
              Tooltip(
                message: FlutterI18n.translate(context, 'downloads.downloaded'),
                child: const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.download_done, size: 16)),
              ),
            if (source.isPrimary) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.star, size: 16)),
          ],
        ),
      ),
    );
  }
}
