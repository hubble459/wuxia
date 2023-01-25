import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/partial/list/reading_item.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> with AutomaticKeepAliveClientMixin<ReadingScreen> {
  final _pagingController = PagingController<int, Reading>(firstPageKey: 1);
  final _searchController = TextEditingController();
  final _pageSize = 20;
  String _keyword = '';

  _filter(String keyword) {
    _keyword = keyword;
    _pagingController.refresh();
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
                    _filter(_searchController.text);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _filter('');
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    hintText: FlutterI18n.translate(context, 'search.search'),
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
                  onPressed: () {},
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
            child: PagedListView<int, Reading>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Reading>(
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: I18nText('empty'),
                ),
                itemBuilder: (context, reading, index) => ReadingItem(
                  reading: reading,
                  removedItem: (reading) {
                    _pagingController.itemList!.remove(reading);
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
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
      final paginate = await api.allReading(page: page, limit: _pageSize, keyword: _keyword);
      final isLastPage = paginate.page == paginate.numPages;
      if (isLastPage) {
        _pagingController.appendLastPage(paginate.data);
      } else {
        final nextPageKey = paginate.page + 1;
        _pagingController.appendPage(paginate.data, nextPageKey);
      }
    } catch (error) {
      log('reading', error: error);
      _pagingController.error = error;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
