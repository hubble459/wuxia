import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';

/// Search-and-pick over the local library (via Manga.Index) - unlike SearchScreen (which
/// searches external sites and creates/attaches sources from a scraped URL), this returns
/// an already-tracked manga, for admin merge/move-source flows that need an existing target.
Future<MangaReply?> showMangaPickerDialog(BuildContext context, {required int excludeMangaId}) {
  return Navigator.of(context).push<MangaReply>(
    MaterialPageRoute(
      builder: (context) => _MangaPickerScreen(excludeMangaId: excludeMangaId),
    ),
  );
}

class _MangaPickerScreen extends StatefulWidget {
  final int excludeMangaId;

  const _MangaPickerScreen({required this.excludeMangaId});

  @override
  State<_MangaPickerScreen> createState() => _MangaPickerScreenState();
}

class _MangaPickerScreenState extends State<_MangaPickerScreen> {
  final _controller = TextEditingController();
  late Future<List<MangaReply>> _results = _fetch('');

  Future<List<MangaReply>> _fetch(String keyword) {
    return api.manga
        .index(PaginateSearchQuery(page: Int64(1), perPage: Int64(30), search: keyword))
        .then((reply) => reply.items.where((manga) => manga.id != widget.excludeMangaId).toList());
  }

  void _search(String keyword) {
    setState(() {
      _results = _fetch(keyword);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onSubmitted: _search,
          decoration: InputDecoration(
            hintText: FlutterI18n.translate(context, 'search.search_manga'),
            border: InputBorder.none,
          ),
        ),
      ),
      body: FutureBuilder<List<MangaReply>>(
        future: _results,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final results = snapshot.data ?? [];
          if (results.isEmpty) {
            return Center(child: I18nText('empty'));
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final manga = results[index];
              return ListTile(
                leading: manga.hasCover()
                    ? CachedNetworkImage(
                        imageUrl: manga.cover,
                        fit: BoxFit.cover,
                        width: 40,
                      )
                    : null,
                title: Text(manga.title.replaceAll('\n', ' '), maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text('${manga.sources.length} source(s)'),
                onTap: () => Navigator.of(context).pop(manga),
              );
            },
          );
        },
      ),
    );
  }
}
