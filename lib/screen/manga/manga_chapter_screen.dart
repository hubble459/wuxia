import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:protobuf/protobuf.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/chapter.pb.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/reading.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/util/tools.dart';

class MangaChapterScreen extends StatefulWidget {
  final MangaReply manga;
  final ChapterReply chapter;

  const MangaChapterScreen({Key? key, required this.manga, required this.chapter}) : super(key: key);

  @override
  State<MangaChapterScreen> createState() => _MangaChapterScreenState();
}

class _MangaChapterScreenState extends State<MangaChapterScreen> {
  final ScrollController scrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late ChapterReply _chapter;

  @override
  void initState() {
    _chapter = widget.chapter;

    WidgetsBinding.instance.addPostFrameCallback((a) => offsetUpdater());

    super.initState();
  }

  void offsetUpdater() {
    var lastChapter = _chapter.deepCopy();
    var lastOffset = lastChapter.offset.deepCopy();

    Timer? debounced;

    itemPositionsListener.itemPositions.addListener(() async {
      if (lastChapter.id != _chapter.id) {
        debounced?.cancel();

        // Chapter changed, update offset nonetheless
        await updateOffset(
          chapterId: lastChapter.id,
          page: lastOffset.page,
          pixels: lastOffset.pixels,
        );

        // Update watched chapter
        lastChapter = _chapter.deepCopy();
      } else {
        // Get the first visible item
        final lastItem = itemPositionsListener.itemPositions.value.lastOrNull;
        // If not null
        if (lastItem != null) {
          // Get the "page"
          int page = lastItem.index;
          // The amount of pixels scrolled in the page
          final pixels = (lastItem.itemLeadingEdge * 100).floor();
          // If different than what is saved
          if ((pixels != 0 || page != 0) && (page != lastOffset.page || pixels != lastOffset.pixels)) {
            // Set the last to this
            lastOffset = ChapterOffset(
              page: page,
              pixels: pixels,
            );
            // Cancel any other update
            debounced?.cancel();
            // Send API an update if not scrolled for half a second
            debounced = Timer(Duration(milliseconds: 2000), () {
              updateOffset(
                chapterId: lastChapter.id,
                page: lastOffset.page,
                pixels: lastOffset.pixels,
              );
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  Future<void> updateOffset({required int chapterId, required int page, required int pixels}) async {
    await api.reading.updateChapterOffset(UpdateChapterOffsetRequest(
      chapterId: chapterId,
      page: page,
      pixels: pixels,
    ));
    Fluttertoast.showToast(msg: 'Updating $chapterId: page = $page, pixels = $pixels');
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
                itemScrollController.jumpTo(index: 10000);
              },
              tooltip: FlutterI18n.translate(context, 'chapter.goto_bottom'),
              icon: const Icon(Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {
                itemScrollController.jumpTo(index: 0);
              },
              tooltip: FlutterI18n.translate(context, 'chapter.goto_top'),
              icon: const Icon(Icons.arrow_upward),
            ),
            OpenURLAction(url: _chapter.url),
          ],
        ),
        body: SimpleFutureBuilder<ImagesReply>(
          future: api.chapter.images(Id(id: _chapter.id)),
          onLoadedBuilder: (context, data) {
            final links = data.items;

            (() async {
              if (_chapter.hasOffset() && (_chapter.offset.page != 0 || _chapter.offset.pixels != 0)) {
                int timeout = 0;
                while (!itemScrollController.isAttached && timeout++ != 5) {
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                if (itemScrollController.isAttached) {
                  itemScrollController.scrollTo(
                    index: _chapter.offset.page,
                    alignment: _chapter.offset.pixels / 100,
                    duration: Duration(seconds: 3),
                    opacityAnimationWeights: [20, 20, 60],
                    curve: Curves.easeOut,
                  );
                }
              }
            })();

            return InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Scrollbar(
                controller: scrollController,
                radius: const Radius.circular(4.0),
                thickness: 6.0,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
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
                      'Referer': getReferer(_chapter, links[index]),
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
