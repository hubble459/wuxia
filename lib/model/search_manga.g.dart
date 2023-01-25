// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchManga _$SearchMangaFromJson(Map<String, dynamic> json) => SearchManga(
      url: Uri.parse(json['url'] as String),
      title: json['title'] as String,
      updated:
          const OptionalJiffyConverter().fromJson(json['updated'] as String?),
      cover: const OptionalUriConverter().fromJson(json['cover'] as String?),
    );

Map<String, dynamic> _$SearchMangaToJson(SearchManga instance) =>
    <String, dynamic>{
      'url': instance.url.toString(),
      'title': instance.title,
      'updated': const OptionalJiffyConverter().toJson(instance.updated),
      'cover': const OptionalUriConverter().toJson(instance.cover),
    };
