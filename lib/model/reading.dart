import 'package:json_annotation/json_annotation.dart';
import 'package:wuxia/model/json.dart';
import 'package:wuxia/model/simple_manga.dart';

part 'reading.g.dart';

@JsonSerializable()
class Reading extends Json {
  final SimpleManga manga;
  int progress;

  Reading({
    required this.manga,
    required this.progress,
  });

  @override
  Map<String, dynamic> toJson() => _$ReadingToJson(this);
  factory Reading.fromJson(Map<String, dynamic> json) => _$ReadingFromJson(json);

  get progressPercentage {
    if (manga.chapterCount == 0) {
      return 0;
    }
    return 1 / manga.chapterCount * progress;
  }

  get page {
    return maxPage - ((progress / 20).floor());
  }

  get maxPage {
    return (manga.chapterCount / 20).floor() + 1;
  }
}
