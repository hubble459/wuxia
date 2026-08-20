import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/dialog/source_picker_dialog.dart';
import 'package:wuxia/util/tools.dart';

class MangaChapterScreen extends StatefulWidget {
  final MangaReply manga;
  final ChapterReply chapter;
  final MangaSourceReply source;

  /// 0.0-1.0 target scroll position, used instead of `chapter.offset`'s raw
  /// page/pixels when landing here from a cross-source switch (B5) -- the new
  /// chapter almost certainly has a different page count.
  final double? initialFraction;

  const MangaChapterScreen({
    super.key,
    required this.manga,
    required this.chapter,
    required this.source,
    this.initialFraction,
  });

  @override
  State<MangaChapterScreen> createState() => _MangaChapterScreenState();
}

class _ReaderPage {
  final String url;
  final int? width;
  final int? height;

  const _ReaderPage(this.url, {this.width, this.height});
}

class _MangaChapterScreenState extends State<MangaChapterScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late ChapterReply _chapter;
  List<_ReaderPage>? _images;
  bool _isOffline = false;

  @override
  void initState() {
    _chapter = widget.chapter;
    _loadImages();
    WidgetsBinding.instance.addPostFrameCallback((a) => offsetUpdater());
    super.initState();
  }

  Future<List<String>?> _localImagePaths() async {
    final dir = await getDownloadDirectory();
    final safeName = widget.manga.title.replaceAll(RegExp(r'[^\w\s\-]'), '_');
    final chapterNum = _chapter.number.toStringAsFixed(1).replaceAll('.0', '');
    final chapterDir = Directory('${dir.path}/$safeName/$chapterNum');

    if (!await chapterDir.exists()) return null;

    final files = (await chapterDir.list().toList()).whereType<File>().toList();
    if (files.isEmpty) return null;

    files.sort((a, b) {
      final aNum = int.tryParse(a.uri.pathSegments.last.split('.').first) ?? 0;
      final bNum = int.tryParse(b.uri.pathSegments.last.split('.').first) ?? 0;
      return aNum.compareTo(bNum);
    });

    return files.map((f) => f.path).toList();
  }

  Future<void> _loadImages() async {
    setState(() => _images = null);

    final local = await _localImagePaths();
    if (local != null) {
      setState(() {
        // No stored dimensions for offline-downloaded pages -- reader falls
        // back to the fixed-height placeholder for these, same as before.
        _images = local.map((path) => _ReaderPage(path)).toList();
        _isOffline = true;
      });
      return;
    }

    final reply = await api.chapter.images(Id(id: _chapter.id));
    setState(() {
      _images = reply.items
          .map((page) => _ReaderPage(
                page.url,
                width: page.hasWidth() ? page.width : null,
                height: page.hasHeight() ? page.height : null,
              ))
          .toList();
      _isOffline = false;
    });
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
            // Send API an update if not scrolled for 5 seconds
            debounced = Timer(Duration(milliseconds: 5000), () {
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
    super.dispose();
  }

  Future<void> updateOffset({required int chapterId, required int page, required int pixels}) async {
    await api.reading.updateChapterOffset(UpdateChapterOffsetRequest(
      chapterId: chapterId,
      page: page,
      pixels: pixels,
      fraction: pixels / 100.0,
    ));
  }

  Future<void> _switchSource() async {
    final selected = await showSourcePickerDialog(context, widget.manga.sources.toList());
    if (selected == null || !mounted) return;

    try {
      final newChapter = await api.chapter.findEquivalent(FindEquivalentRequest(
        canonicalChapterId: _chapter.canonicalChapterId,
        mangaSourceId: selected.id,
      ));

      double fraction = 0.0;
      try {
        final crossOffset =
            await api.reading.getCrossSourceOffset(GetCrossSourceOffsetRequest(canonicalChapterId: _chapter.canonicalChapterId));
        fraction = crossOffset.fraction;
      } catch (_) {
        // No recorded cross-source position (e.g. first time reading this chapter
        // on any source) -- just land at the top instead of failing the switch.
      }

      widget.manga.readingProgress = newChapter.index.toInt();
      await api.reading.update(ReadingPatchRequest(
        mangaId: widget.manga.id,
        progress: widget.manga.readingProgress,
        chapterId: newChapter.id,
      ));

      // Mutate the shared source object in place so the change is reflected
      // back up in whichever screen (MangaScreen, MangaChaptersScreen, ...)
      // is holding the same reference once we pop back to it.
      widget.source.clear();
      widget.source.mergeFromMessage(selected);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MangaChapterScreen(
            manga: widget.manga,
            chapter: newChapter,
            source: widget.source,
            initialFraction: fraction,
          ),
        ),
      );
    } catch (e) {
      if (e is GrpcError && e.code == StatusCode.notFound) {
        Fluttertoast.showToast(msg: 'This source doesn\'t have this chapter').ignore();
        // Switch the active source anyway; next navigation from this source
        // will fall back to wherever its own reading progress implies.
        widget.source.clear();
        widget.source.mergeFromMessage(selected);
        setState(() {});
      } else {
        Fluttertoast.showToast(msg: e.toString()).ignore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          updateOffset(
            chapterId: _chapter.id,
            page: _chapter.offset.page,
            pixels: _chapter.offset.pixels,
          );
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title,
                child: Text(_chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title),
              ),
              Text(
                _chapter.hasPosted()
                    ? '${widget.source.hostname} · ${Jiffy.parseFromMillisecondsSinceEpoch(_chapter.posted.toInt()).fromNow()}'
                    : widget.source.hostname,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            if (_isOffline)
              const Tooltip(
                message: 'Offline',
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.wifi_off),
                ),
              ),
            IconButton(
              onPressed: widget.manga.sources.length > 1 ? _switchSource : null,
              tooltip: FlutterI18n.translate(context, 'manga.switch_source'),
              icon: const Icon(Icons.swap_horiz),
            ),
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
        body: _images == null ? const Center(child: CircularProgressIndicator()) : _buildImageList(_images!),
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
                                visible: widget.manga.readingProgress > 1, child: Text((widget.manga.readingProgress - 1).toString())),
                            const Icon(Icons.navigate_before)
                          ],
                        ),
                      ),
                    ),
                  ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildImageList(List<_ReaderPage> links) {
    (() async {
      final initialFraction = widget.initialFraction;
      final hasSavedOffset = _chapter.hasOffset() && (_chapter.offset.page != 0 || _chapter.offset.pixels != 0);
      if (links.isEmpty || (initialFraction == null && !hasSavedOffset)) return;

      int timeout = 0;
      while (!itemScrollController.isAttached && timeout++ != 5) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      if (!itemScrollController.isAttached) return;

      if (initialFraction != null) {
        final index = (initialFraction * links.length).round().clamp(0, links.length - 1);
        itemScrollController.scrollTo(
          index: index,
          alignment: 0,
          duration: Duration(seconds: 3),
          opacityAnimationWeights: [20, 20, 60],
          curve: Curves.easeOut,
        );
      } else {
        itemScrollController.scrollTo(
          index: _chapter.offset.page,
          alignment: _chapter.offset.pixels / 100,
          duration: Duration(seconds: 3),
          opacityAnimationWeights: [20, 20, 60],
          curve: Curves.easeOut,
        );
      }
    })();

    return InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        padding: EdgeInsets.zero,
        itemCount: links.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => _buildPage(links[index]),
      ),
    );
  }

  Widget _buildPage(_ReaderPage page) {
    final Widget image = _isOffline
        ? Image.file(
            File(page.url),
            alignment: Alignment.topCenter,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          )
        : CachedNetworkImage(
            imageUrl: page.url,
            alignment: Alignment.topCenter,
            fadeOutDuration: const Duration(microseconds: 1),
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox.fromSize(
              size: const Size.fromHeight(500),
              child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            ),
            placeholder: null,
            errorWidget: (context, url, error) => SizedBox.fromSize(
              size: const Size.fromHeight(500),
              child: const Center(child: Icon(Icons.error)),
            ),
          );

    // Known dimensions let the list item reserve the correct height up
    // front (matching what BoxFit.fitWidth will render at), so swapping the
    // loading placeholder for the real image never relayouts the list.
    if (page.width == null || page.height == null || page.width! <= 0 || page.height! <= 0) {
      return image;
    }
    return AspectRatio(aspectRatio: page.width! / page.height!, child: image);
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
    final chapter = await api.chapter.get(
      ChapterRequest(
        mangaSourceId: widget.source.id,
        index: widget.manga.readingProgress,
      ),
    );
    await api.reading.update(
      ReadingPatchRequest(
        mangaId: widget.manga.id,
        progress: widget.manga.readingProgress,
        chapterId: chapter.id,
      ),
    );
    setState(() => _chapter = chapter);
    _loadImages();
  }
}
