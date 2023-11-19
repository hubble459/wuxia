import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/meta.pb.dart';
import 'package:wuxia/partial/simple_future_builder.dart';

final tagRegex = RegExp(r'\w+');

class FilterOptions {
  final List<String> included;
  final List<String> excluded;

  FilterOptions({List<String>? included, List<String>? excluded})
      : included = included ?? [],
        excluded = included ?? [];

  String intoString(String type) {
    return '${included.map((e) => '$type:"${e.replaceAll('"', '')}"').join(' ')} ${excluded.map((e) => '-$type:"${e.replaceAll('"', '')}"').join(' ')}';
  }
}

class _Field {
  final bool exclude;
  final bool exact;
  final String value;
  final String? name;

  const _Field({
    required this.name,
    required this.value,
    required this.exact,
    required this.exclude,
  });

  @override
  String toString() {
    String self = exclude ? '-' : '';
    if (name != null) {
      self += '${name!}:';
    }
    self += '"$value"';
    return self;
  }
}

class FilterMap {
  final FilterOptions genres = FilterOptions();
  final FilterOptions hosts = FilterOptions();
  String? global;
  String? title;
  String? description;

  @override
  String toString() {
    String sb = '';
    sb += genres.intoString('genre');
    sb += hosts.intoString('url');

    if (title?.isNotEmpty == true) {
      sb += 'title:$title';
    }
    if (description?.isNotEmpty == true) {
      sb += 'description:$description';
    }
    if (global?.isNotEmpty == true) {
      sb += global!;
    }
    sb = sb.trim();
    return sb;
  }

  FilterMap();

  factory FilterMap.fromString(String defaultValue) {
    final map = FilterMap();

    bool inside = false;

    String? name;
    String value = '';
    bool exclude = false;
    bool exact = false;

    List<_Field> fields = [];

    for (final char in defaultValue.characters) {
      if (char == ' ') {
        if (!inside) {
          fields.add(_Field(
            exclude: exclude,
            name: name,
            value: value,
            exact: exact,
          ));

          name = null;
          value = '';
          exclude = false;
          exact = false;
        } else {
          value += ' ';
        }
      } else if (char == ':') {
        if (!inside) {
          name = value;
          value = '';
        }
      } else if (char == '-') {
        if (!inside && value.isEmpty) {
          exclude = true;
        } else {
          value += '-';
        }
      } else if (char == '"') {
        inside = !inside;
        if (inside) {
          exact = true;
        }
      } else {
        value += char;
      }
    }

    if (value.isNotEmpty) {
      fields.add(_Field(
        exclude: exclude,
        name: name,
        value: value,
        exact: exact,
      ));
    }

    for (final field in fields) {
      if (field.name == null) {
        map.global = '${map.global ?? ''} $field';
      } else if (field.name?.toLowerCase() == 'title') {
        map.title = '${map.title ?? ''} $field';
      } else if (field.name?.toLowerCase().startsWith('desc') == true) {
        map.description = '${map.description ?? ''} $field';
      } else if (field.name?.toLowerCase().startsWith('genre') == true) {
        if (field.exclude) {
          map.genres.excluded.add(field.value);
        } else {
          map.genres.included.add(field.value);
        }
      } else if (field.name?.toLowerCase().startsWith('url') == true) {
        if (field.exclude) {
          map.hosts.excluded.add(field.value);
        } else {
          map.hosts.included.add(field.value);
        }
      }
    }

    return map;
  }
}

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primaryContainer;
    final excludeColor = Theme.of(context).colorScheme.errorContainer;
    final unselectedColor = Colors.grey.shade900;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
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
        ),
      ),
    );
  }
}
