import 'dart:developer';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/partial/filter_manga.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/order_manga.dart';
import 'package:wuxia/util/store.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({Key? key}) : super(key: key);

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> with AutomaticKeepAliveClientMixin<LatestScreen> {
  final _pagingController = PagingController<int, MangaReply>(firstPageKey: 0);
  final _searchController = TextEditingController();
  final _pageSize = 20;
  String _keyword = '';
  String? _orderBy;

  void _filter({
    String? keyword,
    String? orderBy,
  }) {
    bool refresh = false;
    if (keyword != null && keyword != _keyword) {
      _keyword = keyword;
      refresh = true;
    }
    if (orderBy != null && orderBy != _orderBy) {
      _orderBy = orderBy;
      refresh = true;
    }
    if (refresh) {
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onEditingComplete: () {
            _filter(keyword: _searchController.text);
          },
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                    _filter(
                      keyword: _searchController.text,
                    );
                  },
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () async {
                    final order = await showMaterialModalBottomSheet<String>(
                      context: context,
                      builder: (context) => OrderManga(
                        filterType: FilterType.manga,
                        defaultValue: _orderBy ?? 'title:ASC',
                      ),
                      animationCurve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      barrierColor: const Color(0x50696969),
                    );

                    _filter(orderBy: order);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () async {
                    final keyword = await Navigator.of(context).push<FilterMap>(
                      MaterialPageRoute(
                        builder: (context) => FilterManga(
                          filterType: FilterType.manga,
                          defaultValue: _keyword,
                        ),
                      ),
                    );
                    if (keyword != null) {
                      _filter(
                        keyword: keyword.toString(),
                      );
                    }
                  },
                ),
              ],
            ),
            hintText: FlutterI18n.translate(context, 'search.search_manga'),
            isDense: false,
            border: const UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8.0),
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
                  key: Key(manga.id.toString()),
                  manga: manga,
                  type: HeroScreenType.latest,
                  reloadParent: (updated, deleted) {
                    manga.clear();
                    manga.mergeFromMessage(updated);
                    setState(() {});
                  },
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
    final store = Store.getStoreInstance();
    _orderBy ??= store.getMangaOrder() ?? 'title:ASC';

    try {
      final result = await api.manga.index(PaginateSearchQuery(
        page: Int64(page),
        perPage: Int64(_pageSize),
        search: _keyword,
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
    } catch (error) {
      log('latest', error: error);
      _pagingController.error = error;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
