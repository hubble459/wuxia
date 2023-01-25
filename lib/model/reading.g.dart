// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reading _$ReadingFromJson(Map<String, dynamic> json) => Reading(
      manga: SimpleManga.fromJson(json['manga'] as Map<String, dynamic>),
      progress: json['progress'] as int,
    );

Map<String, dynamic> _$ReadingToJson(Reading instance) => <String, dynamic>{
      'manga': instance.manga,
      'progress': instance.progress,
    };
