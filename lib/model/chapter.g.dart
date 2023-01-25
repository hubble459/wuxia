// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as int,
      index: json['index'] as int,
      createdAt: const JiffyConverter().fromJson(json['created_at'] as String),
      number: (json['number'] as num).toDouble(),
      posted:
          const OptionalJiffyConverter().fromJson(json['posted'] as String?),
      title: json['title'] as String,
      url: const UriConverter().fromJson(json['url'] as String),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'created_at': const JiffyConverter().toJson(instance.createdAt),
      'number': instance.number,
      'posted': const OptionalJiffyConverter().toJson(instance.posted),
      'title': instance.title,
      'url': const UriConverter().toJson(instance.url),
    };
