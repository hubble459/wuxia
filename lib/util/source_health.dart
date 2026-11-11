import 'package:flutter/foundation.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/scraper.pb.dart';

/// Which sources' websites are currently failing to scrape, from
/// `Scraper.Status`. Fetched at most every [_maxAge] and shared app-wide;
/// listen to [down] to update when it changes.
class SourceHealth {
  static final down = ValueNotifier<Set<String>>(const {});

  static const _maxAge = Duration(minutes: 5);
  static DateTime? _fetchedAt;
  static Future<void>? _inFlight;

  /// Refetches unless the last fetch is still fresh. Failures (e.g. offline)
  /// keep the previous result.
  static void refresh() {
    if (_inFlight != null) return;
    final fetchedAt = _fetchedAt;
    if (fetchedAt != null && DateTime.now().difference(fetchedAt) < _maxAge) return;
    _inFlight = _fetch().whenComplete(() => _inFlight = null);
  }

  static Future<void> _fetch() async {
    try {
      final reply = await api.scraper.status(ScraperStatusRequest());
      down.value = {
        for (final status in reply.items)
          if (isDown(status)) status.hostname,
      };
      _fetchedAt = DateTime.now();
    } catch (_) {}
  }

  /// The last attempt failed and so did every attempt in the past 24 hours --
  /// a single transient failure doesn't count.
  static bool isDown(ScraperStatus status) => !status.lastAttemptSuccess && status.failures24h == status.attempts24h;

  /// Whether none of [manga]'s sources can currently be scraped.
  static bool allSourcesDown(MangaReply manga, Set<String> down) =>
      manga.sources.isNotEmpty && manga.sources.every((source) => down.contains(source.hostname));
}
