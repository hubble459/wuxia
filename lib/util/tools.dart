import 'package:collection/collection.dart';
import 'package:wuxia/gen/chapter.pb.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/search.pb.dart';

const mangaCoverReferer = ['buhh'];

// manga should be MangaReply, SearchManga or ChapterReply
String getReferer(dynamic manga, [String? coverUrl]) {
  if (!(manga is SearchManga || manga is MangaReply || manga is ChapterReply)) {
    return '';
  }

  final coverAsReferer = mangaCoverReferer.firstWhereOrNull((hostname) => manga.url.contains(hostname)) != null;
  if (coverAsReferer) {
    return coverUrl != null
        ? coverUrl
        : manga.hasCover()
            ? manga.cover
            : manga.url;
  }

  return manga.url;
}
