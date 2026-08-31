import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';

/// Route names for the manga detail and chapter reader screens, shared
/// between the places that navigate to them and main.dart's onGenerateRoute,
/// which reconstructs either screen from just the URL -- needed because a
/// direct Navigator.push carries the already-loaded objects, but a page
/// refresh (or a deep link) only has whatever survived in the URL.
String mangaRouteName(int mangaId) => 'manga/$mangaId';

String chapterRouteName({required int mangaId, required int sourceId, required int chapterIndex}) =>
    'manga/$mangaId/source/$sourceId/chapter/$chapterIndex';

String chapterRouteNameFor({required int mangaId, required ChapterReply chapter}) => chapterRouteName(
      mangaId: mangaId,
      sourceId: chapter.mangaSourceId,
      chapterIndex: chapter.index.toInt(),
    );

class MangaRouteMatch {
  final int mangaId;

  const MangaRouteMatch(this.mangaId);
}

class ChapterRouteMatch {
  final int mangaId;
  final int sourceId;
  final int chapterIndex;

  const ChapterRouteMatch({required this.mangaId, required this.sourceId, required this.chapterIndex});
}

final _mangaRoutePattern = RegExp(r'^manga/(\d+)$');
final _chapterRoutePattern = RegExp(r'^manga/(\d+)/source/(\d+)/chapter/(\d+)$');

MangaRouteMatch? matchMangaRoute(String routeName) {
  final match = _mangaRoutePattern.firstMatch(routeName);
  if (match == null) return null;
  return MangaRouteMatch(int.parse(match.group(1)!));
}

ChapterRouteMatch? matchChapterRoute(String routeName) {
  final match = _chapterRoutePattern.firstMatch(routeName);
  if (match == null) return null;
  return ChapterRouteMatch(
    mangaId: int.parse(match.group(1)!),
    sourceId: int.parse(match.group(2)!),
    chapterIndex: int.parse(match.group(3)!),
  );
}
