import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/scraper.pb.dart';
import 'package:wuxia/util/session.dart';

class ScraperStatusScreen extends StatefulWidget {
  const ScraperStatusScreen({super.key});

  @override
  State<ScraperStatusScreen> createState() => _ScraperStatusScreenState();
}

class _ScraperStatusScreenState extends State<ScraperStatusScreen> {
  // A web deep link can land here directly, skipping the screens that
  // normally restore credentials before this screen reads API.loggedIn.
  bool _ready = false;
  late Future<ScraperStatusReply> _future;

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

    // Defense in depth: the settings menu already hides this entry point for
    // non-admins, but a deep link could still land here directly.
    if (!API.loggedIn.isAdmin) {
      Navigator.of(context).pushReplacementNamed('root_nav');
      return;
    }

    setState(() {
      _ready = true;
      _future = api.scraper.status(ScraperStatusRequest());
    });
  }

  void _refresh() {
    setState(() => _future = api.scraper.status(ScraperStatusRequest()));
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: I18nText('settings.scraper_status.title'),
        actions: [
          IconButton(
            tooltip: FlutterI18n.translate(context, 'basic.refresh'),
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: FutureBuilder<ScraperStatusReply>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          final items = snapshot.requireData.items;
          if (items.isEmpty) {
            return Center(child: I18nText('settings.scraper_status.empty'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              _refresh();
              await _future;
            },
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) =>
                  _ScraperStatusTile(status: items[index]),
            ),
          );
        },
      ),
    );
  }
}

class _ScraperStatusTile extends StatelessWidget {
  final ScraperStatus status;

  const _ScraperStatusTile({required this.status});

  @override
  Widget build(BuildContext context) {
    final healthy = status.lastAttemptSuccess;

    return ExpansionTile(
      leading: Icon(
        healthy ? Icons.check_circle : Icons.error,
        color: healthy ? Colors.green : Colors.red,
      ),
      title: Text(status.hostname,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(_subtitle(context)),
      children: status.recentErrors.isEmpty
          ? [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: I18nText('settings.scraper_status.no_recent_errors'),
              ),
            ]
          : status.recentErrors
              .map((error) => _ScraperErrorTile(error: error))
              .toList(),
    );
  }

  String _subtitle(BuildContext context) {
    final lastAttempt = status.hasLastAttemptAt()
        ? FlutterI18n.translate(
            context,
            'settings.scraper_status.last_attempt',
            translationParams: {
              'time': Jiffy.parseFromMillisecondsSinceEpoch(
                      status.lastAttemptAt.toInt())
                  .fromNow()
            },
          )
        : FlutterI18n.translate(
            context, 'settings.scraper_status.never_attempted');

    final lastSuccess = status.hasLastSuccessAt()
        ? FlutterI18n.translate(
            context,
            'settings.scraper_status.last_success',
            translationParams: {
              'time': Jiffy.parseFromMillisecondsSinceEpoch(
                      status.lastSuccessAt.toInt())
                  .fromNow()
            },
          )
        : FlutterI18n.translate(
            context, 'settings.scraper_status.never_succeeded');

    final stats24h = FlutterI18n.translate(
      context,
      'settings.scraper_status.stats_24h',
      translationParams: {
        'attempts': status.attempts24h.toString(),
        'failures': status.failures24h.toString(),
      },
    );

    return '$lastAttempt\n$lastSuccess · $stats24h';
  }
}

class _ScraperErrorTile extends StatelessWidget {
  final ScraperErrorEntry error;

  const _ScraperErrorTile({required this.error});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(error.message, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${error.errorType.name} · ${error.operation} · ${Jiffy.parseFromMillisecondsSinceEpoch(error.createdAt.toInt()).fromNow()}',
      ),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error.errorType.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(error.url),
                const SizedBox(height: 8),
                SelectableText(error.message),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(FlutterI18n.translate(
                  context, 'settings.scraper_status.close')),
            ),
          ],
        ),
      ),
    );
  }
}
