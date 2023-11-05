import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/meta.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/simple_future_builder.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            I18nText('settings.statistics.title'),
            Text(
              API.loggedIn.username,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: SimpleFutureBuilder<StatsReply>(
        future: api.meta.stats(Empty()),
        onLoadedBuilder: (context, data) => Column(
          children: [
            _Progress(
              name: FlutterI18n.translate(context, 'settings.statistics.completed_manga'),
              total: data.countTotalReading.toInt(),
              progress: data.countReading.toInt(),
            ),
            _Progress(
              name: FlutterI18n.translate(context, 'settings.statistics.chapters_read'),
              total: data.countTotalChapters.toInt(),
              progress: data.countChapters.toInt(),
            ),
            _AverageReadingTime(totalChaptersRead: data.countChapters.toInt())
          ],
        ),
      ),
    );
  }
}

class _AverageReadingTime extends StatefulWidget {
  final int totalChaptersRead;

  const _AverageReadingTime({Key? key, required this.totalChaptersRead}) : super(key: key);

  @override
  State<_AverageReadingTime> createState() => __AverageStateReadingTime();
}

class __AverageStateReadingTime extends State<_AverageReadingTime> {
  Duration _averageChapterReadTime = const Duration(minutes: 3);
  late Picker _picker;

  @override
  Widget build(BuildContext context) {
    Timer? timer;

    _picker = Picker(
      columnPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      textStyle: Theme.of(context).textTheme.bodyLarge,
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(
          begin: 0,
          end: 30,
          suffix: I18nText('settings.statistics.minutes'),
          jump: 1,
          initValue: _averageChapterReadTime.inMinutes,
        ),
        NumberPickerColumn(
          begin: 0,
          end: 50,
          suffix: I18nText('settings.statistics.seconds'),
          jump: 10,
          initValue: _averageChapterReadTime.inSeconds.remainder(60),
        ),
      ]),
      hideHeader: true,
      onSelect: (picker, index, selected) {
        timer?.cancel();

        timer = Timer(const Duration(milliseconds: 500), () {
          final m = selected[0];
          final s = selected[1];
          final mins = 1 * m;
          final seconds = 10 * s;
          setState(() {
            _averageChapterReadTime = Duration(
              minutes: mins,
              seconds: seconds,
            );
          });
        });
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            FlutterI18n.translate(context, 'settings.statistics.average_reading_time'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        _picker.makePicker(),
        Text(
          _printDuration(_averageChapterReadTime * widget.totalChaptersRead),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'DD:HH:MM:SS',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String days = duration.inDays != 0 ? '${twoDigits(duration.inDays)}:' : '';
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$days$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }
}

class _Progress extends StatelessWidget {
  final String name;
  final int total;
  final int progress;

  const _Progress({
    Key? key,
    required this.name,
    required this.total,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(progress.toString()),
                  Text((total - progress).toString()),
                ],
              ),
              Stack(children: [
                LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  minHeight: 12,
                  value: percentage(),
                ),
                Center(
                  child: Text(
                    total.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      inherit: true,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }

  double percentage() {
    if (total == 0) {
      return 0;
    }
    return 1 / total * progress;
  }
}
