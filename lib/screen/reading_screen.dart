import 'dart:developer';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/paginate.pb.dart';
import 'package:wuxia/partial/filter_manga.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/order_manga.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> with AutomaticKeepAliveClientMixin<ReadingScreen> {
  final _pagingController = PagingController<int, MangaReply>(firstPageKey: 0);
  final _searchController = TextEditingController();
  final _pageSize = 20;
  String _keyword = '';
  String _orderBy = 'title:ASC';
  bool _refresh = false;

  void _filter({
    String? keyword,
    String? orderBy,
  }) {
    if (keyword != null && keyword != _keyword) {
      _keyword = keyword;
      _refresh = true;
    }
    if (orderBy != null && orderBy != _orderBy) {
      _orderBy = orderBy;
      _refresh = true;
    }
    if (_refresh) {
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    _filter(
                      keyword: _searchController.text,
                    );
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _filter(
                          keyword: _searchController.text,
                        );
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    hintText: FlutterI18n.translate(context, 'search.search_reading'),
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () async {
                    final order = await showMaterialModalBottomSheet<String>(
                      context: context,
                      builder: (context) => OrderManga(
                        filterType: FilterType.reading,
                        defaultValue: _orderBy,
                      ),
                      animationCurve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      barrierColor: const Color(0x50696969),
                    );

                    _filter(
                      orderBy: order,
                    );
                  },
                ),
              ),
              Flexible(
                flex: 0,
                child: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FilterManga(
                          filterType: FilterType.reading,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _pagingController.refresh();
            },
            child: PagedListView<int, MangaReply>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<MangaReply>(
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: I18nText('empty'),
                ),
                itemBuilder: (context, manga, index) => MangaItem(
                  manga: manga,
                  type: HeroScreenType.reading,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int page) async {
    try {
      final result = await api.manga.index(PaginateSearchQuery(
        page: Int64(page),
        perPage: Int64(_pageSize),
        search: 'reading:>=0 $_keyword',
        order: _orderBy,
      ));
      final paginate = result.pagination;
      final isLastPage = paginate.page == paginate.maxPage;
      if (isLastPage) {
        _pagingController.appendLastPage(result.items);
      } else {
        final nextPageKey = paginate.page + 1;
        _pagingController.appendPage(result.items, nextPageKey.toInt());
      }
      if (_refresh) {
        _refresh = false;
        setState(() {});
      }
    } catch (error) {
      log('reading', error: error);
      _pagingController.error = error;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
