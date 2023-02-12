import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/chapter.pb.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/reading.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/action/open_url_action.dart';

class MangaChapterScreen extends StatefulWidget {
  final MangaReply manga;
  final ChapterReply chapter;

  const MangaChapterScreen({Key? key, required this.manga, required this.chapter}) : super(key: key);

  @override
  State<MangaChapterScreen> createState() => _MangaChapterScreenState();
}

class _MangaChapterScreenState extends State<MangaChapterScreen> {
  final ScrollController _scrollController = ScrollController();
  late ChapterReply _chapter;

  @override
  void initState() {
    _chapter = widget.chapter;

    int last = 0;
    int saved = 0;
    Timer? timer;
    _scrollController.addListener(() {
      if (saved == 0) {
        saved = _chapter.id;
      }

      final offset = _scrollController.offset.floor();
      if (offset != last && saved == _chapter.id) {
        timer?.cancel();
        final chapterId = _chapter.id.floor();
        timer = Timer(const Duration(seconds: 2), () {
          last = offset;
          saved = 0;
          _chapter.offset = offset;
          api.reading.updateChapterOffset(UpdateChapterOffsetRequest(
            chapterId: chapterId,
            offset: offset,
          ));
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title,
                child: Text(
                    _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title),
              ),
              ...(_chapter.hasPosted()
                  ? [
                      Text(
                        Jiffy.unixFromMillisecondsSinceEpoch(_chapter.posted.toInt()).fromNow(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                        overflow: TextOverflow.ellipsis,
                      )
                    ]
                  : []),
            ],
          ),
          centerTitle: false,
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
            OpenURLAction(url: _chapter.url),
          ],
        ),
        body: FutureBuilder<ImagesReply>(
          future: api.chapter.images(Id(id: _chapter.id)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final links = snapshot.requireData.items;
                final host = (links.isNotEmpty ? Uri.tryParse(links.first)?.host : null) ?? '';

                if (_chapter.offset != 0) {
                  (() async {
                    int timeout = 0;
                    while (_scrollController.positions.isEmpty && timeout++ != 5) {
                      await Future.delayed(const Duration(milliseconds: 100));
                    }
                    if (_scrollController.positions.isNotEmpty) {
                      _scrollController.jumpTo(_chapter.offset.toDouble());
                    }
                  })();
                }

                return Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(4.0),
                  thickness: 6.0,
                  child: InteractiveViewer(
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
                        imageUrl: links[index],
                        alignment: Alignment.topCenter,
                        fadeOutDuration: const Duration(microseconds: 1),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        httpHeaders: {
                          'Referer': links[index],
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
                      ),
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
              value: widget.manga.progressPercentage,
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
                      onPressed: widget.manga.readingProgress > 1 ? previous : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                              visible: widget.manga.readingProgress > 1,
                              child: Text((widget.manga.readingProgress - 1).toString())),
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
                      onPressed: widget.manga.readingProgress < widget.manga.countChapters.toInt() ? next : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.navigate_next),
                          Visibility(
                              visible: widget.manga.readingProgress < widget.manga.countChapters.toInt(),
                              child: Text((widget.manga.readingProgress + 1).toString()))
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
    --widget.manga.readingProgress;
    await reloadChapter();
  }

  Future<void> next() async {
    ++widget.manga.readingProgress;
    await reloadChapter();
  }

  Future<void> reloadChapter() async {
    await api.reading.update(
      ReadingPatchRequest(
        mangaId: widget.manga.id,
        progress: widget.manga.readingProgress,
      ),
    );
    final chapter = await api.chapter.get(
      ChapterRequest(
        mangaId: widget.manga.id,
        index: widget.manga.readingProgress,
      ),
    );
    setState(() {
      _chapter = chapter;
    });
  }
}
