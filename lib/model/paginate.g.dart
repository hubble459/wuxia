// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginate<T> _$PaginateFromJson<T extends Json>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Paginate<T>(
      page: json['page'] as int,
      limit: json['limit'] as int,
      numPages: json['num_pages'] as int,
      numItems: json['num_items'] as int,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginateToJson<T extends Json>(
  Paginate<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'num_pages': instance.numPages,
      'num_items': instance.numItems,
      'data': instance.data.map(toJsonT).toList(),
    };
