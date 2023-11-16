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
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';

class MangaChaptersScreen extends StatefulWidget {
  final MangaReply manga;

  const MangaChaptersScreen({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaChaptersScreen> createState() => _MangaChaptersScreenState();
}

class _MangaChaptersScreenState extends State<MangaChaptersScreen> {
  final _pageSize = 20;
  final _pagingController = PagingController<int, ChapterReply>(firstPageKey: 0);
  late ChaptersReply _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText('manga.chapters'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedListView<int, ChapterReply>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ChapterReply>(
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
                ));
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MangaChapterScreen(
                      manga: widget.manga,
                      chapter: chapter,
                    ),
                  ),
                );
                setState(() {});
              },
              chapters: () {
                _result.items.clear();
                _result.items.addAll(_pagingController.itemList!);
                return _result;
              }(),
              index: index,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int page) async {
    try {
      _result = await api.chapter.index(PaginateChapterQuery(
          id: widget.manga.id,
          paginateQuery: PaginateQuery(
            page: Int64(page),
            perPage: Int64(_pageSize),
          )));
      final paginate = _result.pagination;
      final isLastPage = paginate.page == paginate.maxPage;
      if (isLastPage) {
        _pagingController.appendLastPage(_result.items);
      } else {
        final nextPageKey = paginate.page + 1;
        _pagingController.appendPage(_result.items, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
