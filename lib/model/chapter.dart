import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/json_converters.dart';
import 'package:wuxia/model/json.dart';

part 'chapter.g.dart';

@JsonSerializable()
@JiffyConverter()
@OptionalJiffyConverter()
@UriConverter()
class Chapter implements Json {
  final int id;
  final int index;
  @JsonKey(name: 'created_at')
  final Jiffy createdAt;
  final double number;
  final Jiffy? posted;
  final String title;
  final Uri url;

  Chapter({
    required this.id,
    required this.index,
    required this.createdAt,
    required this.number,
    required this.posted,
    required this.title,
    required this.url,
  });

  @override
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}
