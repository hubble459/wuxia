import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/anilist.pb.dart';

/// The user's AniList list status for a manga, and a menu to change it. Shows nothing
/// until they connected AniList and the manga has an AniList match.
class AnilistStatusButton extends StatefulWidget {
  final int mangaId;

  const AnilistStatusButton({super.key, required this.mangaId});

  @override
  State<AnilistStatusButton> createState() => _AnilistStatusButtonState();
}

class _AnilistStatusButtonState extends State<AnilistStatusButton> {
  static const _statuses = [
    AnilistListStatus.ANILIST_LIST_CURRENT,
    AnilistListStatus.ANILIST_LIST_PLANNING,
    AnilistListStatus.ANILIST_LIST_COMPLETED,
    AnilistListStatus.ANILIST_LIST_PAUSED,
    AnilistListStatus.ANILIST_LIST_DROPPED,
    AnilistListStatus.ANILIST_LIST_REPEATING,
  ];

  AnilistListEntryReply? _entry;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(AnilistStatusButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mangaId != widget.mangaId) _load();
  }

  Future<void> _load() async {
    try {
      final entry = await api.anilist.listEntry(AnilistListEntryRequest(mangaId: widget.mangaId));
      if (mounted) setState(() => _entry = entry);
    } catch (_) {
      // Offline or AniList is down; just don't show it.
    }
  }

  Future<void> _set(AnilistListStatus status) async {
    setState(() => _saving = true);
    try {
      final entry = await api.anilist.setListStatus(
        SetAnilistListStatusRequest(mangaId: widget.mangaId, status: status),
      );
      if (mounted) setState(() => _entry = entry);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _label(AnilistListStatus status) => FlutterI18n.translate(context, 'anilist.status.${status.name}');

  @override
  Widget build(BuildContext context) {
    final entry = _entry;
    if (entry == null || !entry.connected || !entry.matched) return const SizedBox.shrink();

    final onList = entry.status != AnilistListStatus.ANILIST_LIST_NONE;
    return PopupMenuButton<AnilistListStatus>(
      enabled: !_saving,
      tooltip: FlutterI18n.translate(context, 'anilist.set_status'),
      onSelected: _set,
      itemBuilder: (_) => [
        for (final status in _statuses)
          CheckedPopupMenuItem(value: status, checked: status == entry.status, child: Text(_label(status))),
        if (onList) ...[
          const PopupMenuDivider(),
          PopupMenuItem(
            value: AnilistListStatus.ANILIST_LIST_NONE,
            child: Text(_label(AnilistListStatus.ANILIST_LIST_NONE), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ],
      child: Chip(
        avatar: _saving
            ? const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2))
            : Icon(onList ? Icons.bookmark : Icons.bookmark_add_outlined, size: 18),
        label: Text(
          onList
              ? '${_label(entry.status)}${entry.progress > 0 ? ' · ${entry.progress}' : ''}'
              : FlutterI18n.translate(context, 'anilist.add_to_list'),
        ),
      ),
    );
  }
}
