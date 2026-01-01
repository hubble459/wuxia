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
import 'package:wuxia/partial/list_error_indicator.dart';
import 'package:wuxia/partial/order_manga.dart';
import 'package:wuxia/util/filter_map.dart';
import 'package:wuxia/util/store.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> with AutomaticKeepAliveClientMixin<ReadingScreen> {
  late final _pagingController = PagingController<int, MangaReply>(
    getNextPageKey: (state) {
      if (state.status != PagingStatus.loadingFirstPage && state.pages!.last.length < _pageSize) return null;
      return state.nextIntPageKey;
    },
    fetchPage: (pageKey) => _fetchPage(pageKey),
  );
  final _searchController = TextEditingController();
  final _pageSize = 20;
  String? _orderBy;

  void _filter({
    String? keyword,
    String? orderBy,
  }) {
    bool refresh = false;
    if (keyword != null) {
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
            _filter(
              keyword: _searchController.text,
            );
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
                        filterType: FilterType.reading,
                        defaultValue: _orderBy ?? 'title:ASC',
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
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () async {
                    final keyword = await Navigator.of(context).push<FilterMap>(
                      MaterialPageRoute(
                        builder: (context) => FilterManga(
                          filterType: FilterType.reading,
                          defaultValue: _searchController.text,
                        ),
                      ),
                    );
                    if (keyword != null) {
                      _searchController.text = keyword.toString();
                      _filter(
                        keyword: _searchController.text,
                      );
                    }
                  },
                ),
              ],
            ),
            hintText: FlutterI18n.translate(context, 'search.search_reading'),
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
            child: PagingListener<int, MangaReply>(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) => PagedListView<int, MangaReply>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageErrorIndicatorBuilder: (context) => ListErrorIndicator(pagingController: _pagingController),
                  noItemsFoundIndicatorBuilder: (context) => Center(
                    child: I18nText('empty'),
                  ),
                  itemBuilder: (context, manga, index) => MangaItem(
                    key: Key(manga.id.toString()),
                    manga: manga,
                    type: HeroScreenType.reading,
                    reloadParent: (updated, deleted) {
                      if (deleted) {
                        _pagingController.items?.removeWhere((m) => m.id == updated.id);
                      } else {
                        manga.clear();
                        manga.mergeFromMessage(updated);
                      }
                      setState(() {});
                    },
                  ),
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
    _searchController.dispose();
    super.dispose();
  }

  Future<List<MangaReply>> _fetchPage(int page) async {
    _orderBy ??= Store.getStoreInstance().getReadingOrder() ?? 'title:ASC';

    final result = await api.manga.index(PaginateSearchQuery(
      page: Int64(page),
      perPage: Int64(_pageSize),
      search: 'reading:>=0 ${_searchController.text}',
      order: _orderBy,
    ));

    return result.items;
  }

  @override
  bool get wantKeepAlive => true;
}
