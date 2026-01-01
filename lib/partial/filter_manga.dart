import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/meta.pb.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/util/filter_map.dart';

enum FilterType {
  reading,
  manga,
  online,
}

class FilterManga extends StatefulWidget {
  final FilterType filterType;
  final String defaultValue;

  const FilterManga({super.key, required this.filterType, required this.defaultValue});

  @override
  State<FilterManga> createState() => _FilterMangaState();
}

class _FilterMangaState extends State<FilterManga> {
  final TextEditingController _globalFieldController = TextEditingController();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController = TextEditingController();

  late final ResponseFuture<MetaReply> tags;
  late final ResponseFuture<MetaReply> hosts;
  late final FilterMap filterMap;

  @override
  void initState() {
    filterMap = FilterMap.fromString(widget.defaultValue);

    tags = api.meta.genres(
      MetaGenresRequest(
        option: widget.filterType == FilterType.manga ? MetaGenresOption.GenresManga : MetaGenresOption.GenresReading,
      ),
    );
    hosts = api.meta.hostnames(
      MetaHostnamesRequest(
        option: widget.filterType == FilterType.manga
            ? MetaHostnamesOption.HostnamesManga
            : widget.filterType == FilterType.reading
                ? MetaHostnamesOption.HostnamesReading
                : MetaHostnamesOption.HostnamesOnline,
      ),
    );
    _globalFieldController.text = filterMap.global ?? '';
    _titleFieldController.text = filterMap.title ?? '';
    _descriptionFieldController.text = filterMap.description ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primaryContainer;
    final excludeColor = Theme.of(context).colorScheme.errorContainer;
    final unselectedColor = Colors.grey.shade900;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(filterMap);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Filter'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Center(
              child: Column(
                children: [
                  ...(widget.filterType != FilterType.online
                      ? ([
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
                                        filterMap.genres.excluded.remove(item);
                                        if (!filterMap.genres.included.remove(item)) {
                                          filterMap.genres.included.add(item);
                                        }
                                      }),
                                      onLongPress: () => setState(() {
                                        filterMap.genres.included.remove(item);
                                        if (!filterMap.genres.excluded.remove(item)) {
                                          filterMap.genres.excluded.add(item);
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
        ),
      ),
    );
  }
}
