import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/partial/list/chapter_item.dart';
import 'package:wuxia/partial/list_error_indicator.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/util/app_routes.dart';

class MangaChaptersScreen extends StatefulWidget {
  final MangaReply manga;
  final MangaSourceReply source;

  const MangaChaptersScreen({super.key, required this.manga, required this.source});

  @override
  State<MangaChaptersScreen> createState() => _MangaChaptersScreenState();
}

class _MangaChaptersScreenState extends State<MangaChaptersScreen> {
  final _pageSize = 20;

  // rumgap's `reversed` query flag sorts server-side: false = newest chapter
  // first (its default), true = chapter 1 first. Jumping to "the other end"
  // of a possibly-5000-chapter list is a re-sort + refetch of just page 0,
  // rather than paginating through every page to physically reach it.
  var _reversed = false;

  late final _pagingController = PagingController<int, ChapterReply>(
    getNextPageKey: (state) {
      if (state.status != PagingStatus.loadingFirstPage && state.pages!.last.length < _pageSize) return null;
      // Not state.nextIntPageKey - that getter is (lastKey ?? 0) + 1, i.e. 1-indexed
      // pagination, which skips rumgap's actual first page (0-indexed) on every fetch.
      return (state.keys?.lastOrNull ?? -1) + 1;
    },
    fetchPage: (pageKey) => _fetchPage(pageKey),
  );
  late ChaptersReply _result;
  final _scrollController = ScrollController();
  var _jumping = false;

  Future<void> _jumpToEnd({required bool reversed}) async {
    if (_jumping) return;
    setState(() => _jumping = true);

    if (_reversed != reversed) {
      _reversed = reversed;
      final completer = Completer<void>();
      void listener() {
        if (!_pagingController.value.isLoading) completer.complete();
      }

      _pagingController.addListener(listener);
      _pagingController.refresh();
      await completer.future;
      _pagingController.removeListener(listener);
    }

    if (!mounted) return;
    setState(() => _jumping = false);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            I18nText('manga.chapters', translationParams: {'amount': widget.manga.countChapters.toString()}),
            Text(
              widget.source.hostname,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _jumping ? null : () => _jumpToEnd(reversed: !_reversed),
            tooltip: FlutterI18n.translate(context, _reversed ? 'chapter.goto_top' : 'chapter.goto_bottom'),
            icon: _jumping
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(_reversed ? Icons.arrow_upward : Icons.arrow_downward),
          ),
        ],
      ),
      body: ResponsiveContent(
        child: RefreshIndicator(
          onRefresh: () async {
            _pagingController.refresh();
          },
          child: PagingListener<int, ChapterReply>(
            controller: _pagingController,
            builder: (context, state, fetchNextPage) => PagedListView<int, ChapterReply>(
              scrollController: _scrollController,
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<ChapterReply>(
                firstPageErrorIndicatorBuilder: (context) => ListErrorIndicator(pagingController: _pagingController),
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: I18nText('empty'),
                ),
                itemBuilder: (context, chapter, index) => ChapterItem(
                  manga: widget.manga,
                  refreshParent: (progress) async {
                    widget.manga.readingProgress = progress;
                    await api.reading.update(ReadingPatchRequest(
                      mangaId: widget.manga.id,
                      progress: widget.manga.readingProgress,
                      chapterId: chapter.id,
                    ));
                    if (!context.mounted) return;
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: RouteSettings(name: chapterRouteNameFor(mangaId: widget.manga.id, chapter: chapter)),
                        builder: (context) => MangaChapterScreen(
                          manga: widget.manga,
                          chapter: chapter,
                          source: widget.source,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  chapters: () {
                    _result.items.clear();
                    _result.items.addAll(_pagingController.items!);
                    return _result;
                  }(),
                  index: index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addListener(_showError);
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Something went wrong while fetching a new page.',
          ),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => _pagingController.fetchNextPage(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<ChapterReply>> _fetchPage(int page) async {
    _result = await api.chapter.index(PaginateChapterQuery(
        mangaSourceId: widget.source.id,
        reversed: _reversed,
        paginateQuery: PaginateQuery(
          page: Int64(page),
          perPage: Int64(_pageSize),
        )));
    return _result.items;
  }
}
