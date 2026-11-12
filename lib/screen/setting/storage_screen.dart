import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/admin.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/logged_in_gate.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/partial/stats/stats_widgets.dart';
import 'package:wuxia/util/app_routes.dart';

String _t(BuildContext context, String key, [Map<String, Object>? params]) => FlutterI18n.translate(
      context,
      'settings.storage.$key',
      translationParams: params?.map((k, v) => MapEntry(k, v.toString())),
    );

/// 1536 -> "1.5 KB", 19040000000 -> "19.0 GB".
String formatBytes(num bytes) {
  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  var value = bytes.toDouble();
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  return '${value.toStringAsFixed(unit == 0 || value >= 100 ? 0 : 1)} ${units[unit]}';
}

/// Admin-only: how much disk and database space rumgap takes up, and where it goes.
class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) => LoggedInGate(
        builder: (context) {
          // The settings menu hides this entry point for non-admins, but a deep link could land here.
          if (!API.loggedIn.isAdmin) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context).pushReplacementNamed('root_nav'));
            return const Scaffold();
          }
          return const _Storage();
        },
      );
}

class _Storage extends StatefulWidget {
  const _Storage();

  @override
  State<_Storage> createState() => _StorageState();
}

class _StorageState extends State<_Storage> {
  late Future<StorageReply> _storage = api.admin.storage(Empty());

  Future<void> _refresh() async {
    final next = api.admin.storage(Empty());
    setState(() => _storage = next);
    await next;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_t(context, 'title')),
        actions: [IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh))],
      ),
      body: SimpleFutureBuilder<StorageReply>(
        future: _storage,
        onErrorBuilder: (context, error) => Center(child: Text(errorMessage(error ?? ''))),
        onLoadedBuilder: (context, data) => RefreshIndicator(
          onRefresh: _refresh,
          child: ResponsiveContent(child: _StorageBody(data: data)),
        ),
      ),
    );
  }
}

class _StorageBody extends StatelessWidget {
  final StorageReply data;

  const _StorageBody({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = data.diskBytes.toInt() + data.databaseBytes.toInt();
    final title = theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700);
    final muted = theme.textTheme.bodySmall?.copyWith(color: Colors.white60);

    // Fixed slot per kind, so a kind keeps its colour even when another is empty.
    final kinds = {'pages': 0, 'resized': 1, 'covers': 2, 'other': 4};
    final slices = <(String, int, Color)>[
      for (final bucket in data.disk)
        (_t(context, 'kind.${bucket.name}'), bucket.bytes.toInt(), statsCategorical[kinds[bucket.name] ?? 4]),
      (_t(context, 'kind.database'), data.databaseBytes.toInt(), statsCategorical[3]),
    ];

    final sections = <Widget>[
      StatsCard(
        gradient: statsGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_t(context, 'total').toUpperCase(), style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70, letterSpacing: 2)),
            CountUp(
              value: total,
              format: formatBytes,
              style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, color: Colors.white),
            ),
            Text(
              _t(context, 'files', {'files': groupDigits(data.diskFiles.toInt()), 'pages': groupDigits(data.pagesStored.toInt())}),
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            if (data.hasVolumeTotalBytes()) ...[
              const SizedBox(height: 16),
              _VolumeBar(total: data.volumeTotalBytes.toInt(), free: data.volumeFreeBytes.toInt(), ours: total),
            ],
          ],
        ),
      ),
      StatsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_t(context, 'breakdown'), style: title),
            const SizedBox(height: 12),
            Row(
              children: [
                Donut(
                  slices: slices.where((s) => s.$2 > 0).toList(),
                  center: Text(formatBytes(total), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final slice in slices)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: LegendDot(color: slice.$3, label: '${slice.$1} · ${formatBytes(slice.$2)}'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      StatsCard(
        child: Row(
          children: [
            Expanded(child: _Count(value: data.pagesStored.toInt(), label: _t(context, 'pages_stored'))),
            Expanded(child: _Count(value: data.pagesPending.toInt(), label: _t(context, 'pages_pending'))),
            Expanded(child: _Count(value: data.pagesFailed.toInt(), label: _t(context, 'pages_failed'))),
          ],
        ),
      ),
      if (data.hosts.isNotEmpty)
        StatsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t(context, 'by_site'), style: title),
              const SizedBox(height: 8),
              RankedBars(
                rows: [
                  for (final host in data.hosts.take(10))
                    (
                      host.title,
                      host.bytes.toInt(),
                      _t(context, 'group_value', {
                        'bytes': formatBytes(host.bytes.toInt()),
                        'chapters': groupDigits(host.chapters.toInt()),
                      }),
                    ),
                ],
              ),
            ],
          ),
        ),
      if (data.manga.isNotEmpty)
        StatsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t(context, 'by_manga'), style: title),
              const SizedBox(height: 4),
              for (final manga in data.manga)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    final id = int.tryParse(manga.key);
                    if (id != null) Navigator.of(context).pushNamed(mangaRouteName(id));
                  },
                  leading: StatsCover(url: manga.hasCover() ? manga.cover : null, width: 40, height: 56),
                  title: Text(manga.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    _t(context, 'manga_value', {
                      'chapters': groupDigits(manga.chapters.toInt()),
                      'pages': groupDigits(manga.pages.toInt()),
                    }),
                    style: muted,
                  ),
                  trailing: Text(formatBytes(manga.bytes.toInt()), style: title),
                ),
            ],
          ),
        ),
      if (data.tables.isNotEmpty)
        StatsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t(context, 'database', {'size': formatBytes(data.databaseBytes.toInt())}), style: title),
              const SizedBox(height: 8),
              RankedBars(
                rows: [
                  for (final table in data.tables)
                    (
                      table.name,
                      table.bytes.toInt(),
                      _t(context, 'table_value', {
                        'bytes': formatBytes(table.bytes.toInt()),
                        'rows': compactNumber(table.files.toInt()),
                      }),
                    ),
                ],
              ),
            ],
          ),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        child: Text(
          _t(context, 'measured', {
            'ago': Jiffy.parseFromMillisecondsSinceEpoch(data.measuredAt.toInt()).fromNow(),
            'ms': groupDigits(data.scanMillis.toInt()),
          }),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white38),
        ),
      ),
    ];

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8),
      itemCount: sections.length,
      itemBuilder: (context, index) => Reveal(delay: Duration(milliseconds: index < 3 ? index * 100 : 0), child: sections[index]),
    );
  }
}

class _Count extends StatelessWidget {
  final int value;
  final String label;

  const _Count({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CountUp(value: value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        Text(label, textAlign: TextAlign.center, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
      ],
    );
  }
}

/// How full the disk is, with rumgap's own share marked.
class _VolumeBar extends StatelessWidget {
  final int total;
  final int free;
  final int ours;

  const _VolumeBar({required this.total, required this.free, required this.ours});

  @override
  Widget build(BuildContext context) {
    final used = math.max(0, total - free);
    final others = math.max(0, used - ours);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 14,
            child: Row(
              children: [
                if (ours > 0) Expanded(flex: math.max(1, ours * 1000 ~/ math.max(1, total)), child: Container(color: Colors.white)),
                if (ours > 0 && others > 0) const SizedBox(width: 2),
                if (others > 0)
                  Expanded(flex: math.max(1, others * 1000 ~/ math.max(1, total)), child: Container(color: Colors.white38)),
                if (free > 0) const SizedBox(width: 2),
                if (free > 0) Expanded(flex: math.max(1, free * 1000 ~/ math.max(1, total)), child: Container(color: Colors.black26)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _t(context, 'volume', {'free': formatBytes(free), 'total': formatBytes(total)}),
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
