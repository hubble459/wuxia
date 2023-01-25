import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/json_converters.dart';
import 'package:wuxia/model/json.dart';

part 'search_manga.g.dart';

@JsonSerializable()
@OptionalJiffyConverter()
@OptionalUriConverter()
class SearchManga implements Json {
  final Uri url;
  final String title;
  final Jiffy? updated;
  final Uri? cover;

  SearchManga({
    required this.url,
    required this.title,
    required this.updated,
    required this.cover,
  });

  @override
  Map<String, dynamic> toJson() => _$SearchMangaToJson(this);
  factory SearchManga.fromJson(Map<String, dynamic> json) => _$SearchMangaFromJson(json);
}
