import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/meta.pb.dart';
import 'package:wuxia/util/simple_future_builder.dart';

class FilterOptions {
  final List<String> included;
  final List<String> excluded;

  const FilterOptions({this.included = const [], this.excluded = const []});

  String intoString(String type) {
    return '${included.map((e) => '$type:"${e.replaceAll('"', '')}"').join(' ')} ${excluded.map((e) => '-$type:"${e.replaceAll('"', '')}"').join(' ')}';
  }
}

class FilterMap {
  final FilterOptions genres = const FilterOptions();
  final FilterOptions hosts = const FilterOptions();
  String? global;
  String? title;
  String? description;

  @override
  String toString() {
    return '${genres.intoString('genre')} ${hosts.intoString('url')} title:$title description:$description $global';
  }
}

enum FilterType {
  reading,
  manga,
  online,
}

class FilterManga extends StatefulWidget {
  final FilterType filterType;

  const FilterManga({super.key, required this.filterType});

  @override
  State<FilterManga> createState() => _FilterMangaState();
}

class _FilterMangaState extends State<FilterManga> {
  final TextEditingController _globalFieldController = TextEditingController();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController = TextEditingController();

  late final ResponseFuture<MetaReply> tags;
  late final ResponseFuture<MetaReply> hosts;
  final FilterMap filterMap = FilterMap();

  @override
  void initState() {
    tags = api.meta.genres(
      MetaGenresRequest(
        option: widget.filterType == FilterType.manga ? MetaGenresOption.GenresManga : MetaGenresOption.GenresReading,
      ),
    );
    hosts = api.meta.hostnames(
      MetaHostNamesRequest(
        option: widget.filterType == FilterType.manga
            ? MetaHostNamesOption.HostNamesManga
            : widget.filterType == FilterType.reading
                ? MetaHostNamesOption.HostNamesReading
                : MetaHostNamesOption.HostNamesOnline,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primaryContainer;
    final excludeColor = Theme.of(context).colorScheme.errorContainer;
    final unselectedColor = Colors.grey.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Filter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Column(
            children: [
              TextField(
                controller: _globalFieldController,
                onChanged: (value) => filterMap.global = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  label: Text('Global Keywords'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleFieldController,
                onChanged: (value) => filterMap.title = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  label: Text('Title Keywords'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionFieldController,
                onChanged: (value) => filterMap.description = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  label: Text('Description Keywords'),
                  border: OutlineInputBorder(),
                ),
              ),
              ...(widget.filterType != FilterType.online
                  ? ([
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Genres',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SimpleFutureBuilder<MetaReply>(
                        future: tags,
                        onLoadedBuilder: (context, data) => Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          runSpacing: 5,
                          spacing: 10,
                          children: data.items
                              .map(
                                (item) => InkWell(
                                  onTap: () => setState(() {
                                    if (filterMap.genres.included.contains(item)) {
                                      filterMap.genres.included.remove(item);
                                    } else if (filterMap.genres.excluded.contains(item)) {
                                      filterMap.genres.excluded.remove(item);
                                    } else {
                                      filterMap.genres.included.add(item);
                                      filterMap.genres.excluded.remove(item);
                                    }
                                  }),
                                  onLongPress: () => setState(() {
                                    if (filterMap.genres.excluded.contains(item)) {
                                      filterMap.genres.excluded.remove(item);
                                    } else {
                                      filterMap.genres.excluded.add(item);
                                      filterMap.genres.included.remove(item);
                                    }
                                  }),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: filterMap.genres.included.contains(item)
                                          ? selectedColor
                                          : filterMap.genres.excluded.contains(item)
                                              ? excludeColor
                                              : unselectedColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Text(item),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        onLoadingBuilder: (context) => const CircularProgressIndicator(),
                      ),
                    ])
                  : []),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Hosts',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SimpleFutureBuilder<MetaReply>(
                future: hosts,
                onLoadedBuilder: (context, data) => Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  runSpacing: 5,
                  spacing: 10,
                  children: data.items
                      .map(
                        (item) => InkWell(
                          onTap: () => setState(() {
                            if (filterMap.hosts.included.contains(item)) {
                              filterMap.hosts.included.remove(item);
                            } else if (filterMap.hosts.excluded.contains(item)) {
                              filterMap.hosts.excluded.remove(item);
                            } else {
                              filterMap.hosts.included.add(item);
                              filterMap.hosts.excluded.remove(item);
                            }
                          }),
                          onLongPress: () => setState(() {
                            if (filterMap.hosts.excluded.contains(item)) {
                              filterMap.hosts.excluded.remove(item);
                            } else {
                              filterMap.hosts.included.remove(item);
                              filterMap.hosts.excluded.add(item);
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: filterMap.hosts.included.contains(item)
                                  ? selectedColor
                                  : filterMap.hosts.excluded.contains(item)
                                      ? excludeColor
                                      : unselectedColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Text(item),
                          ),
                        ),
                      )
                      .toList(),
                ),
                onLoadingBuilder: (context) => const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
