import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/search.pb.dart';
import 'package:wuxia/partial/list/search_manga_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  Future<SearchReply> _searchResults = Future.value(SearchReply.create());

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
            suffixIcon: const Icon(Icons.search),
            hintText: FlutterI18n.translate(context, 'search.search_manga_online'),
            isDense: false,
            border: const UnderlineInputBorder(),
          ),
          onSubmitted: (query) {
            if (controller.text.isNotEmpty) {
              setState(() {
                _searchResults = api.search.manga(SearchRequest(
                  keyword: controller.text,
                  hostnames: ['mangadex.org'],
                ));
              });
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: I18nText('search.no_results'),
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
