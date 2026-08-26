import 'package:flutter/material.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/session.dart';

/// Resolves the `manga/<id>` route -- reached on a page refresh or deep link
/// that never went through the normal in-app navigation flow, which passes
/// an already-loaded MangaReply directly instead of fetching by id here.
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
    return api.manga.get(Id(id: widget.mangaId));
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
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        return MangaScreen(manga: snapshot.requireData, type: HeroScreenType.latest);
      },
    );
  }
}
