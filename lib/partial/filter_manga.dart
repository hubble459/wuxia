import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FilterManga extends StatefulWidget {
  const FilterManga({super.key});

  @override
  State<FilterManga> createState() => _FilterMangaState();
}

class _FilterMangaState extends State<FilterManga> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Search Filter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Tags',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: 5,
              spacing: 10,
              children: List.generate(
                20,
                (index) => InkWell(
                  onTap: () => 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                    child: Text(
                      'host $index',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Hosts',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sort By',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
