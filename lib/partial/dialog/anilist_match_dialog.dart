import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/anilist.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';
import 'package:wuxia/util/debouncer.dart';

/// Searches AniList and sets the picked entry as the manga's match, for everyone.
/// Returns the updated manga, or null when cancelled.
Future<MangaReply?> showAnilistMatchDialog(BuildContext context, MangaReply manga) {
  return Navigator.of(context).push<MangaReply>(MaterialPageRoute(builder: (_) => _AnilistMatchScreen(manga: manga)));
}

class _AnilistMatchScreen extends StatefulWidget {
  final MangaReply manga;

  const _AnilistMatchScreen({required this.manga});

  @override
  State<_AnilistMatchScreen> createState() => _AnilistMatchScreenState();
}

class _AnilistMatchScreenState extends State<_AnilistMatchScreen> {
  late final _controller = TextEditingController(text: widget.manga.title.replaceAll('\n', ' '));
  late Future<List<AnilistMedia>> _results = _fetch(_controller.text);
  final _searchDebouncer = Debouncer();

  /// The query [_results] is for.
  late String _searched = _controller.text.trim();
  bool _saving = false;

  Future<List<AnilistMedia>> _fetch(String query) =>
      api.anilist.search(AnilistSearchRequest(query: query)).then((reply) => reply.items);

  void _search(String query) {
    _searchDebouncer.cancel();
    _searched = query.trim();
    setState(() => _results = _fetch(query));
  }

  /// Searches [query] once typing pauses, unless it's what's already
  /// searched for.
  void _searchSoon(String query) {
    _searchDebouncer.cancel();
    if (query.trim() != _searched) _searchDebouncer(() => _search(query));
  }

  Future<void> _save(SetAnilistMatchRequest request) async {
    setState(() => _saving = true);
    try {
      final manga = await api.anilist.setMatch(request..mangaId = widget.manga.id);
      if (mounted) Navigator.of(context).pop(manga);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  void dispose() {
    _searchDebouncer.cancel();
    _controller.dispose();
    super.dispose();
  }

  String _subtitle(AnilistMedia media) => [
    if (media.hasTitleRomaji() && media.titleRomaji != media.titleEnglish) media.titleRomaji,
    [
      if (media.hasFormat()) media.format,
      if (media.hasStartYear()) '${media.startYear}',
      if (media.hasChapters()) '${media.chapters} ch.',
      if (media.hasStatus()) media.status,
    ].join(' · '),
  ].join('\n');

  @override
  Widget build(BuildContext context) {
    final current = widget.manga.hasAnilist() ? widget.manga.anilist.id : null;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _searchSoon,
          onSubmitted: _search,
          decoration: InputDecoration(hintText: FlutterI18n.translate(context, 'anilist.search'), border: InputBorder.none),
        ),
        bottom: _saving ? const PreferredSize(preferredSize: Size.fromHeight(4), child: LinearProgressIndicator()) : null,
      ),
      body: FutureBuilder<List<AnilistMedia>>(
        future: _results,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final results = snapshot.data ?? [];
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.auto_fix_high),
                title: I18nText('anilist.rematch'),
                onTap: _saving ? null : () => _save(SetAnilistMatchRequest(rematch: true)),
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: I18nText('anilist.not_on_anilist'),
                onTap: _saving ? null : () => _save(SetAnilistMatchRequest()),
              ),
              const Divider(),
              for (final media in results)
                ListTile(
                  leading: media.hasCover()
                      ? CachedNetworkImage(
                          imageUrl: media.cover,
                          fit: BoxFit.cover,
                          width: 40,
                          errorWidget: (context, url, error) => const ImageErrorPlaceholder(),
                        )
                      : null,
                  title: Text(
                    media.hasTitleEnglish() ? media.titleEnglish : media.titleRomaji,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(_subtitle(media)),
                  isThreeLine: media.hasTitleRomaji() && media.titleRomaji != media.titleEnglish,
                  trailing: media.id == current ? const Icon(Icons.check) : null,
                  onTap: _saving ? null : () => _save(SetAnilistMatchRequest(anilistId: media.id)),
                ),
            ],
          );
        },
      ),
    );
  }
}
