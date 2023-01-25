import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/json_converters.dart';
import 'package:wuxia/model/json.dart';
import 'package:wuxia/model/manga.dart';

part 'simple_manga.g.dart';

@JsonSerializable()
@JiffyConverter()
@OptionalJiffyConverter()
@BooleanConverter()
@UriConverter()
@OptionalUriConverter()
class SimpleManga implements Json {
  final int id;
  @JsonKey(defaultValue: true)
  bool reading;
  final Uri url;
  String title;
  Uri? cover;
  @JsonKey(name: 'chapter_count')
  int chapterCount;
  bool ongoing;
  @JsonKey(name: 'updated_at')
  Jiffy? updatedAt;
  @JsonKey(name: 'created_at')
  final Jiffy createdAt;
  @JsonKey(name: 'next_chapter')
  Jiffy? nextChapter;
  @JsonKey(name: 'last_chapter')
  Jiffy? lastChapter;

  SimpleManga({
    required this.id,
    required this.reading,
    required this.chapterCount,
    required this.cover,
    required this.ongoing,
    required this.title,
    required this.updatedAt,
    required this.createdAt,
    required this.url,
    required this.nextChapter,
    required this.lastChapter,
  });

  @override
  Map<String, dynamic> toJson() => _$SimpleMangaToJson(this);
  factory SimpleManga.fromJson(Map<String, dynamic> json) => _$SimpleMangaFromJson(json);

  Manga toManga() {
    return Manga(
      altTitles: [],
      authors: [],
      genres: [],
      reading: reading,
      description: '',
      id: id,
      chapterCount: chapterCount,
      cover: cover,
      createdAt: createdAt,
      ongoing: ongoing,
      title: title,
      updatedAt: updatedAt,
      url: url,
      nextChapter: nextChapter,
      lastChapter: lastChapter,
    );
  }

  update(Manga manga) {
    title = manga.title;
    cover = manga.cover;
    chapterCount = manga.chapterCount;
    ongoing = manga.ongoing;
    updatedAt = manga.updatedAt;
    nextChapter = manga.nextChapter;
    lastChapter = manga.lastChapter;
  }
}
