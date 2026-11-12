import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/screen/manga/manga_chapters_screen.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/tools.dart';

class NewMangaOptions extends StatelessWidget {
  final MangaReply manga;
  final Function() refreshParent;

  const NewMangaOptions({super.key, required this.manga, required this.refreshParent});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: Theme.of(context).colorScheme.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        final m = await api.reading.create(ReadingPostRequest(mangaId: manga.id));
        manga.clear();
        manga.mergeFromMessage(m);
        refreshParent();
      },
      child: I18nText('manga.add'),
    );
  }
}

class ChapterSelector extends StatefulWidget {
  final MangaReply manga;
  final MangaSourceReply source;
  final Function() refreshParent;

  const ChapterSelector({super.key, required this.manga, required this.source, required this.refreshParent});

  @override
  State<ChapterSelector> createState() => _ChapterSelectorState();
}

class _ChapterSelectorState extends State<ChapterSelector> {
  final _scrollController = ItemScrollController();
  final _itemPositionListener = ItemPositionsListener.create();
  // rumgap clamps per_page to 50 server-side (chapter.rs).
  static const _pageSize = 50;
  // Index of the fetched window's first chapter. Derived from the reply's own
  // `pagination.page`/`perPage` -- which reflect whatever the server actually
  // clamped/used -- rather than from `_pageSize` directly, so it stays correct
  // even if the server's cap ever changes.
  var _windowStart = 0;
  var _windowLength = 0;

  // The fetched window, reused across rebuilds until the source, the window
  // the current chapter falls in, or the chapter count changes.
  Future<ChaptersReply>? _chapters;
  (int, int, int)? _chaptersKey;

  // Cached in `loadOfflineChapters`'s order (oldest first) the first time an
  // offline fallback is needed.
  List<ChapterReply>? _offlineChapters;

  Future<void> openChapters() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MangaChaptersScreen(manga: widget.manga, source: widget.source),
      ),
    );
    refresh();
  }

  Future<void> continueReading() async {
    if (widget.manga.readingProgress == 0) {
      widget.manga.readingProgress = 1;
      await syncReadingProgress(widget.manga, progress: widget.manga.readingProgress);
    }

    ChapterReply chapter;
    try {
      chapter = await api.chapter.get(ChapterRequest(mangaSourceId: widget.source.id, index: widget.manga.readingProgress));
    } catch (e) {
      _offlineChapters ??= await loadOfflineChapters(widget.manga.id, sourceId: widget.source.id);
      final found = _offlineChapters?.firstWhereOrNull((c) => c.index.toInt() == widget.manga.readingProgress);
      if (found == null) {
        if (mounted) Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'chapter.not-downloaded')).ignore();
        return;
      }
      chapter = found;
    }
    if (!mounted) return;
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            settings: RouteSettings(
              name: chapterRouteNameFor(mangaId: widget.manga.id, chapter: chapter),
            ),
            builder: (context) => MangaChapterScreen(manga: widget.manga, chapter: chapter, source: widget.source),
          ),
        )
        .then((value) => refresh());
  }

  Future<void> gotoChapter(ChapterReply chapter) async {
    widget.manga.readingProgress = chapter.index.toInt();
    await syncReadingProgress(widget.manga, progress: widget.manga.readingProgress, chapterId: chapter.id);

    if (!mounted) return;

    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            settings: RouteSettings(
              name: chapterRouteNameFor(mangaId: widget.manga.id, chapter: chapter),
            ),
            builder: (context) => MangaChapterScreen(manga: widget.manga, chapter: chapter, source: widget.source),
          ),
        )
        .then((value) => refresh());
  }

  // `readingProgress`/`chapter.index` are 1-based (see `isChapterRead`), so
  // subtract 1 before dividing to land on the page that actually contains it.
  int get _windowPage => max(((widget.manga.readingProgress - 1) / _pageSize).floor(), 0);

  /// Position of the current chapter within the fetched window.
  int get _windowLocalIndex => (widget.manga.readingProgress - 1 - _windowStart).clamp(0, max(_windowLength - 1, 0));

  Future<ChaptersReply> _chaptersFuture() {
    final key = (widget.source.id, _windowPage, widget.manga.countChapters.toInt());
    if (_chapters == null || key != _chaptersKey) {
      _chaptersKey = key;
      _chapters = getChapters();
    }
    return _chapters!;
  }

  Future<ChaptersReply> getChapters() async {
    final page = _windowPage;
    try {
      final result = await api.chapter.index(
        PaginateChapterQuery(
          mangaSourceId: widget.source.id,
          reversed: true,
          paginateQuery: PaginateQuery(page: Int64(page), perPage: Int64(_pageSize)),
        ),
      );

      if (result.items.isEmpty) {
        final offline = await _offlineWindow();
        if (offline != null) return offline;
      }

      _windowStart = result.pagination.page.toInt() * result.pagination.perPage.toInt();
      _windowLength = result.items.length;
      return result;
    } catch (e) {
      final offline = await _offlineWindow();
      if (offline == null) rethrow;
      return offline;
    }
  }

  /// The downloaded chapter list, for when the server can't be reached or
  /// has no chapters for this source (e.g. its scraper is failing). `null`
  /// if nothing is downloaded.
  Future<ChaptersReply?> _offlineWindow() async {
    _offlineChapters ??= await loadOfflineChapters(widget.manga.id, sourceId: widget.source.id);
    final offline = _offlineChapters;
    if (offline == null || offline.isEmpty) return null;
    _windowStart = 0;
    _windowLength = offline.length;
    return ChaptersReply(items: offline);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Chapter button
        IconButton(onPressed: widget.manga.countChapters == 0 ? null : openChapters, icon: Icon(Icons.list_alt)),

        ...(widget.manga.countChapters == 0
            ? [Text(FlutterI18n.translate(context, 'manga.no-chapters'), style: TextStyle(color: Colors.red))]
            : [
                // Chapters -- the two arrows are pinned outside the scrollable
                // list (not items within it), so they stay put at the row's
                // edges instead of scrolling out of view along with the
                // chapter buttons once there are enough of them to overflow.
                MaterialButton(onPressed: openChapters, minWidth: 0, child: const Icon(Icons.arrow_left)),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: SimpleFutureBuilder(
                        future: _chaptersFuture(),
                        onLoadedBuilder: (context, ChaptersReply chapters) {
                          return ScrollablePositionedList.builder(
                            initialScrollIndex: _windowLocalIndex,
                            itemScrollController: _scrollController,
                            itemPositionsListener: _itemPositionListener,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: chapters.items.length,
                            itemBuilder: (context, index) {
                              final chapter = chapters.items[index];
                              return MaterialButton(
                                color: isChapterRead(widget.manga, chapter) ? Colors.grey.withValues(alpha: 0.2) : null,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                onPressed: () => gotoChapter(chapter),
                                child: Text(chapter.number.toStringAsFixed(1).replaceAll('.0', '')),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                MaterialButton(onPressed: openChapters, minWidth: 0, child: const Icon(Icons.arrow_right)),
                // Continue
                MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 50,
                  color: Theme.of(context).colorScheme.secondary,
                  splashColor: Theme.of(context).primaryColorLight,
                  minWidth: 0,
                  onPressed: continueReading,
                  child: I18nText('manga.continue'),
                ),
              ]),
      ],
    );
  }

  void refresh() {
    setState(() {});
    widget.refreshParent();
    // Progress may have moved within the same window (no refetch), so bring
    // the now-current chapter into view.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.isAttached) _scrollController.jumpTo(index: _windowLocalIndex);
    });
  }
}
