// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleManga _$SimpleMangaFromJson(Map<String, dynamic> json) => SimpleManga(
      id: json['id'] as int,
      reading: json['reading'] == null
          ? true
          : const BooleanConverter().fromJson(json['reading'] as int),
      chapterCount: json['chapter_count'] as int,
      cover: const OptionalUriConverter().fromJson(json['cover'] as String?),
      ongoing: const BooleanConverter().fromJson(json['ongoing'] as int),
      title: json['title'] as String,
      updatedAt: const OptionalJiffyConverter()
          .fromJson(json['updated_at'] as String?),
      createdAt: const JiffyConverter().fromJson(json['created_at'] as String),
      url: const UriConverter().fromJson(json['url'] as String),
      nextChapter: const OptionalJiffyConverter()
          .fromJson(json['next_chapter'] as String?),
      lastChapter: const OptionalJiffyConverter()
          .fromJson(json['last_chapter'] as String?),
    );

Map<String, dynamic> _$SimpleMangaToJson(SimpleManga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reading': const BooleanConverter().toJson(instance.reading),
      'url': const UriConverter().toJson(instance.url),
      'title': instance.title,
      'cover': const OptionalUriConverter().toJson(instance.cover),
      'chapter_count': instance.chapterCount,
      'ongoing': const BooleanConverter().toJson(instance.ongoing),
      'updated_at': const OptionalJiffyConverter().toJson(instance.updatedAt),
      'created_at': const JiffyConverter().toJson(instance.createdAt),
      'next_chapter':
          const OptionalJiffyConverter().toJson(instance.nextChapter),
      'last_chapter':
          const OptionalJiffyConverter().toJson(instance.lastChapter),
    };
