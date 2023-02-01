import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/meta.pb.dart';
import 'package:wuxia/util/simple_future_builder.dart';

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
  late final ResponseFuture<MetaReply> tags;
  late final ResponseFuture<MetaReply> hosts;
  final List<String> selectedTags = [];
  final List<String> excludedTags = [];
  final List<String> selectedHosts = [];
  final List<String> excludedHosts = [];

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

    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(
              'Search Filter',
              style: Theme.of(context).textTheme.titleLarge,
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
                                  if (selectedTags.contains(item)) {
                                    selectedTags.remove(item);
                                  } else if (excludedTags.contains(item)) {
                                    excludedTags.remove(item);
                                  } else {
                                    selectedTags.add(item);
                                    excludedTags.remove(item);
                                  }
                                }),
                                onLongPress: () => setState(() {
                                  if (excludedTags.contains(item)) {
                                    excludedTags.remove(item);
                                  } else {
                                    excludedTags.add(item);
                                    selectedTags.remove(item);
                                  }
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: selectedTags.contains(item)
                                        ? selectedColor
                                        : excludedTags.contains(item)
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
                      onLoadingBuilder: (context) => CircularProgressIndicator(),
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
                          if (selectedHosts.contains(item)) {
                            selectedHosts.remove(item);
                          } else if (excludedHosts.contains(item)) {
                            excludedHosts.remove(item);
                          } else {
                            selectedHosts.add(item);
                            excludedHosts.remove(item);
                          }
                        }),
                        onLongPress: () => setState(() {
                          if (excludedHosts.contains(item)) {
                            excludedHosts.remove(item);
                          } else {
                            excludedHosts.add(item);
                            selectedHosts.remove(item);
                          }
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: selectedHosts.contains(item)
                                ? selectedColor
                                : excludedHosts.contains(item)
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
              onLoadingBuilder: (context) => CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sort By',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem(
                          child: Text('data'),
                          value: 'uwu',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {},
                      value: 'ASC',
                      items: [
                        DropdownMenuItem(
                          child: Text('Ascending'),
                          value: 'ASC',
                        ),
                        DropdownMenuItem(
                          child: Text('Descending'),
                          value: 'DESC',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
