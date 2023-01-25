import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/chapter.dart';
import 'package:wuxia/model/paginate.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/partial/list/chapter_item.dart';

class MangaChaptersScreen extends StatefulWidget {
  final Reading reading;

  const MangaChaptersScreen({Key? key, required this.reading}) : super(key: key);

  @override
  State<MangaChaptersScreen> createState() => _MangaChaptersScreenState();
}

class _MangaChaptersScreenState extends State<MangaChaptersScreen> {
  final _pageSize = 20;
  final _pagingController = PagingController<int, Chapter>(firstPageKey: 1);
  late Paginate<Chapter> _paginate;

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
        child: PagedListView<int, Chapter>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Chapter>(
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: I18nText('empty'),
            ),
            itemBuilder: (context, chapter, index) => ChapterItem(
              reading: widget.reading,
              refreshParent: (progress) {
                widget.reading.progress = progress;
                api.updateProgress(widget.reading);
                setState(() {});
              },
              chapters: () {
                _paginate.data.clear();
                _paginate.data.addAll(_pagingController.itemList!);
                return _paginate;
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
      _paginate = await api.chapters(widget.reading.manga.id, page: page, limit: _pageSize);
      final isLastPage = _paginate.page == _paginate.numPages;
      if (isLastPage) {
        _pagingController.appendLastPage(_paginate.data);
      } else {
        final nextPageKey = _paginate.page + 1;
        _pagingController.appendPage(_paginate.data, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
