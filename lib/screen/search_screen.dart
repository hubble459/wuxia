import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/search.pb.dart';
import 'package:wuxia/gen/user.pb.dart';
import 'package:wuxia/partial/filter_manga.dart';
import 'package:wuxia/partial/list/search_manga_item.dart';
import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  Future<SearchReply> _searchResults = Future.value(SearchReply.create());
  String _keyword = '';

  void _filter({
    String? keyword,
    List<String>? hostnames,
  }) async {
    bool refresh = false;

    if (keyword != null && keyword != _keyword) {
      _keyword = keyword;
      refresh = true;
    }
    if (hostnames != null && !eq(hostnames, API.loggedIn.preferredHostnames)) {
      // Asynchronously update user's preferred hostnames
      (() async => API.loggedIn = await api.user.update(UserUpdateRequest(
            preferredHostnames: hostnames,
          )))();
      refresh = true;
    }
    if (refresh) {
      _searchResults = api.search.manga(SearchRequest(
        keyword: _keyword,
        hostnames: hostnames ?? API.loggedIn.preferredHostnames,
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () async {
                    final filter = await Navigator.of(context).push<FilterMap>(
                      MaterialPageRoute(
                        builder: (context) => FilterManga(
                          filterType: FilterType.online,
                          defaultValue: API.loggedIn.preferredHostnames.map((e) => 'url:"$e"').join(' '),
                        ),
                      ),
                    );

                    _filter(hostnames: filter?.hosts.included);
                  },
                ),
              ],
            ),
            hintText: FlutterI18n.translate(context, 'search.search_manga_online'),
            isDense: false,
            border: const UnderlineInputBorder(),
          ),
          onSubmitted: (query) {
            if (controller.text.isNotEmpty) {
              _filter(keyword: controller.text);
            }
          },
        ),
        FutureBuilder<SearchReply>(
          future: _searchResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final results = snapshot.requireData.items;
                if (results.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: I18nText('search.no_results'),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) => SearchMangaItem(searchManga: results[index]),
                  ),
                );
              } else {
                return Center(
                  child: Text(snapshot.hasError ? snapshot.error.toString() : 'Error'),
                );
              }
            } else {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
