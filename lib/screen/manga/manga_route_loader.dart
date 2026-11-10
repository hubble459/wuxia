import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/partial/offline_notice.dart';
import 'package:wuxia/util/session.dart';
import 'package:wuxia/util/tools.dart';

/// Resolves the `manga/<id>` route -- reached on a page refresh or deep link
/// that never went through the normal in-app navigation flow, which passes
/// an already-loaded MangaReply directly instead of fetching by id here.
///
/// Fetches via `index` (search: `id:<id>`) rather than `get` -- `get` refreshes
/// the primary source inline when its data is stale, which throws for a dead
/// source before any manga data is returned at all. `index` never scrapes, so
/// this always has real data to hand MangaScreen even when its own
/// loadManga() then fails the same way and shows DeadProviderDialog.
class MangaRouteLoader extends StatefulWidget {
  final int mangaId;

  const MangaRouteLoader({super.key, required this.mangaId});

  @override
  State<MangaRouteLoader> createState() => _MangaRouteLoaderState();
}

class _MangaRouteLoaderState extends State<MangaRouteLoader> {
  late final Future<MangaReply> _future = _load();

  Future<MangaReply> _load() async {
    await restoreSession();
    if (!API.isLoggedIn) {
      throw StateError('not logged in');
    }
    // Offline, a server error, or not found (e.g. merged away) -- a
    // downloaded copy is still readable.
    MangaReply? manga;
    Object? error;
    try {
      final result = await api.manga.index(PaginateSearchQuery(search: 'id:${widget.mangaId}', perPage: Int64(1)));
      manga = result.items.firstOrNull;
    } catch (e) {
      error = e;
    }
    manga ??= await loadOfflineManga(widget.mangaId);
    if (manga != null) return manga;
    throw error ?? StateError('manga not found');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MangaReply>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          if (!API.isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) Navigator.of(context).pushReplacementNamed('login');
            });
            return const Scaffold(body: SizedBox.shrink());
          }
          if (isNetworkError(snapshot.error)) return const Scaffold(body: OfflineNotice());
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        return MangaScreen(manga: snapshot.requireData, type: HeroScreenType.latest);
      },
    );
  }
}
