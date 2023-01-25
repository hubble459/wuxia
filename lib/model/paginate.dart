import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/model/json.dart';

part 'paginate.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginate<T extends Json> implements Json {
  final int page;
  final int limit;
  @JsonKey(name: 'num_pages')
  final int numPages;
  @JsonKey(name: 'num_items')
  final int numItems;
  final List<T> data;

  const Paginate({
    required this.page,
    required this.limit,
    required this.numPages,
    required this.numItems,
    required this.data,
  });

  factory Paginate.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return _$PaginateFromJson(json, (m) => fromJson(m as dynamic));
  }

  @override
  Map<String, dynamic> toJson() => _$PaginateToJson(this, (Json value) => value.toJson());
}
