// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
      altTitles: (json['alt_titles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['id'] as int,
      chapterCount: json['chapter_count'] as int,
      cover: const OptionalUriConverter().fromJson(json['cover'] as String?),
      createdAt: const JiffyConverter().fromJson(json['created_at'] as String),
      reading: json['reading'] == null
          ? true
          : const BooleanConverter().fromJson(json['reading'] as int),
      ongoing: const BooleanConverter().fromJson(json['ongoing'] as int),
      title: json['title'] as String,
      updatedAt: const OptionalJiffyConverter()
          .fromJson(json['updated_at'] as String?),
      nextChapter: const OptionalJiffyConverter()
          .fromJson(json['next_chapter'] as String?),
      lastChapter: const OptionalJiffyConverter()
          .fromJson(json['last_chapter'] as String?),
      url: const UriConverter().fromJson(json['url'] as String),
    );

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
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
      'description': instance.description,
      'alt_titles': instance.altTitles,
      'authors': instance.authors,
      'genres': instance.genres,
    };
