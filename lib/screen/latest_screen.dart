import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/manga.dart';
import 'package:wuxia/partial/list/manga_item.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({Key? key}) : super(key: key);

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> with AutomaticKeepAliveClientMixin<LatestScreen> {
  final _pageSize = 20;
  final _pagingController = PagingController<int, Manga>(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: PagedListView<int, Manga>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Manga>(
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: I18nText('empty'),
          ),
          itemBuilder: (context, manga, index) => MangaItem(manga: manga),
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
      final paginate = await api.allManga(page: page, limit: _pageSize);
      final isLastPage = paginate.page == paginate.numPages;
      if (isLastPage) {
        _pagingController.appendLastPage(paginate.data);
      } else {
        final nextPageKey = paginate.page + 1;
        _pagingController.appendPage(paginate.data, nextPageKey);
      }
    } catch (error) {
      log('error', error: error);
      _pagingController.error = error;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
