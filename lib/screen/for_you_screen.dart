import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/util/app_routes.dart';

enum _Swipe { read, nope }

/// A Tinder-style deck of manga the user isn't reading yet, ranked by rumgap's `ForYou`.
/// Swipe right (or ♥) adds a manga to the reading list, left (or ✕) hides it for a while.
class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key, required this.onOpenSearch});

  final VoidCallback onOpenSearch;

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> with AutomaticKeepAliveClientMixin<ForYouScreen> {
  static const _pageSize = 10;
  static const _refillAt = 3;

  final List<MangaReply> _deck = [];
  final List<(MangaReply, _Swipe)> _history = [];

  /// Every manga that was ever in the deck, so a refill doesn't bring back one whose swipe
  /// hasn't reached the server yet.
  final Set<int> _seen = {};

  /// The top card's swipe state, keyed by manga so the next card starts fresh.
  GlobalObjectKey<_SwipeCardState>? get _topCard => _deck.isEmpty ? null : GlobalObjectKey(_deck.first);
  bool _loading = false;
  bool _exhausted = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _refill();
  }

  Future<void> _refill() async {
    if (_loading || _exhausted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final reply = await api.manga.forYou(PaginateQuery(page: Int64(0), perPage: Int64(_pageSize)));
      final fresh = reply.items.where((manga) => _seen.add(manga.id)).toList();
      _deck.addAll(fresh);
      _exhausted = fresh.isEmpty;
    } catch (e) {
      _error = e;
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _reload() async {
    _deck.clear();
    _seen.clear();
    _history.clear();
    _exhausted = false;
    await _refill();
  }

  Future<void> _onSwiped(MangaReply manga, _Swipe swipe) async {
    setState(() {
      _deck.remove(manga);
      _history.add((manga, swipe));
    });
    if (_deck.length <= _refillAt) _refill();

    try {
      if (swipe == _Swipe.read) {
        await api.reading.create(ReadingPostRequest(mangaId: manga.id));
      } else {
        await api.manga.dismiss(DismissMangaRequest(id: manga.id));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _history.removeWhere((entry) => entry.$1.id == manga.id);
        _deck.insert(0, manga);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(FlutterI18n.translate(context, 'for_you.failed', translationParams: {'error': '$e'}))),
      );
    }
  }

  Future<void> _undo() async {
    if (_history.isEmpty) return;
    final (manga, swipe) = _history.removeLast();
    setState(() => _deck.insert(0, manga));
    try {
      if (swipe == _Swipe.read) {
        await api.reading.delete(DeleteReadingRequest(mangaId: manga.id));
      } else {
        await api.manga.undismiss(DismissMangaRequest(id: manga.id));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _deck.remove(manga);
        _history.add((manga, swipe));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(FlutterI18n.translate(context, 'for_you.failed', translationParams: {'error': '$e'}))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveContent(
      child: Column(
        children: [
          Expanded(child: _buildDeck(context)),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    if (_deck.isEmpty) {
      if (_loading) return const Center(child: CircularProgressIndicator());
      if (_error != null) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(FlutterI18n.translate(context, 'error', translationParams: {'error': '$_error'})),
              const SizedBox(height: 8),
              FilledButton(onPressed: _refill, child: I18nText('basic.retry')),
            ],
          ),
        );
      }
      return _CaughtUp(onOpenSearch: widget.onOpenSearch, onReload: _reload);
    }

    final top = _deck.first;
    final next = _deck.length > 1 ? _deck[1] : null;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          if (next != null)
            Positioned.fill(
              child: Transform.scale(
                scale: 0.95,
                child: _MangaCard(key: ValueKey('card-${next.id}'), manga: next, preview: false),
              ),
            ),
          Positioned.fill(
            child: _SwipeCard(
              key: GlobalObjectKey<_SwipeCardState>(top),
              onSwiped: (swipe) => _onSwiped(top, swipe),
              child: _MangaCard(key: ValueKey('card-${top.id}'), manga: top, preview: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final hasCard = _deck.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.filledTonal(
            iconSize: 32,
            tooltip: FlutterI18n.translate(context, 'for_you.nope'),
            onPressed: hasCard ? () => _topCard?.currentState?.swipe(_Swipe.nope) : null,
            icon: const Icon(Icons.close),
          ),
          IconButton.outlined(
            tooltip: FlutterI18n.translate(context, 'for_you.undo'),
            onPressed: _history.isNotEmpty ? _undo : null,
            icon: const Icon(Icons.undo),
          ),
          IconButton.filled(
            iconSize: 32,
            tooltip: FlutterI18n.translate(context, 'for_you.read'),
            onPressed: hasCard ? () => _topCard?.currentState?.swipe(_Swipe.read) : null,
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CaughtUp extends StatelessWidget {
  const _CaughtUp({required this.onOpenSearch, required this.onReload});

  final VoidCallback onOpenSearch;
  final Future<void> Function() onReload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, size: 64),
            const SizedBox(height: 16),
            I18nText('for_you.caught_up', child: Text('', style: Theme.of(context).textTheme.titleLarge)),
            const SizedBox(height: 8),
            I18nText('for_you.caught_up_hint', child: const Text('', textAlign: TextAlign.center)),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: onOpenSearch, icon: const Icon(Icons.search), label: I18nText('for_you.search')),
            TextButton(onPressed: onReload, child: I18nText('basic.refresh')),
          ],
        ),
      ),
    );
  }
}

/// Follows horizontal drags with a tilt and a READ / NOPE label, and flies off screen once
/// dragged far or flung fast enough. Vertical drags go to the scrollable child.
class _SwipeCard extends StatefulWidget {
  const _SwipeCard({super.key, required this.child, required this.onSwiped});

  final Widget child;
  final void Function(_Swipe swipe) onSwiped;

  @override
  State<_SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<_SwipeCard> with SingleTickerProviderStateMixin {
  static const _commitFraction = 0.35;
  static const _flingVelocity = 1000.0;
  static const _maxAngle = 15 * pi / 180;

  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  double _dx = 0;
  double _animateFrom = 0;
  double _animateTo = 0;
  _Swipe? _leaving;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _dx = _animateFrom + (_animateTo - _animateFrom) * Curves.easeOut.transform(_controller.value));
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _leaving != null) {
        widget.onSwiped(_leaving!);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _width => context.size?.width ?? MediaQuery.sizeOf(context).width;

  void _animateDx(double target) {
    _animateFrom = _dx;
    _animateTo = target;
    _controller.forward(from: 0);
  }

  void swipe(_Swipe swipe) {
    if (_leaving != null) return;
    _leaving = swipe;
    _animateDx((swipe == _Swipe.read ? 1.5 : -1.5) * _width);
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (_dx > _width * _commitFraction || velocity > _flingVelocity) {
      swipe(_Swipe.read);
    } else if (_dx < -_width * _commitFraction || velocity < -_flingVelocity) {
      swipe(_Swipe.nope);
    } else {
      _animateDx(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_dx / (_width * _commitFraction)).clamp(-1.0, 1.0);
    return GestureDetector(
      onHorizontalDragUpdate: _leaving == null ? (details) => setState(() => _dx += details.delta.dx) : null,
      onHorizontalDragEnd: _leaving == null ? _onDragEnd : null,
      child: Transform.translate(
        offset: Offset(_dx, 0),
        child: Transform.rotate(
          angle: _maxAngle * (_dx / _width).clamp(-1.0, 1.0),
          child: Stack(
            children: [
              Positioned.fill(child: widget.child),
              if (progress > 0)
                Positioned(
                  top: 24,
                  left: 24,
                  child: _Stamp(labelKey: 'for_you.read', color: Colors.green, opacity: progress, angle: -0.3),
                ),
              if (progress < 0)
                Positioned(
                  top: 24,
                  right: 24,
                  child: _Stamp(labelKey: 'for_you.nope', color: Colors.red, opacity: -progress, angle: 0.3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stamp extends StatelessWidget {
  const _Stamp({required this.labelKey, required this.color, required this.opacity, required this.angle});

  final String labelKey;
  final Color color;
  final double opacity;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              FlutterI18n.translate(context, labelKey).toUpperCase(),
              style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}

/// Cover, details and, when [preview] is set, the pages of chapter 1 below them.
class _MangaCard extends StatelessWidget {
  const _MangaCard({super.key, required this.manga, required this.preview});

  final MangaReply manga;
  final bool preview;

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: mangaRouteName(manga.id)),
        builder: (context) => MangaScreen(manga: manga, type: HeroScreenType.latest),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: manga.hasCover()
                  ? CachedNetworkImage(
                      imageUrl: manga.cover,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const ImageErrorPlaceholder(),
                    )
                  : const ImageErrorPlaceholder(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(manga.title, style: theme.textTheme.headlineSmall)),
                    IconButton(
                      tooltip: FlutterI18n.translate(context, 'for_you.open'),
                      onPressed: () => _open(context),
                      icon: const Icon(Icons.open_in_new),
                    ),
                  ],
                ),
                Text(
                  FlutterI18n.translate(context, 'manga.chapters', translationParams: {'amount': '${manga.countChapters}'}),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    if (manga.nsfw)
                      Chip(
                        label: const Text('18+'),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: theme.colorScheme.errorContainer,
                      ),
                    ...manga.genres.map((genre) => Chip(label: Text(genre), visualDensity: VisualDensity.compact)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(manga.description),
                const SizedBox(height: 16),
                if (preview) I18nText('for_you.chapter_preview', child: Text('', style: theme.textTheme.titleMedium)),
              ],
            ),
          ),
          if (preview) _ChapterPreview(manga: manga),
        ],
      ),
    );
  }
}

class _ChapterPreview extends StatefulWidget {
  const _ChapterPreview({required this.manga});

  final MangaReply manga;

  @override
  State<_ChapterPreview> createState() => _ChapterPreviewState();
}

class _ChapterPreviewState extends State<_ChapterPreview> {
  late final Future<List<ImagePage>> _pages = _load();

  Future<List<ImagePage>> _load() async {
    final chapters = await api.chapter.index(
      PaginateChapterQuery(
        mangaSourceId: widget.manga.selectedSourceId,
        paginateQuery: PaginateQuery(page: Int64(0), perPage: Int64(1)),
        reversed: true,
      ),
    );
    if (chapters.items.isEmpty) return [];
    final images = await api.chapter.images(ChapterImagesRequest(chapterId: chapters.items.first.id));
    return images.items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImagePage>>(
      future: _pages,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final pages = snapshot.data ?? [];
        if (pages.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(16.0), child: I18nText('for_you.no_preview')),
          );
        }
        return SliverList.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) => _PreviewPage(page: pages[index]),
        );
      },
    );
  }
}

class _PreviewPage extends StatelessWidget {
  const _PreviewPage({required this.page});

  final ImagePage page;

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      page.url,
      webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
      fit: BoxFit.fitWidth,
      width: double.infinity,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const SizedBox(height: 400, child: Center(child: CircularProgressIndicator())),
      errorBuilder: (context, error, stackTrace) => const SizedBox(height: 400, child: ImageErrorPlaceholder()),
    );
    if (!page.hasWidth() || !page.hasHeight() || page.width <= 0 || page.height <= 0) return image;
    return AspectRatio(aspectRatio: page.width / page.height, child: image);
  }
}
