import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/chapter.dart';
import 'package:wuxia/model/reading.dart';

class MangaChapterScreen extends StatefulWidget {
  final Reading reading;
  final Chapter chapter;

  const MangaChapterScreen({Key? key, required this.reading, required this.chapter}) : super(key: key);

  @override
  State<MangaChapterScreen> createState() => _MangaChapterScreenState();
}

class _MangaChapterScreenState extends State<MangaChapterScreen> {
  late ScrollController _scrollController;
  late Chapter _chapter;

  @override
  void initState() {
    super.initState();
    _chapter = widget.chapter;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: Tooltip(
            message: _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title,
            child: Text(_chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                while (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  await Future.delayed(const Duration(milliseconds: 10));
                }
              },
              tooltip: FlutterI18n.translate(context, 'chapter.goto_bottom'),
              icon: const Icon(Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {
                _scrollController.jumpTo(_scrollController.position.minScrollExtent);
              },
              tooltip: FlutterI18n.translate(context, 'chapter.goto_top'),
              icon: const Icon(Icons.arrow_upward),
            ),
          ],
        ),
        body: FutureBuilder<List<Uri>>(
          future: api.images(widget.reading.manga.id, _chapter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final links = snapshot.requireData;
                return InteractiveViewer(
                  // panEnabled: false,
                  // boundaryMargin: EdgeInsets.all(80),
                  minScale: 1,
                  maxScale: 4,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: links.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CachedNetworkImage(
                      imageUrl: links[index].toString(),
                      alignment: Alignment.topCenter,
                      fadeOutDuration: const Duration(microseconds: 1),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      httpHeaders: {
                        'Referer': widget.reading.manga.url.toString(),
                      },
                      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox.fromSize(
                        size: const Size.fromHeight(500),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                      ),
                      placeholder: null,
                      errorWidget: (context, url, error) => SizedBox.fromSize(
                        size: const Size.fromHeight(500),
                        child: const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                      // imageBuilder: (context, image) => Image(
                      //   image: image,
                      //   width: double.infinity,
                      //   fit: BoxFit.fitWidth,
                      // ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: I18nText('error', translationParams: {'error': snapshot.error.toString()}),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: IntrinsicHeight(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: widget.reading.progressPercentage,
              minHeight: 5,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Tooltip(
                    message: FlutterI18n.translate(context, 'chapter.previous'),
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      onPressed: widget.reading.progress > 1 ? previous : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(visible: widget.reading.progress > 1, child: Text((widget.reading.progress - 1).toString())),
                          const Icon(Icons.navigate_before)
                        ],
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //     child: _ChapterSelector(
                //         manga: widget.manga, chapter: _chapter, getChapter: _getChapter, saveProgress: _saveProgress)),
                Expanded(
                  child: Tooltip(
                    message: FlutterI18n.translate(context, 'chapter.next'),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: widget.reading.progress < widget.reading.manga.chapterCount ? next : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.navigate_next),
                          Visibility(
                              visible: widget.reading.progress < widget.reading.manga.chapterCount,
                              child: Text((widget.reading.progress + 1).toString()))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  Future<void> previous() async {
    --widget.reading.progress;
    final chapter = await api.chapter(widget.reading);
    setState(() {
      _chapter = chapter;
    });
  }

  Future<void> next() async {
    ++widget.reading.progress;
    final chapter = await api.chapter(widget.reading);
    setState(() {
      _chapter = chapter;
    });
  }
}
