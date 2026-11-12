import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/meta.pb.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/partial/stats/stats_widgets.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/session.dart';

/// Cultivation realms by chapters read, lowest first.
const _realms = [
  ('mortal', 0),
  ('qi_condensation', 100),
  ('foundation', 500),
  ('core_formation', 1500),
  ('nascent_soul', 3000),
  ('soul_formation', 6000),
  ('spirit_severing', 10000),
  ('dao_seeking', 15000),
  ('immortal', 25000),
  ('heavenly_emperor', 50000),
];

const _personaEmoji = {
  'night_owl': '🦉',
  'binger': '🍜',
  'completionist': '🏁',
  'loyalist': '🛡️',
  'collector': '🐉',
  'disciplined': '🧘',
  'steady': '🍵',
};

/// Logical pixels are 1/160 inch.
const _metersPerLogicalPixel = 0.0254 / 160;

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // A web deep link can land here directly, skipping the screens that
  // normally restore credentials before this screen reads API.loggedIn.
  bool _ready = false;
  Future<DetailedStatsReply>? _stats;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await restoreSession();
    if (!mounted) return;

    if (!API.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    setState(() {
      _ready = true;
      _stats = _load();
    });
  }

  Future<DetailedStatsReply> _load() =>
      api.meta.detailedStats(DetailedStatsRequest(utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes));

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            I18nText('settings.statistics.title'),
            Text(API.loggedIn.username, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: SimpleFutureBuilder<DetailedStatsReply>(
        future: _stats!,
        onLoadingBuilder: (context) => const _Loading(),
        onLoadedBuilder: (context, data) => RefreshIndicator(
          onRefresh: () async {
            final next = _load();
            setState(() => _stats = next);
            await next;
          },
          child: ResponsiveContent(child: _StatsBody(data: data)),
        ),
      ),
    );
  }
}

String _t(BuildContext context, String key, [Map<String, Object>? params]) => FlutterI18n.translate(
      context,
      'settings.statistics.$key',
      translationParams: params?.map((k, v) => MapEntry(k, v.toString())),
    );

String _date(DateTime date) => Jiffy.parseFromDateTime(date).yMMMd;

DateTime _fromMillis(int millis) => DateTime.fromMillisecondsSinceEpoch(millis);

/// `StatsSeries.at` for a day is that local date's midnight as UTC.
DateTime _fromDayMillis(int millis) {
  final utc = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
  return DateTime(utc.year, utc.month, utc.day);
}

int _localEpochDay(DateTime now) => DateTime.utc(now.year, now.month, now.day).difference(DateTime.utc(1970)).inDays;

String _duration(BuildContext context, num minutes) {
  final total = minutes.round();
  if (total >= 60 * 24 * 365 * 2) {
    return _t(context, 'units.years', {'amount': (total / (60 * 24 * 365)).toStringAsFixed(1)});
  }
  if (total >= 60 * 24) {
    return _t(context, 'units.days_hours', {'days': groupDigits(total ~/ (60 * 24)), 'hours': (total ~/ 60) % 24});
  }
  return _t(context, 'units.hours_minutes', {'hours': total ~/ 60, 'minutes': total % 60});
}

String _oneDecimal(double value) =>
    value >= 100 ? groupDigits(value) : value.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');

class _Loading extends StatefulWidget {
  const _Loading();

  @override
  State<_Loading> createState() => _LoadingState();
}

class _LoadingState extends State<_Loading> {
  int _line = 0;
  late final Timer _timer = Timer.periodic(const Duration(milliseconds: 1400), (_) => setState(() => _line++));

  @override
  void initState() {
    super.initState();
    _timer;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Text(
              _t(context, 'loading.${_line % 5 + 1}'),
              key: ValueKey(_line),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  final DetailedStatsReply data;

  const _StatsBody({required this.data});

  @override
  Widget build(BuildContext context) {
    final sections = <Widget>[
      _Hero(data: data),
      _Totals(data: data),
      _FunFacts(data: data),
      _Streaks(data: data),
      _Activity(data: data),
      _Clock(data: data),
      if (data.hasBiggestBinge()) _Binge(series: data.biggestBinge),
      _Taste(data: data),
      _Library(data: data),
      _HallOfFame(data: data),
      if (data.friends.isNotEmpty) _Friends(friends: data.friends),
      if (data.hasYear()) _Wrapped(data: data),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        child: Text(
          _t(context, 'estimate_note', {
            'minutes': _oneDecimal(data.minutesPerChapter),
            'opened': groupDigits(data.chaptersOpened.toInt()),
          }),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white38),
        ),
      ),
    ];

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, index) => Reveal(delay: Duration(milliseconds: index < 3 ? index * 120 : 0), child: sections[index]),
    );
  }
}

class _Hero extends StatelessWidget {
  final DetailedStatsReply data;

  const _Hero({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapters = data.chaptersRead.toInt();
    final level = _realms.lastIndexWhere((realm) => chapters >= realm.$2);
    final next = level + 1 < _realms.length ? _realms[level + 1] : null;
    final from = _realms[level].$2;
    final progress = next == null ? 1.0 : (chapters - from) / (next.$2 - from);
    final since = data.hasFirstReadAt() ? data.firstReadAt.toInt() : data.memberSince.toInt();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: EmojiRain(
          emojis: const ['📖', '⚔️', '🐉', '✨', '🔥', '🥟', '🌸', '💫'],
          child: Container(
            decoration: const BoxDecoration(gradient: statsGradient),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _t(context, 'hero.realm_label').toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70, letterSpacing: 2),
                      ),
                    ),
                    Text(_t(context, 'hero.tap_hint'), style: theme.textTheme.labelSmall?.copyWith(color: Colors.white54)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _t(context, 'realms.${_realms[level].$1}'),
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  _t(context, 'hero.realm_level', {'level': level + 1, 'max': _realms.length}),
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOutCubic,
                    builder: (context, t, _) => LinearProgressIndicator(
                      value: t,
                      minHeight: 10,
                      backgroundColor: Colors.black26,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  next == null
                      ? _t(context, 'hero.max_realm')
                      : _t(context, 'hero.next_realm', {
                          'amount': groupDigits(next.$2 - chapters),
                          'realm': _t(context, 'realms.${next.$1}'),
                        }),
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  _t(context, 'hero.reader_since', {'date': _date(_fromMillis(since))}),
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  final DetailedStatsReply data;

  const _Totals({required this.data});

  @override
  Widget build(BuildContext context) {
    final width = math.min(MediaQuery.sizeOf(context).width, 500.0);
    final km = data.screensScrolled * width * _metersPerLogicalPixel / 1000;
    final tiles = [
      ('📚', _t(context, 'totals.chapters_read'), CountUp(value: data.chaptersRead.toInt())),
      ('⏳', _t(context, 'totals.time_read'), CountUp(value: data.minutesRead.toInt(), format: (v) => _duration(context, v))),
      ('📄', _t(context, 'totals.pages_read'), CountUp(value: data.pagesRead.toInt(), format: compactNumber)),
      ('📜', _t(context, 'totals.distance'), CountUp(value: km, format: (v) => _t(context, 'units.km', {'amount': _oneDecimal(v.toDouble())}))),
      ('🗂️', _t(context, 'totals.series'), CountUp(value: data.seriesTotal.toInt())),
      ('👆', _t(context, 'totals.chapters_opened'), CountUp(value: data.chaptersOpened.toInt())),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.55,
        children: [
          for (final (emoji, label, value) in tiles)
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: statsSurface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 22)),
                    DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                      child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: value),
                    ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FunFacts extends StatefulWidget {
  final DetailedStatsReply data;

  const _FunFacts({required this.data});

  @override
  State<_FunFacts> createState() => _FunFactsState();
}

class _FunFactsState extends State<_FunFacts> {
  final _controller = PageController(viewportFraction: 0.88);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final width = math.min(MediaQuery.sizeOf(context).width, 500.0);
    final meters = data.screensScrolled * width * _metersPerLogicalPixel;
    final minutes = data.minutesRead.toDouble();
    final paperMeters = data.pagesRead.toDouble() * 0.0001;
    final since = data.hasFirstReadAt() ? _fromMillis(data.firstReadAt.toInt()) : _fromMillis(data.memberSince.toInt());
    final daysSince = math.max(1, DateTime.now().difference(since).inDays);

    final facts = <(String, String)>[
      ('🗼', _t(context, 'facts.eiffel', {'amount': _oneDecimal(meters / 330)})),
      ('🏔️', _t(context, 'facts.everest', {'amount': _oneDecimal(meters / 8849)})),
      ('🏃', _t(context, 'facts.marathon', {'amount': _oneDecimal(meters / 42195)})),
      ('💍', _t(context, 'facts.lotr', {'amount': _oneDecimal(minutes / 686)})),
      ('✈️', _t(context, 'facts.flights', {'amount': _oneDecimal(minutes / (14 * 60))})),
      ('😴', _t(context, 'facts.sleep', {'amount': _oneDecimal(minutes / (8 * 60))})),
      ('🦒', _t(context, 'facts.paper', {'amount': _oneDecimal(paperMeters), 'giraffes': _oneDecimal(paperMeters / 5.5)})),
      ('📆', _t(context, 'facts.per_day', {'amount': _oneDecimal(data.chaptersRead.toInt() / daysSince), 'date': _date(since)})),
    ];

    return Column(
      children: [
        SectionTitle(emoji: '🤯', title: _t(context, 'facts.title'), subtitle: _t(context, 'facts.subtitle')),
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _controller,
            itemCount: facts.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) {
              final (emoji, text) = facts[index];
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final page = _controller.hasClients && _controller.position.haveDimensions
                      ? _controller.page ?? 0
                      : _page.toDouble();
                  final distance = (page - index).abs().clamp(0.0, 1.0);
                  return Transform.rotate(
                    angle: (index - page).clamp(-1.0, 1.0) * 0.06,
                    child: Transform.scale(scale: 1 - distance * 0.08, child: child),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          statsCategorical[index % statsCategorical.length].withValues(alpha: 0.35),
                          statsSurface,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Row(
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 48)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < facts.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _page ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _page ? Colors.white : Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Streaks extends StatefulWidget {
  final DetailedStatsReply data;

  const _Streaks({required this.data});

  @override
  State<_Streaks> createState() => _StreaksState();
}

class _StreaksState extends State<_Streaks> with SingleTickerProviderStateMixin {
  late final AnimationController _flicker = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _flicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final theme = Theme.of(context);
    final current = data.currentStreak;
    final small = theme.textTheme.bodySmall?.copyWith(color: Colors.white60);
    final big = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900);

    Widget stat(String label, Widget value) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(style: big, child: value),
              Text(label, style: small),
            ],
          ),
        );

    return Column(
      children: [
        SectionTitle(emoji: '🔥', title: _t(context, 'streak.title')),
        StatsCard(
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _flicker,
                    builder: (context, child) => Transform.scale(
                      scale: current > 0 ? 1 + _flicker.value * 0.12 : 1,
                      child: Transform.rotate(angle: current > 0 ? (_flicker.value - 0.5) * 0.12 : 0, child: child),
                    ),
                    child: Text(current > 0 ? '🔥' : '🪵', style: TextStyle(fontSize: 56 + math.min(current, 30).toDouble())),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CountUp(
                          value: current,
                          format: (v) => _t(context, 'streak.days', {'amount': v.round()}),
                          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          current > 0 ? _t(context, 'streak.current') : _t(context, 'streak.zero'),
                          style: small,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 28, color: Colors.white10),
              Row(
                children: [
                  stat(_t(context, 'streak.longest'), Text(_t(context, 'streak.days', {'amount': data.longestStreak}))),
                  stat(_t(context, 'streak.last_30'), CountUp(value: data.chapters30d.toInt())),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  stat(_t(context, 'streak.sessions'), CountUp(value: data.sessions.toInt())),
                  stat(
                    _t(context, 'streak.longest_session'),
                    Text(_duration(context, data.longestSessionMinutes.toInt())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Activity extends StatelessWidget {
  final DetailedStatsReply data;

  const _Activity({required this.data});

  @override
  Widget build(BuildContext context) {
    final days = {for (final day in data.days) day.day: day.chapters.toInt()};
    final monday = DateTime(2024, 1, 1);
    final weekdayLabels = [for (var i = 0; i < 7; i++) Jiffy.parseFromDateTime(monday.add(Duration(days: i))).E];
    final firstLog = data.days.isEmpty ? null : DateTime.utc(1970).add(Duration(days: data.days.first.day));

    return Column(
      children: [
        SectionTitle(emoji: '🗓️', title: _t(context, 'activity.title'), subtitle: _t(context, 'activity.subtitle')),
        StatsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivityHeatmap(
                days: days,
                today: _localEpochDay(DateTime.now()),
                weekdayLabels: weekdayLabels,
                monthLabel: (date) => Jiffy.parseFromDateTime(date).MMM,
                tooltip: (date, chapters) => _t(context, 'activity.tooltip', {'date': _date(date), 'amount': chapters}),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: firstLog == null
                        ? const SizedBox()
                        : Text(
                            _t(context, 'activity.log_note', {'date': _date(firstLog)}),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white38),
                          ),
                  ),
                  Text(_t(context, 'activity.less'), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white38)),
                  const SizedBox(width: 4),
                  for (final color in [statsEmpty, ...statsSequential.skip(1)])
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                    ),
                  const SizedBox(width: 2),
                  Text(_t(context, 'activity.more'), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white38)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Clock extends StatelessWidget {
  final DetailedStatsReply data;

  const _Clock({required this.data});

  String _persona(BuildContext context, List<int> hours) {
    final total = hours.fold(0, (a, b) => a + b);
    if (total == 0) return _t(context, 'clock.persona_none');
    int share(Iterable<int> range) => (range.fold(0, (sum, h) => sum + hours[h]) * 100 / total).round();
    final candidates = [
      ('night_owl', share([22, 23, 0, 1, 2, 3, 4])),
      ('early_bird', share([5, 6, 7, 8, 9])),
      ('lunch', share([11, 12, 13])),
      ('afternoon', share([14, 15, 16, 17])),
      ('evening', share([18, 19, 20, 21])),
    ];
    // Weighted by window length so a 3-hour window doesn't lose to a 7-hour one by default.
    const windows = {'night_owl': 7, 'early_bird': 5, 'lunch': 3, 'afternoon': 4, 'evening': 4};
    candidates.sort((a, b) => (b.$2 / windows[b.$1]!).compareTo(a.$2 / windows[a.$1]!));
    final best = candidates.first;
    return _t(context, 'clock.persona_${best.$1}', {'percent': best.$2});
  }

  @override
  Widget build(BuildContext context) {
    final hours = data.hours.map((h) => h.toInt()).toList();
    final weekdays = data.weekdays.map((d) => d.toInt()).toList();
    final monday = DateTime(2024, 1, 1);
    final dayNames = [for (var i = 0; i < 7; i++) Jiffy.parseFromDateTime(monday.add(Duration(days: i))).E];
    final fullDayNames = [for (var i = 0; i < 7; i++) Jiffy.parseFromDateTime(monday.add(Duration(days: i))).EEEE];
    final bestDay = weekdays.fold(0, math.max) == 0 ? null : weekdays.indexOf(weekdays.fold(0, math.max));

    return Column(
      children: [
        SectionTitle(emoji: '🕰️', title: _t(context, 'clock.title'), subtitle: _persona(context, hours)),
        StatsCard(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: ReadingClock(
                  hours: hours,
                  centerIdle: _t(context, 'clock.center'),
                  label: (hour, chapters) => _t(context, 'clock.hour', {'hour': hour.toString().padLeft(2, '0'), 'amount': chapters}),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  bestDay == null ? '' : _t(context, 'clock.best_day', {'day': fullDayNames[bestDay]}),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 12),
              ColumnBars(
                values: weekdays,
                labels: dayNames,
                highlight: bestDay,
                tooltip: (i, value) => _t(context, 'clock.day_tooltip', {'day': fullDayNames[i], 'amount': value}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Binge extends StatelessWidget {
  final StatsSeries series;

  const _Binge({required this.series});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SectionTitle(emoji: '🍿', title: _t(context, 'binge.title')),
        StatsCard(
          onTap: () => Navigator.of(context).pushNamed(mangaRouteName(series.mangaId)),
          gradient: LinearGradient(
            colors: [statsCategorical[1].withValues(alpha: 0.45), statsSurface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Row(
            children: [
              StatsCover(url: series.hasCover() ? series.cover : null, width: 72, height: 102),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CountUp(
                      value: series.amount.toInt(),
                      format: (v) => _t(context, 'binge.chapters', {'amount': v.round()}),
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _t(context, 'binge.text', {'date': _date(_fromDayMillis(series.at.toInt())), 'title': series.title}),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Taste extends StatelessWidget {
  final DetailedStatsReply data;

  const _Taste({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapters = math.max(1, data.chaptersRead.toInt());

    // Seven categorical slots, everything after folds into "Other".
    final hosts = data.hosts.toList();
    final slices = <(String, int, Color)>[
      for (var i = 0; i < math.min(hosts.length, statsCategorical.length - (hosts.length > statsCategorical.length ? 1 : 0)); i++)
        (hosts[i].name, hosts[i].chapters.toInt(), statsCategorical[i]),
    ];
    final folded = hosts.skip(slices.length).fold(0, (sum, h) => sum + h.chapters.toInt());
    if (folded > 0) slices.add((_t(context, 'taste.other'), folded, statsOther));

    final ongoing = data.seriesOngoing.toInt();

    return Column(
      children: [
        SectionTitle(
          emoji: '🧪',
          title: _t(context, 'taste.title'),
          subtitle: data.genres.isEmpty
              ? null
              : _t(context, 'taste.genre_share', {
                  'percent': (data.genres.first.chapters.toInt() * 100 / chapters).round(),
                  'genre': data.genres.first.name,
                }),
        ),
        if (data.genres.isNotEmpty)
          StatsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_t(context, 'taste.genres'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                RankedBars(
                  rows: [
                    for (final genre in data.genres.take(10))
                      (
                        genre.name,
                        genre.chapters.toInt(),
                        _t(context, 'taste.genre_value', {
                          'chapters': compactNumber(genre.chapters.toInt()),
                          'series': genre.series.toInt(),
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        if (data.authors.isNotEmpty)
          StatsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_t(context, 'taste.authors'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final (i, author) in data.authors.take(5).indexed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(['🥇', '🥈', '🥉', '4', '5'][i], style: theme.textTheme.titleMedium),
                        ),
                        Expanded(child: Text(author.name, maxLines: 1, overflow: TextOverflow.ellipsis)),
                        Text(
                          _t(context, 'taste.chapters_short', {'amount': compactNumber(author.chapters.toInt())}),
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        if (slices.isNotEmpty)
          StatsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_t(context, 'taste.hosts'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Donut(
                      slices: slices,
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${hosts.length}', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                          Text(_t(context, 'taste.sites'), style: theme.textTheme.labelSmall?.copyWith(color: Colors.white60)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final slice in slices)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Tooltip(
                                message: _t(context, 'taste.chapters_short', {'amount': groupDigits(slice.$2)}),
                                child: LegendDot(color: slice.$3, label: slice.$1),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (data.languages.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(_t(context, 'taste.languages'), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final language in data.languages)
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text('${language.name.toUpperCase()} · ${language.series}'),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        if (data.seriesTotal > 0)
          StatsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t(context, 'taste.ongoing', {'amount': ongoing, 'total': data.seriesTotal.toInt()}),
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                SplitBar(
                  parts: [
                    (_t(context, 'taste.publishing'), ongoing, statsCategorical[2]),
                    (_t(context, 'taste.ended'), data.seriesTotal.toInt() - ongoing, statsCategorical[6]),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Library extends StatelessWidget {
  final DetailedStatsReply data;

  const _Library({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backlog = data.backlogChapters.toInt();
    final perDay = data.chapters30d.toInt() / 30;

    return Column(
      children: [
        SectionTitle(emoji: '🏯', title: _t(context, 'library.title')),
        StatsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SplitBar(
                parts: [
                  (_t(context, 'library.completed'), data.seriesCompleted.toInt(), statsCategorical[0]),
                  (_t(context, 'library.in_progress'), data.seriesInProgress.toInt(), statsCategorical[1]),
                  (_t(context, 'library.dropped'), data.seriesDropped.toInt(), statsCategorical[2]),
                  (_t(context, 'library.not_started'), data.seriesNotStarted.toInt(), statsCategorical[3]),
                ],
              ),
            ],
          ),
        ),
        StatsCard(
          gradient: LinearGradient(
            colors: [statsCategorical[4].withValues(alpha: 0.35), statsSurface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Row(
            children: [
              const Text('⛰️', style: TextStyle(fontSize: 48)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CountUp(
                      value: backlog,
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(_t(context, 'library.backlog'), style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 6),
                    Text(
                      backlog == 0
                          ? _t(context, 'library.backlog_none')
                          : perDay <= 0
                              ? _t(context, 'library.backlog_never')
                              : _t(context, 'library.backlog_pace', {
                                  'time': _duration(context, backlog / perDay * 24 * 60),
                                }),
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HallOfFame extends StatelessWidget {
  final DetailedStatsReply data;

  const _HallOfFame({required this.data});

  void _open(BuildContext context, StatsSeries series) => Navigator.of(context).pushNamed(mangaRouteName(series.mangaId));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mostRead = data.mostRead;

    Widget podiumSpot(StatsSeries series, int place, double height) {
      final medal = ['🥇', '🥈', '🥉'][place];
      return Expanded(
        child: GestureDetector(
          onTap: () => _open(context, series),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatsCover(url: series.hasCover() ? series.cover : null, width: 72, height: 102),
              const SizedBox(height: 6),
              Text(
                series.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: height),
                duration: Duration(milliseconds: 900 + place * 200),
                curve: Curves.easeOutBack,
                builder: (context, h, _) => Container(
                  height: math.max(0, h),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: statsSequential[3 - place],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(medal, style: const TextStyle(fontSize: 22)),
                      Text(
                        _t(context, 'taste.chapters_short', {'amount': compactNumber(series.amount.toInt())}),
                        style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget seriesRow(StatsSeries series, String subtitle, {String? leading}) => ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () => _open(context, series),
          leading: StatsCover(url: series.hasCover() ? series.cover : null, width: 40, height: 56),
          title: Text(series.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
          trailing: leading == null ? null : Text(leading, style: const TextStyle(fontSize: 22)),
        );

    return Column(
      children: [
        if (mostRead.isNotEmpty) ...[
          SectionTitle(emoji: '🏆', title: _t(context, 'library.most_read')),
          StatsCard(
            child: Column(
              children: [
                if (mostRead.length >= 3)
                  SizedBox(
                    height: 290,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        podiumSpot(mostRead[1], 1, 70),
                        podiumSpot(mostRead[0], 0, 100),
                        podiumSpot(mostRead[2], 2, 50),
                      ],
                    ),
                  ),
                for (final (i, series) in mostRead.skip(mostRead.length >= 3 ? 3 : 0).indexed)
                  seriesRow(
                    series,
                    _t(context, 'taste.chapters_short', {'amount': groupDigits(series.amount.toInt())}),
                    leading: '#${i + (mostRead.length >= 3 ? 4 : 1)}',
                  ),
              ],
            ),
          ),
        ],
        if (data.hasFastestFinish() || data.hasLongestRelationship())
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.hasFastestFinish())
                  Expanded(
                    child: _MiniCard(
                      emoji: '🏃',
                      title: _t(context, 'library.fastest'),
                      series: data.fastestFinish,
                      text: _t(context, 'library.fastest_text', {
                        'chapters': groupDigits(data.fastestFinish.total.toInt()),
                        'days': data.fastestFinish.amount.toInt(),
                      }),
                      onTap: () => _open(context, data.fastestFinish),
                    ),
                  ),
                if (data.hasLongestRelationship())
                  Expanded(
                    child: _MiniCard(
                      emoji: '💍',
                      title: _t(context, 'library.relationship'),
                      series: data.longestRelationship,
                      text: _t(context, 'library.relationship_text', {
                        'days': groupDigits(data.longestRelationship.amount.toInt()),
                      }),
                      onTap: () => _open(context, data.longestRelationship),
                    ),
                  ),
              ],
            ),
          ),
        if (data.recentlyFinished.isNotEmpty) ...[
          SectionTitle(emoji: '🎓', title: _t(context, 'library.recently_finished')),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: data.recentlyFinished.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final series = data.recentlyFinished[index];
                return GestureDetector(
                  onTap: () => _open(context, series),
                  child: SizedBox(
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            StatsCover(url: series.hasCover() ? series.cover : null, width: 90, height: 126),
                            const Positioned(right: 4, top: 4, child: Text('✅', style: TextStyle(fontSize: 18))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(series.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.labelSmall),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        if (data.abandoned.isNotEmpty) ...[
          SectionTitle(emoji: '🥺', title: _t(context, 'library.abandoned'), subtitle: _t(context, 'library.abandoned_subtitle')),
          StatsCard(
            child: Column(
              children: [
                for (final series in data.abandoned)
                  seriesRow(
                    series,
                    _t(context, 'library.abandoned_days', {
                      'days': groupDigits(series.amount.toInt()),
                      'progress': groupDigits(series.progress.toInt()),
                      'total': groupDigits(series.total.toInt()),
                    }),
                    leading: '💔',
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String emoji;
  final String title;
  final StatsSeries series;
  final String text;
  final VoidCallback onTap;

  const _MiniCard({required this.emoji, required this.title, required this.series, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: statsSurface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$emoji $title', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                StatsCover(url: series.hasCover() ? series.cover : null, width: 56, height: 80),
                const SizedBox(height: 8),
                Text(series.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(text, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Friends extends StatelessWidget {
  final List<StatsFriend> friends;

  const _Friends({required this.friends});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final best = friends.fold(0, (m, f) => math.max(m, f.chapters30d.toInt()));

    return Column(
      children: [
        SectionTitle(emoji: '⚔️', title: _t(context, 'friends.title'), subtitle: _t(context, 'friends.subtitle')),
        StatsCard(
          child: Column(
            children: [
              for (final (i, friend) in friends.indexed)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: friend.isMe ? Colors.white.withValues(alpha: 0.07) : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 32,
                            child: Text(i < 3 ? ['🥇', '🥈', '🥉'][i] : '#${i + 1}', style: theme.textTheme.titleMedium),
                          ),
                          Expanded(
                            child: Text(
                              friend.isMe ? '${friend.username} (${_t(context, 'friends.you')})' : friend.username,
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (friend.currentStreak > 0) Text('🔥${friend.currentStreak}  ', style: theme.textTheme.bodySmall),
                          Text(
                            _t(context, 'taste.chapters_short', {'amount': groupDigits(friend.chapters30d.toInt())}),
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: best == 0 ? 0 : friend.chapters30d.toInt() / best),
                            duration: Duration(milliseconds: 900 + i * 120),
                            curve: Curves.easeOutCubic,
                            builder: (context, t, _) => LinearProgressIndicator(
                              value: t,
                              minHeight: 6,
                              backgroundColor: statsEmpty,
                              color: friend.isMe ? statsSequential.last : statsSequential[2],
                            ),
                          ),
                        ),
                      ),
                      if (!friend.isMe)
                        Padding(
                          padding: const EdgeInsets.only(left: 32, top: 6),
                          child: Text(
                            friend.sharedCount == 0
                                ? _t(context, 'friends.nothing_shared', {'total': compactNumber(friend.chaptersTotal.toInt())})
                                : _t(context, 'friends.shared', {
                                    'amount': friend.sharedCount.toInt(),
                                    'titles': friend.sharedTitles.join(', '),
                                    'total': compactNumber(friend.chaptersTotal.toInt()),
                                  }),
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Reader types, first match wins; every match shows as a badge.
List<String> _personas(DetailedStatsReply data) {
  final hours = data.hours.map((h) => h.toInt()).toList();
  final opened = hours.fold(0, (a, b) => a + b);
  final night = [22, 23, 0, 1, 2, 3, 4].fold(0, (sum, h) => sum + (hours.length == 24 ? hours[h] : 0));
  final total = math.max(1, data.seriesTotal.toInt());
  final read = math.max(1, data.chaptersRead.toInt());
  return [
    if (opened >= 20 && night / opened >= 0.35) 'night_owl',
    if (data.hasBiggestBinge() && data.biggestBinge.amount >= 25) 'binger',
    if (data.seriesCompleted.toInt() / total >= 0.35) 'completionist',
    if (data.genres.isNotEmpty && data.genres.first.chapters.toInt() / read >= 0.8) 'loyalist',
    if ((data.seriesNotStarted + data.seriesDropped).toInt() / total >= 0.5) 'collector',
    if (data.longestStreak >= 7) 'disciplined',
    'steady',
  ];
}

class _Wrapped extends StatefulWidget {
  final DetailedStatsReply data;

  const _Wrapped({required this.data});

  @override
  State<_Wrapped> createState() => _WrappedState();
}

class _WrappedState extends State<_Wrapped> {
  final _controller = PageController(viewportFraction: 0.86);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final year = data.year;
    final theme = Theme.of(context);
    final personas = _personas(data);
    final big = theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, color: Colors.white);
    final label = theme.textTheme.titleMedium?.copyWith(color: Colors.white70);
    final monthNames = [for (var m = 1; m <= 12; m++) Jiffy.parseFromDateTime(DateTime(year.year, m)).MMM];

    final gradients = [
      statsGradient,
      const LinearGradient(colors: [Color(0xFF1C5CAB), Color(0xFF199E70)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFFB0306E), Color(0xFF6250D6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFFC98500), Color(0xFFD95926)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      const LinearGradient(colors: [Color(0xFF3B1E7A), Color(0xFF0D366B)], begin: Alignment.topLeft, end: Alignment.bottomRight),
    ];

    final cards = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_t(context, 'year.intro', {'year': year.year}), style: label),
          CountUp(value: year.chapters.toInt(), style: big),
          Text(_t(context, 'year.chapters'), style: label),
          const SizedBox(height: 16),
          Text(_t(context, 'year.minutes', {'time': _duration(context, year.minutes.toInt())}), style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Text('🌱 ${_t(context, 'year.new_series', {'amount': year.newSeries.toInt()})}'),
              Text('✅ ${_t(context, 'year.finished', {'amount': year.finishedSeries.toInt()})}'),
              Text('📅 ${_t(context, 'year.active_days', {'amount': year.activeDays.toInt()})}'),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_t(context, 'year.top_series'), style: label),
          const SizedBox(height: 12),
          if (year.hasTopSeries()) ...[
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(mangaRouteName(year.topSeries.mangaId)),
              child: StatsCover(url: year.topSeries.hasCover() ? year.topSeries.cover : null, width: 100, height: 142),
            ),
            const SizedBox(height: 12),
            Text(year.topSeries.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            Text(_t(context, 'year.top_series_chapters', {'amount': year.topSeries.amount.toInt()}), style: label),
          ] else
            Text('🤷', style: big),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_t(context, 'year.top_genre'), style: label),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(year.hasTopGenre() ? year.topGenre : '🤷', style: big),
          ),
          const SizedBox(height: 24),
          Text(
            year.topMonth == 0
                ? _t(context, 'year.no_month')
                : _t(context, 'year.top_month', {
                    'month': Jiffy.parseFromDateTime(DateTime(year.year, year.topMonth)).MMMM,
                    'amount': year.topMonthChapters.toInt(),
                  }),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (year.months.length == 12)
            ColumnBars(
              height: 70,
              values: year.months.map((m) => m.toInt()).toList(),
              labels: [for (final name in monthNames) name.substring(0, 1)],
              highlight: year.topMonth == 0 ? null : year.topMonth - 1,
              tooltip: (i, value) => '${monthNames[i]}: ${_t(context, 'taste.chapters_short', {'amount': value})}',
            ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_t(context, 'year.persona'), style: label),
          const SizedBox(height: 8),
          Text(_personaEmoji[personas.first]!, style: const TextStyle(fontSize: 56)),
          Text(
            _t(context, 'personas.${personas.first}.name'),
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(_t(context, 'personas.${personas.first}.description'), style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final persona in personas.skip(1).where((p) => p != 'steady'))
                Chip(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: Colors.black26,
                  label: Text('${_personaEmoji[persona]} ${_t(context, 'personas.$persona.name')}'),
                ),
            ],
          ),
        ],
      ),
    ];

    return Column(
      children: [
        SectionTitle(emoji: '🎁', title: _t(context, 'year.title', {'year': year.year}), subtitle: _t(context, 'facts.subtitle')),
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _controller,
            itemCount: cards.length,
            itemBuilder: (context, index) => AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final page = _controller.hasClients && _controller.position.haveDimensions ? _controller.page ?? 0 : 0.0;
                final offset = (index - page).clamp(-1.0, 1.0);
                return Transform(
                  alignment: offset > 0 ? Alignment.centerLeft : Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(offset * -0.5),
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: gradients[index % gradients.length],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: DefaultTextStyle.merge(style: const TextStyle(color: Colors.white), child: cards[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
