import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/json_converters.dart';
import 'package:wuxia/model/simple_manga.dart';

part 'manga.g.dart';

@JsonSerializable()
@JiffyConverter()
@OptionalJiffyConverter()
@BooleanConverter()
@UriConverter()
@OptionalUriConverter()
class Manga extends SimpleManga {
  final String description;
  @JsonKey(name: 'alt_titles')
  final List<String> altTitles;
  final List<String> authors;
  final List<String> genres;

  Manga({
    required this.altTitles,
    required this.authors,
    required this.description,
    required this.genres,
    required int id,
    required int chapterCount,
    required Uri? cover,
    required Jiffy createdAt,
    required bool reading,
    required bool ongoing,
    required String title,
    required Jiffy? updatedAt,
    required Jiffy? nextChapter,
    required Jiffy? lastChapter,
    required Uri url,
  }) : super(
          id: id,
          reading: reading,
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

  @override
  Map<String, dynamic> toJson() => _$MangaToJson(this);
  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);
}
