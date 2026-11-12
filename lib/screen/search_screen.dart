import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/search.pb.dart';
import 'package:wuxia/partial/filter_manga.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/list/search_manga_item.dart';
import 'package:wuxia/partial/list_error_indicator.dart';
import 'package:wuxia/partial/order_manga.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/util/filter_map.dart';
import 'package:wuxia/util/store.dart';

/// Searches the library and online sources together. With an empty search it lists the
/// whole library.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.query, this.existingMangaId});

  final String? query;

  /// When set, search results are added as a new source on this manga
  /// instead of creating a disconnected duplicate. See `SearchMangaItem`.
  /// Only online results are shown then.
  final int? existingMangaId;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen> {
  late final _pagingController = PagingController<int, MangaReply>(
    getNextPageKey: (state) {
      if (state.status != PagingStatus.loadingFirstPage && state.pages!.last.length < _pageSize) return null;
      // Not state.nextIntPageKey - that getter is (lastKey ?? 0) + 1, i.e. 1-indexed
      // pagination, which skips rumgap's actual first page (0-indexed) on every fetch.
      return (state.keys?.lastOrNull ?? -1) + 1;
    },
    fetchPage: (pageKey) => _fetchPage(pageKey),
  );
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _pageSize = 20;

  /// How many library matches are shown above the online results before "show more".
  static const _collapsedLibraryCount = 5;
  bool _libraryExpanded = false;
  String _keyword = '';
  String? _orderBy;
  Future<SearchReply>? _onlineResults;

  bool get _onlineOnly => widget.existingMangaId != null;

  /// The online scrapers only take plain text, not the library's filter syntax.
  String get _onlineKeyword {
    final filter = FilterMap.fromString(_keyword);
    return [filter.global, filter.title].where((part) => part?.isNotEmpty == true).join(' ').trim();
  }

  void _search(String keyword) {
    _keyword = keyword.trim();
    _libraryExpanded = false;
    final onlineKeyword = _onlineKeyword;
    _onlineResults = onlineKeyword.isEmpty ? null : api.search.manga(SearchRequest(keyword: onlineKeyword));
    if (!_onlineOnly) {
      _pagingController.refresh();
    }
    setState(() {});
  }

  void _order(String? orderBy) {
    if (orderBy != null && orderBy != _orderBy) {
      _orderBy = orderBy;
      _pagingController.refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addListener(_showError);

    if (widget.query != null && widget.query!.isNotEmpty) {
      _searchController.text = widget.query!;
      _search(widget.query!);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveContent(
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: _search,
            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      _search('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  if (!_onlineOnly) ...[
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () async {
                        final order = await showMaterialModalBottomSheet<String>(
                          context: context,
                          builder: (context) => OrderManga(filterType: FilterType.manga, defaultValue: _orderBy ?? 'title:ASC'),
                          animationCurve: Curves.easeIn,
                          duration: const Duration(milliseconds: 500),
                          barrierColor: const Color(0x50696969),
                        );

                        _order(order);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_alt),
                      onPressed: () async {
                        final filter = await Navigator.of(context).push<FilterMap>(
                          MaterialPageRoute(
                            builder: (context) => FilterManga(filterType: FilterType.manga, defaultValue: _searchController.text),
                          ),
                        );
                        if (filter != null) {
                          _searchController.text = filter.toString();
                          _search(_searchController.text);
                        }
                      },
                    ),
                  ],
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
              onRefresh: () async => _search(_keyword),
              child: PagingListener<int, MangaReply>(
                controller: _pagingController,
                builder: (context, state, fetchNextPage) => Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(4.0),
                  thickness: 6.0,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      if (!_onlineOnly && _onlineResults != null) _sectionHeader('search.library'),
                      if (!_onlineOnly &&
                          _onlineResults != null &&
                          !_libraryExpanded &&
                          (state.items?.length ?? 0) > _collapsedLibraryCount)
                        ..._collapsedLibrary(state.items!)
                      else if (!_onlineOnly)
                        PagedSliverList<int, MangaReply>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          // Without this an empty or loading library fills the viewport and pushes the
                          // online results a full screen down.
                          shrinkWrapFirstPageIndicators: true,
                          builderDelegate: PagedChildBuilderDelegate<MangaReply>(
                            firstPageErrorIndicatorBuilder: (context) => ListErrorIndicator(pagingController: _pagingController),
                            noItemsFoundIndicatorBuilder: (context) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(child: I18nText('empty')),
                            ),
                            itemBuilder: (context, manga, index) => _mangaItem(manga),
                          ),
                        ),
                      if (_onlineResults != null) ...[
                        if (!_onlineOnly) _sectionHeader('search.online'),
                        _onlineSliver(state.items ?? const []),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mangaItem(MangaReply manga) {
    return MangaItem(
      key: Key(manga.id.toString()),
      manga: manga,
      type: HeroScreenType.latest,
      reloadParent: (updated, deleted) {
        if (deleted) {
          _pagingController.items?.removeWhere((m) => m.id == updated.id);
        } else {
          manga.clear();
          manga.mergeFromMessage(updated);
        }
        setState(() {});
      },
    );
  }

  /// The first few library matches, so the online results stay in view.
  List<Widget> _collapsedLibrary(List<MangaReply> items) {
    return [
      SliverList.builder(itemCount: _collapsedLibraryCount, itemBuilder: (context, index) => _mangaItem(items[index])),
      SliverToBoxAdapter(
        child: Center(
          child: TextButton.icon(
            onPressed: () => setState(() => _libraryExpanded = true),
            icon: const Icon(Icons.expand_more),
            label: I18nText('search.show_more'),
          ),
        ),
      ),
    ];
  }

  Widget _sectionHeader(String key) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
        child: I18nText(key, child: Text('', style: Theme.of(context).textTheme.titleMedium)),
      ),
    );
  }

  /// Online results, minus the ones already listed from the library.
  Widget _onlineSliver(List<MangaReply> libraryItems) {
    return FutureBuilder<SearchReply>(
      future: _onlineResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (!snapshot.hasData) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text(snapshot.hasError ? snapshot.error.toString() : 'Error')),
            ),
          );
        }

        final libraryIds = libraryItems.map((manga) => manga.id).toSet();
        final results = snapshot.requireData.items
            .where((result) => !result.hasMangaId() || !libraryIds.contains(result.mangaId))
            .toList();
        if (results.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: I18nText('search.no_results')),
            ),
          );
        }
        return SliverList.builder(
          itemCount: results.length,
          itemBuilder: (context, index) =>
              SearchMangaItem(searchManga: results[index], index: index, existingMangaId: widget.existingMangaId),
        );
      },
    );
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Something went wrong while fetching a new page.'),
          action: SnackBarAction(label: 'Retry', onPressed: () => _pagingController.fetchNextPage()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<MangaReply>> _fetchPage(int page) async {
    if (_onlineOnly) return [];

    final store = Store.getStoreInstance();
    _orderBy ??= store.getMangaOrder() ?? 'title:ASC';

    final result = await api.manga.index(
      PaginateSearchQuery(page: Int64(page), perPage: Int64(_pageSize), search: _keyword, order: _orderBy),
    );
    return result.items;
  }

  @override
  bool get wantKeepAlive => true;
}
