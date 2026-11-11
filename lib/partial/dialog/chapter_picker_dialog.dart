import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/util/tools.dart';

/// Lets the user pick one of [source]'s chapters, opened scrolled to the one
/// numbered closest to [nearNumber].
Future<ChapterReply?> showChapterPickerDialog(BuildContext context, MangaSourceReply source, {double? nearNumber}) {
  return showDialog<ChapterReply>(
    context: context,
    builder: (_) => _ChapterPickerDialog(source: source, nearNumber: nearNumber),
  );
}

class _ChapterPickerDialog extends StatefulWidget {
  final MangaSourceReply source;
  final double? nearNumber;

  const _ChapterPickerDialog({required this.source, this.nearNumber});

  @override
  State<_ChapterPickerDialog> createState() => _ChapterPickerDialogState();
}

class _ChapterPickerDialogState extends State<_ChapterPickerDialog> {
  static const _itemExtent = 56.0;
  // rumgap clamps per_page to 50.
  static const _pageSize = 50;

  late final Future<List<ChapterReply>> _chapters = _loadAll();
  String _filter = '';
  ScrollController? _scrollController;
  String? _scrollControllerFilter;

  /// One controller per filter value, so each filtered list starts at its own
  /// initial position.
  ScrollController _controllerFor(int initialIndex) {
    if (_scrollController == null || _scrollControllerFilter != _filter) {
      _scrollController?.dispose();
      _scrollControllerFilter = _filter;
      _scrollController = ScrollController(initialScrollOffset: (initialIndex - 3).clamp(0, initialIndex) * _itemExtent);
    }
    return _scrollController!;
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  Future<List<ChapterReply>> _loadAll() async {
    Future<ChaptersReply> page(int page) => api.chapter.index(
      PaginateChapterQuery(
        mangaSourceId: widget.source.id,
        reversed: true,
        paginateQuery: PaginateQuery(page: Int64(page), perPage: Int64(_pageSize)),
      ),
    );

    final first = await page(0);
    final perPage = first.pagination.perPage.toInt();
    final pages = perPage == 0 ? 1 : (first.pagination.total.toInt() / perPage).ceil();
    final rest = await Future.wait([for (var i = 1; i < pages; i++) page(i)]);
    return [...first.items, for (final reply in rest) ...reply.items];
  }

  int _closestIndex(List<ChapterReply> chapters) {
    final near = widget.nearNumber;
    if (near == null || chapters.isEmpty) return 0;
    var best = 0;
    for (var i = 1; i < chapters.length; i++) {
      if ((chapters[i].number - near).abs() < (chapters[best].number - near).abs()) best = i;
    }
    return best;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.source.hostname),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: 400,
        height: 480,
        child: FutureBuilder<List<ChapterReply>>(
          future: _chapters,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(padding: const EdgeInsets.all(16), child: Text(snapshot.error.toString())),
              );
            }
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final all = snapshot.requireData;
            final chapters = _filter.isEmpty ? all : all.where((c) => chapterFolderName(c.number).startsWith(_filter)).toList();
            final initial = _filter.isEmpty ? _closestIndex(all) : 0;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      labelText: FlutterI18n.translate(context, 'chapter.link_filter'),
                    ),
                    onChanged: (value) => setState(() => _filter = value.trim()),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(_filter),
                    controller: _controllerFor(initial),
                    itemExtent: _itemExtent,
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      return ListTile(
                        selected: _filter.isEmpty && index == initial,
                        title: Text(
                          FlutterI18n.translate(
                            context,
                            'chapter.number',
                            translationParams: {'number': chapterFolderName(chapter.number)},
                          ),
                        ),
                        subtitle: chapter.title.isEmpty
                            ? null
                            : Text(chapter.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: chapter.hasCanonicalChapterId() ? null : const Icon(Icons.link_off),
                        onTap: () => Navigator.of(context).pop(chapter),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(FlutterI18n.translate(context, 'basic.cancel'))),
      ],
    );
  }
}
