import 'package:collection/collection.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/search.pb.dart';

const mangaCoverReferer = ['buhh'];

// manga should be MangaReply, SearchManga or ChapterReply
String getReferer(dynamic manga, [String? coverUrl]) {
  if (!(manga is SearchManga || manga is MangaReply || manga is ChapterReply)) {
    return '';
  }

  final coverAsReferer = mangaCoverReferer.firstWhereOrNull((hostname) => manga.url.contains(hostname)) != null;
  if (coverAsReferer) {
    return coverUrl ?? (manga.hasCover() ? manga.cover : manga.url);
  }

  return manga.url;
}
