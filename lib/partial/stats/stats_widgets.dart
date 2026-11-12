import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';

/// Categorical slots in fixed order (dark-surface steps), for charts that tell series apart.
const statsCategorical = [
  Color(0xFF3987E5),
  Color(0xFFD95926),
  Color(0xFF199E70),
  Color(0xFFC98500),
  Color(0xFFD55181),
  Color(0xFF008300),
  Color(0xFF9085E9),
];
const statsOther = Color(0xFF6B6A66);

/// One hue, light to dark, for magnitude.
const statsSequential = [
  Color(0xFF2B2346),
  Color(0xFF4A3A8C),
  Color(0xFF6C55C7),
  Color(0xFF9580F0),
  Color(0xFFC6B8FF),
];
const statsEmpty = Color(0xFF1C1B22);
const statsSurface = Color(0xFF121117);

const statsGradient = LinearGradient(
  colors: [Color(0xFF5B2BB5), Color(0xFFB0306E), Color(0xFFE0703A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

/// 1234567 -> "1,234,567".
String groupDigits(num value) {
  final text = value.round().abs().toString();
  final buffer = StringBuffer(value < 0 ? '-' : '');
  for (var i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) buffer.write(',');
    buffer.write(text[i]);
  }
  return buffer.toString();
}

/// 1234567 -> "1.2M", 15925 -> "15.9k".
String compactNumber(num value) {
  final v = value.abs();
  String trim(double n) => n >= 100 ? n.toStringAsFixed(0) : n.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  if (v >= 1e9) return '${value < 0 ? '-' : ''}${trim(v / 1e9)}B';
  if (v >= 1e6) return '${value < 0 ? '-' : ''}${trim(v / 1e6)}M';
  if (v >= 1e4) return '${value < 0 ? '-' : ''}${trim(v / 1e3)}k';
  return groupDigits(value);
}

/// Fades and slides its child in the first time it's built, which in a lazily built list is
/// when it scrolls into view.
class Reveal extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 650));
  late final Animation<double> _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder: (context, child) {
        final t = _curve.value;
        return Opacity(
          opacity: _controller.value,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 40),
            child: Transform.scale(scale: 0.92 + 0.08 * t, child: child),
          ),
        );
      },
    );
  }
}

/// Counts up from zero to [value].
class CountUp extends StatelessWidget {
  final num value;
  final String Function(num value) format;
  final TextStyle? style;
  final Duration duration;

  const CountUp({
    super.key,
    required this.value,
    this.format = groupDigits,
    this.style,
    this.duration = const Duration(milliseconds: 1600),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutExpo,
      builder: (context, v, _) => Text(format(v), style: style),
    );
  }
}

class StatsCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const StatsCard({super.key, required this.child, this.gradient, this.padding = const EdgeInsets.all(16), this.onTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: gradient == null ? statsSurface : Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: radius,
            border: gradient == null ? Border.all(color: Colors.white.withValues(alpha: 0.06)) : null,
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String emoji;
  final String title;
  final String? subtitle;

  const SectionTitle({super.key, required this.emoji, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                if (subtitle != null)
                  Text(subtitle!, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsCover extends StatelessWidget {
  final String? url;
  final double width;
  final double height;

  const StatsCover({super.key, required this.url, this.width = 48, this.height = 68});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: url == null || url!.isEmpty
            ? Container(color: statsEmpty, child: const Center(child: Text('📖', style: TextStyle(fontSize: 20))))
            : CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const ImageErrorPlaceholder(),
              ),
      ),
    );
  }
}

class LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const LegendDot({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
      ],
    );
  }
}

/// GitHub-style calendar: one column per week, Monday on top, scrolled to today.
class ActivityHeatmap extends StatefulWidget {
  /// Days since epoch -> chapters.
  final Map<int, int> days;
  final int today;
  final int weeks;
  final List<String> weekdayLabels;
  final String Function(DateTime date) monthLabel;
  final String Function(DateTime date, int chapters) tooltip;

  const ActivityHeatmap({
    super.key,
    required this.days,
    required this.today,
    required this.weekdayLabels,
    required this.monthLabel,
    required this.tooltip,
    this.weeks = 53,
  });

  @override
  State<ActivityHeatmap> createState() => _ActivityHeatmapState();
}

class _ActivityHeatmapState extends State<ActivityHeatmap> {
  final _scroll = ScrollController();

  static const _cell = 13.0;
  static const _gap = 2.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Color _color(int chapters, int max) {
    if (chapters <= 0) return statsEmpty;
    if (max <= 1) return statsSequential.last;
    final step = ((chapters / max) * (statsSequential.length - 1)).ceil().clamp(1, statsSequential.length - 1);
    return statsSequential[step];
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.utc(1970).add(Duration(days: widget.today));
    // Monday of the first column.
    final startDay = widget.today - (today.weekday - 1) - (widget.weeks - 1) * 7;
    final max = widget.days.values.fold(0, math.max);
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white54, fontSize: 9);

    final columns = <Widget>[];
    for (var week = 0; week < widget.weeks; week++) {
      final firstDay = startDay + week * 7;
      final firstDate = DateTime.utc(1970).add(Duration(days: firstDay));
      final showMonth = firstDate.day <= 7;
      columns.add(
        Padding(
          padding: const EdgeInsets.only(right: _gap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
                width: _cell,
                child: OverflowBox(
                  maxWidth: 40,
                  alignment: Alignment.centerLeft,
                  child: showMonth ? Text(widget.monthLabel(firstDate), style: labelStyle) : null,
                ),
              ),
              for (var d = 0; d < 7; d++)
                Builder(builder: (context) {
                  final day = firstDay + d;
                  if (day > widget.today) return const SizedBox(width: _cell, height: _cell + _gap);
                  final chapters = widget.days[day] ?? 0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: _gap),
                    child: Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: widget.tooltip(DateTime.utc(1970).add(Duration(days: day)), chapters),
                      child: Container(
                        width: _cell,
                        height: _cell,
                        decoration: BoxDecoration(
                          color: _color(chapters, max),
                          borderRadius: BorderRadius.circular(3),
                          border: day == widget.today ? Border.all(color: Colors.white70, width: 1) : null,
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var d = 0; d < 7; d++)
                SizedBox(
                  height: _cell + _gap,
                  child: d.isEven ? Text(widget.weekdayLabels[d], style: labelStyle) : null,
                ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: columns),
          ),
        ),
      ],
    );
  }
}

/// Twenty-four bars around a clock face; tap a bar to read it in the middle.
class ReadingClock extends StatefulWidget {
  final List<int> hours;
  final String Function(int hour, int chapters) label;
  final String centerIdle;

  const ReadingClock({super.key, required this.hours, required this.label, required this.centerIdle});

  @override
  State<ReadingClock> createState() => _ReadingClockState();
}

class _ReadingClockState extends State<ReadingClock> with SingleTickerProviderStateMixin {
  late final AnimationController _grow = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
    ..forward();
  int? _selected;

  @override
  void dispose() {
    _grow.dispose();
    super.dispose();
  }

  void _select(Offset position, Size size) {
    final center = size.center(Offset.zero);
    final delta = position - center;
    if (delta.distance < size.shortestSide * 0.18) {
      setState(() => _selected = null);
      return;
    }
    // 0h at the top, clockwise.
    var angle = math.atan2(delta.dx, -delta.dy);
    if (angle < 0) angle += 2 * math.pi;
    setState(() => _selected = (angle / (2 * math.pi) * 24).floor() % 24);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        final size = constraints.biggest;
        return GestureDetector(
          onTapDown: (details) => _select(details.localPosition, size),
          onPanUpdate: (details) => _select(details.localPosition, size),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _grow,
                builder: (context, _) => CustomPaint(
                  size: size,
                  painter: _ClockPainter(
                    hours: widget.hours,
                    progress: Curves.elasticOut.transform(_grow.value),
                    selected: _selected,
                    labelStyle: theme.textTheme.labelSmall!.copyWith(color: Colors.white54),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.34,
                child: Text(
                  _selected == null ? widget.centerIdle : widget.label(_selected!, widget.hours[_selected!]),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final List<int> hours;
  final double progress;
  final int? selected;
  final TextStyle labelStyle;

  _ClockPainter({required this.hours, required this.progress, required this.selected, required this.labelStyle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.shortestSide / 2 - 16;
    final inner = outer * 0.38;
    final max = hours.fold(0, math.max);

    final ring = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, inner, ring);
    canvas.drawCircle(center, outer, ring);

    for (var h = 0; h < 24; h++) {
      final angle = h / 24 * 2 * math.pi - math.pi / 2 + (math.pi / 24);
      final value = max == 0 ? 0.0 : hours[h] / max;
      final length = (outer - inner) * value * progress;
      final direction = Offset(math.cos(angle), math.sin(angle));
      final from = center + direction * inner;
      final to = center + direction * (inner + math.max(length, 2));
      final isSelected = selected == h;
      final paint = Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = isSelected ? 10 : 7
        ..color = isSelected
            ? Colors.white
            : statsSequential[(1 + (value * (statsSequential.length - 2)).round()).clamp(1, statsSequential.length - 1)];
      canvas.drawLine(from, to, paint);
    }

    for (final h in const [0, 6, 12, 18]) {
      final angle = h / 24 * 2 * math.pi - math.pi / 2;
      final position = center + Offset(math.cos(angle), math.sin(angle)) * (outer + 9);
      final painter = TextPainter(
        text: TextSpan(text: '$h', style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(canvas, position - Offset(painter.width / 2, painter.height / 2));
    }
  }

  @override
  bool shouldRepaint(_ClockPainter old) => old.progress != progress || old.selected != selected || old.hours != hours;
}

/// Vertical bars with labels underneath and a tooltip per bar; [highlight] gets the brightest step.
class ColumnBars extends StatelessWidget {
  final List<int> values;
  final List<String> labels;
  final String Function(int index, int value) tooltip;
  final double height;
  final int? highlight;

  const ColumnBars({
    super.key,
    required this.values,
    required this.labels,
    required this.tooltip,
    this.height = 110,
    this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    final max = values.fold(0, math.max);
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white54);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < values.length; i++)
          Expanded(
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: tooltip(i, values[i]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: max == 0 ? 0 : values[i] / max),
                      duration: Duration(milliseconds: 700 + i * 60),
                      curve: Curves.easeOutBack,
                      builder: (context, t, _) => Container(
                        height: math.max(3, height * t),
                        decoration: BoxDecoration(
                          color: i == highlight ? statsSequential.last : statsSequential[2],
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(labels[i], style: labelStyle, maxLines: 1, overflow: TextOverflow.clip),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A ranked list of horizontal bars, label and value in text ink beside the bar.
class RankedBars extends StatelessWidget {
  final List<(String, int, String)> rows;

  const RankedBars({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final max = rows.fold(0, (m, row) => math.max(m, row.$2));
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(rows[i].$1, style: theme.textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Text(rows[i].$3, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
                  ],
                ),
                const SizedBox(height: 4),
                LayoutBuilder(builder: (context, constraints) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: max == 0 ? 0 : rows[i].$2 / max),
                      duration: Duration(milliseconds: 800 + i * 90),
                      curve: Curves.easeOutCubic,
                      builder: (context, t, _) => Container(
                        width: math.max(4, constraints.maxWidth * t),
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == 0 ? statsSequential.last : statsSequential[3],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}

/// Segments of a whole as one rounded bar, 2px surface gaps between segments, legend below.
class SplitBar extends StatelessWidget {
  final List<(String, int, Color)> parts;

  const SplitBar({super.key, required this.parts});

  @override
  Widget build(BuildContext context) {
    final visible = parts.where((p) => p.$2 > 0).toList();
    final total = visible.fold(0, (sum, p) => sum + p.$2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 22,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, t, _) => Row(
                children: [
                  for (var i = 0; i < visible.length; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    Expanded(
                      flex: math.max(1, (visible[i].$2 * 1000 * t).round()),
                      child: Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        message: '${visible[i].$1}: ${groupDigits(visible[i].$2)}',
                        child: Container(color: visible[i].$3),
                      ),
                    ),
                  ],
                  if (t < 1) Expanded(flex: math.max(1, (total * 1000 * (1 - t)).round()), child: const SizedBox()),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: [
            for (final p in parts) LegendDot(color: p.$3, label: '${p.$1} · ${groupDigits(p.$2)}'),
          ],
        ),
      ],
    );
  }
}

/// A donut with a 2px surface gap between slices and the total in the middle.
class Donut extends StatelessWidget {
  final List<(String, int, Color)> slices;
  final Widget center;

  const Donut({super.key, required this.slices, required this.center});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1300),
        curve: Curves.easeOutCubic,
        builder: (context, t, child) => CustomPaint(painter: _DonutPainter(slices, t), child: child),
        child: Center(child: center),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<(String, int, Color)> slices;
  final double progress;

  _DonutPainter(this.slices, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final total = slices.fold(0, (sum, s) => sum + s.$2);
    if (total == 0) return;
    const stroke = 18.0;
    final rect = Rect.fromCircle(center: size.center(Offset.zero), radius: size.shortestSide / 2 - stroke / 2);
    final radius = rect.width / 2;
    final gap = slices.length > 1 ? 2 / radius : 0.0;
    var start = -math.pi / 2;
    for (final slice in slices) {
      final sweep = slice.$2 / total * 2 * math.pi * progress;
      if (sweep - gap > 0) {
        canvas.drawArc(
          rect,
          start + gap / 2,
          sweep - gap,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = stroke
            ..color = slice.$3,
        );
      }
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.progress != progress || old.slices != slices;
}

/// Tap anywhere on [child] to make it rain [emojis].
class EmojiRain extends StatefulWidget {
  final Widget child;
  final List<String> emojis;

  const EmojiRain({super.key, required this.child, required this.emojis});

  @override
  State<EmojiRain> createState() => EmojiRainState();
}

class _Drop {
  final String emoji;
  final double x;
  final double delay;
  final double speed;
  final double spin;
  final double size;

  _Drop(math.Random random, List<String> emojis)
      : emoji = emojis[random.nextInt(emojis.length)],
        x = random.nextDouble(),
        delay = random.nextDouble() * 0.35,
        speed = 0.7 + random.nextDouble() * 0.6,
        spin = (random.nextDouble() - 0.5) * 6,
        size = 18 + random.nextDouble() * 22;
}

class EmojiRainState extends State<EmojiRain> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
  final _random = math.Random();
  List<_Drop> _drops = [];

  void rain() {
    setState(() => _drops = List.generate(36, (_) => _Drop(_random, widget.emojis)));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: rain,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  if (!_controller.isAnimating) return const SizedBox();
                  return LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for (final drop in _drops)
                          Builder(builder: (context) {
                            final t = ((_controller.value - drop.delay) / (1 - drop.delay)).clamp(0.0, 1.0);
                            if (t <= 0) return const SizedBox();
                            final fall = t * drop.speed * (constraints.maxHeight + 120) - 60;
                            return Positioned(
                              left: drop.x * constraints.maxWidth - drop.size / 2,
                              top: fall,
                              child: Opacity(
                                opacity: (1 - t).clamp(0.0, 1.0),
                                child: Transform.rotate(
                                  angle: drop.spin * t,
                                  child: Text(drop.emoji, style: TextStyle(fontSize: drop.size)),
                                ),
                              ),
                            );
                          }),
                      ],
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
