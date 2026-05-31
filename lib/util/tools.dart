import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/search.pb.dart';
import 'package:wuxia/util/store.dart';

const mangaCoverReferer = ['manhuagui.com'];

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

Future<Directory> getDownloadDirectory() async {
  final custom = Store.getStoreInstance().getDownloadDir();
  if (custom != null) return Directory(custom);
  return getApplicationDocumentsDirectory();
}
