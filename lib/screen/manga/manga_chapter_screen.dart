import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/dialog/source_picker_dialog.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/store.dart';
import 'package:wuxia/util/tools.dart';

class MangaChapterScreen extends StatefulWidget {
  final MangaReply manga;
  final ChapterReply chapter;
  final MangaSourceReply source;

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

String _pageUrl(String url, {required bool dataSaver}) {
  if (dataSaver) return '$url?maxdim=1280&quality=70';
  return url;
}

class _MangaChapterScreenState extends State<MangaChapterScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final PageController _pageController = PageController();
  final FocusNode _focusNode = FocusNode();
  late ChapterReply _chapter;
  List<_ReaderPage>? _images;
  bool _isOffline = false;
  List<String>? _offlineSources;
  late bool _isPagedMode;
  late int _currentPage;

  Timer? _offsetDebounce;
  late int _lastOffsetPage;
  late int _lastOffsetPixels;

  @override
  void initState() {
    _chapter = widget.chapter;
    _lastOffsetPage = _chapter.offset.page;
    _lastOffsetPixels = _chapter.offset.pixels;
    _currentPage = _lastOffsetPage;

    final store = Store.getStoreInstance();
    _isPagedMode = (store.getMangaReadingMode(widget.manga.id) ?? store.getReadingMode()) == 'paged';

    _loadImages();
    WidgetsBinding.instance.addPostFrameCallback((a) => offsetUpdater());
    _focusNode.addListener(_reclaimFocus);
    super.initState();
  }

  void _reclaimFocus() {
    if (_focusNode.hasFocus || !mounted) return;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_focusNode.hasFocus) _focusNode.requestFocus();
    });
  }

  Future<List<String>?> _localPageSources() async {
    if (!downloadsSupported) return null;
    try {
      return await downloadStorage
          .loadPageSources('${mangaFolderName(widget.manga.title)}/${chapterFolderName(_chapter.number)}');
    } catch (_) {
      return null;
    }
  }

  void _releaseOfflineSources() {
    final sources = _offlineSources;
    if (sources != null) downloadStorage.releasePageSources(sources);
    _offlineSources = null;
  }

  Future<void> _loadImages() async {
    setState(() => _images = null);

    _releaseOfflineSources();
    final local = await _localPageSources();
    if (local != null) {
      if (!mounted) {
        downloadStorage.releasePageSources(local);
        return;
      }
      _offlineSources = local;
      setState(() {
        _images = local.map((source) => _ReaderPage(source)).toList();
        _isOffline = true;
      });
      return;
    }

    final reply = await api.chapter.images(ChapterImagesRequest(chapterId: _chapter.id));
    final dataSaver = Store.getStoreInstance().getDataSaver() ?? false;
    setState(() {
      _images = reply.items
          .map((page) => _ReaderPage(
                _pageUrl(page.url, dataSaver: dataSaver),
                width: page.hasWidth() ? page.width : null,
                height: page.hasHeight() ? page.height : null,
              ))
          .toList();
      _isOffline = false;
    });
  }

  void offsetUpdater() {
    itemPositionsListener.itemPositions.addListener(() {
      if (_isPagedMode) return;

      final lastItem = itemPositionsListener.itemPositions.value.lastOrNull;
      if (lastItem == null) return;

      final page = lastItem.index;
      final pixels = (lastItem.itemLeadingEdge * 100).floor();
      _recordOffset(page, pixels);
    });
  }

  void _recordOffset(int page, int pixels) {
    if (page == _lastOffsetPage && pixels == _lastOffsetPixels) return;
    _lastOffsetPage = page;
    _lastOffsetPixels = pixels;
    _offsetDebounce?.cancel();
    final chapterId = _chapter.id;
    _offsetDebounce = Timer(const Duration(milliseconds: 5000), () {
      updateOffset(chapterId: chapterId, page: page, pixels: pixels);
    });
  }

  @override
  void dispose() {
    _offsetDebounce?.cancel();
    _pageController.dispose();
    _focusNode.removeListener(_reclaimFocus);
    _focusNode.dispose();
    PaintingBinding.instance.imageCache.clearLiveImages();
    _releaseOfflineSources();
    super.dispose();
  }

  Future<void> updateOffset({required int chapterId, required int page, required int pixels}) async {
    try {
      await api.reading.updateChapterOffset(UpdateChapterOffsetRequest(
        chapterId: chapterId,
        page: page,
        pixels: pixels,
        fraction: pixels / 100.0,
      ));
    } catch (_) {}
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
      } catch (_) {}

      widget.manga.readingProgress = newChapter.index.toInt();
      try {
        await api.reading.update(ReadingPatchRequest(
          mangaId: widget.manga.id,
          progress: widget.manga.readingProgress,
          chapterId: newChapter.id,
        ));
      } on GrpcError catch (e) {
        // TODO: build a UI for LinkChapter/UnlinkChapter so this is fixable
        // in-app instead of just silently swallowed.
        if (e.code != StatusCode.failedPrecondition) rethrow;
      }

      widget.source.clear();
      widget.source.mergeFromMessage(selected);

      await _goToChapter(newChapter, initialFraction: fraction);
    } catch (e) {
      if (e is GrpcError && e.code == StatusCode.notFound) {
        Fluttertoast.showToast(msg: 'This source doesn\'t have this chapter').ignore();
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
          _offsetDebounce?.cancel();
          updateOffset(
            chapterId: _chapter.id,
            page: _lastOffsetPage,
            pixels: _lastOffsetPixels,
          );
          Navigator.of(context).pop(result);
        }
      },
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Listener(
          onPointerDown: (_) => _focusNode.requestFocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message:
                        _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title,
                    child: Text(
                        _chapter.title.isEmpty ? 'Chapter ${_chapter.number.toString().replaceFirst('.0', '')}' : _chapter.title),
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
                if (_isPagedMode && _images != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${_currentPage + 1} / ${_images!.length}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                      ),
                    ),
                  ),
                if (_isOffline)
                  const Tooltip(
                    message: 'Offline',
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.wifi_off),
                    ),
                  ),
                PopupMenuButton<String>(
                  tooltip: FlutterI18n.translate(context, 'chapter.more_options'),
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    switch (value) {
                      case 'switch_source':
                        _switchSource();
                        break;
                      case 'toggle_mode':
                        setState(() => _isPagedMode = !_isPagedMode);
                        Store.getStoreInstance().setMangaReadingMode(widget.manga.id, _isPagedMode ? 'paged' : 'webtoon');
                        break;
                      case 'goto_top':
                        if (_isPagedMode) {
                          if (_pageController.hasClients) {
                            _pageController.jumpToPage(0);
                          }
                        } else {
                          itemScrollController.jumpTo(index: 0);
                        }
                        break;
                      case 'goto_bottom':
                        if (_isPagedMode) {
                          if (_pageController.hasClients) {
                            _pageController.jumpToPage((_images?.length ?? 1) - 1);
                          }
                        } else {
                          itemScrollController.jumpTo(index: (_images?.length ?? 1) - 1);
                        }
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'switch_source',
                      enabled: widget.manga.sources.length > 1,
                      child: ListTile(
                        leading: const Icon(Icons.swap_horiz),
                        title: Text(FlutterI18n.translate(context, 'manga.switch_source')),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'toggle_mode',
                      child: ListTile(
                        leading: Icon(_isPagedMode ? Icons.menu_book : Icons.view_day),
                        title: Text(FlutterI18n.translate(context, _isPagedMode ? 'chapter.mode_paged' : 'chapter.mode_webtoon')),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'goto_top',
                      child: ListTile(
                        leading: const Icon(Icons.arrow_upward),
                        title: Text(FlutterI18n.translate(context, _isPagedMode ? 'chapter.goto_first_page' : 'chapter.goto_top')),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'goto_bottom',
                      child: ListTile(
                        leading: const Icon(Icons.arrow_downward),
                        title: Text(FlutterI18n.translate(context, _isPagedMode ? 'chapter.goto_last_page' : 'chapter.goto_bottom')),
                      ),
                    ),
                  ],
                ),
                OpenURLAction(url: _chapter.url),
              ],
            ),
            body: _images == null
                ? const Center(child: CircularProgressIndicator())
                : (_isPagedMode ? _buildPagedView(_images!) : _buildImageList(_images!)),
            bottomNavigationBar: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: widget.manga.progressPercentage,
                    minHeight: 5,
                    color: Theme.of(context).colorScheme.tertiary,
                    backgroundColor: Colors.white24,
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
        ),
      ),
    );
  }

  static const _keyScrollStep = 80.0;
  static const _keyScrollStepFast = 400.0;

  void _scrollByKeyboard(double deltaPixels) {
    if (!itemScrollController.isAttached) return;

    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    final reference = positions.reduce((a, b) => a.index < b.index ? a : b);
    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (viewportHeight <= 0) return;

    itemScrollController.scrollTo(
      index: reference.index,
      alignment: reference.itemLeadingEdge - deltaPixels / viewportHeight,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    if (_isPagedMode) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
        case LogicalKeyboardKey.keyW:
        case LogicalKeyboardKey.arrowLeft:
        case LogicalKeyboardKey.keyA:
          _pageBackward();
          return KeyEventResult.handled;
        case LogicalKeyboardKey.arrowDown:
        case LogicalKeyboardKey.keyS:
        case LogicalKeyboardKey.arrowRight:
        case LogicalKeyboardKey.keyD:
          _pageForward();
          return KeyEventResult.handled;
        default:
          return KeyEventResult.ignored;
      }
    }

    final step = HardwareKeyboard.instance.isShiftPressed ? _keyScrollStepFast : _keyScrollStep;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
      case LogicalKeyboardKey.keyW:
        _scrollByKeyboard(-step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowDown:
      case LogicalKeyboardKey.keyS:
        _scrollByKeyboard(step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.keyA:
        if (widget.manga.readingProgress > 1) previous();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.keyD:
        if (widget.manga.readingProgress < widget.manga.countChapters.toInt()) {
          next();
        }
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  void _pageForward() {
    if (!_pageController.hasClients) return;
    final current = _pageController.page?.round() ?? 0;
    final last = (_images?.length ?? 1) - 1;
    if (current < last) {
      _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    } else if (widget.manga.readingProgress < widget.manga.countChapters.toInt()) {
      next();
    }
  }

  void _pageBackward() {
    if (!_pageController.hasClients) return;
    final current = _pageController.page?.round() ?? 0;
    if (current > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    } else if (widget.manga.readingProgress > 1) {
      previous();
    }
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
          index: _chapter.offset.page.clamp(0, links.length - 1),
          alignment: _chapter.offset.pixels / 100,
          duration: Duration(seconds: 3),
          opacityAnimationWeights: [20, 20, 60],
          curve: Curves.easeOut,
        );
      }
    })();

    return ResponsiveContent(
      maxWidth: 900,
      child: Scrollbar(
        radius: const Radius.circular(4.0),
        thickness: 6.0,
        child: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          padding: EdgeInsets.zero,
          itemCount: links.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => _buildPage(links[index]),
        ),
      ),
    );
  }

  Widget _buildPagedView(List<_ReaderPage> links) {
    (() async {
      if (links.isEmpty) return;

      final initialFraction = widget.initialFraction;
      final index = initialFraction != null
          ? (initialFraction * links.length).round().clamp(0, links.length - 1)
          : _lastOffsetPage.clamp(0, links.length - 1);

      int timeout = 0;
      while (!_pageController.hasClients && timeout++ != 5) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      if (!_pageController.hasClients) return;

      _pageController.jumpToPage(index);
      if (mounted) setState(() => _currentPage = index);
    })();

    return ResponsiveContent(
      maxWidth: 900,
      child: PageView.builder(
        controller: _pageController,
        itemCount: links.length,
        onPageChanged: (index) {
          _recordOffset(index, 0);
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) => _buildPage(links[index], paged: true),
      ),
    );
  }

  Widget _buildPage(_ReaderPage page, {bool paged = false}) {
    final Widget image = _isOffline
        ? downloadStorage.pageImage(
            page.url,
            alignment: paged ? Alignment.center : Alignment.topCenter,
            fit: paged ? BoxFit.contain : BoxFit.fitWidth,
            height: paged ? double.infinity : null,
          )
        : Image.network(
            page.url,
            webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
            alignment: paged ? Alignment.center : Alignment.topCenter,
            filterQuality: FilterQuality.high,
            fit: paged ? BoxFit.contain : BoxFit.fitWidth,
            width: double.infinity,
            height: paged ? double.infinity : null,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              final total = loadingProgress.expectedTotalBytes;
              return SizedBox.fromSize(
                size: const Size.fromHeight(500),
                child: Center(
                  child: CircularProgressIndicator(
                    value: total != null ? loadingProgress.cumulativeBytesLoaded / total : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              // ignore: avoid_print
              print('Image failed to load: ${page.url}: $error');
              return SizedBox.fromSize(
                size: const Size.fromHeight(500),
                child: const ImageErrorPlaceholder(),
              );
            },
          );

    if (paged) return SizedBox.expand(child: image);

    if (page.width == null || page.height == null || page.width! <= 0 || page.height! <= 0) {
      return image;
    }
    return AspectRatio(aspectRatio: page.width! / page.height!, child: image);
  }

  Future<void> previous() async {
    --widget.manga.readingProgress;
    if (!await _goToProgress()) ++widget.manga.readingProgress;
  }

  Future<void> next() async {
    ++widget.manga.readingProgress;
    if (!await _goToProgress()) --widget.manga.readingProgress;
  }

  Future<bool> _goToProgress() async {
    ChapterReply chapter;
    try {
      chapter = await api.chapter.get(
        ChapterRequest(
          mangaSourceId: widget.source.id,
          index: widget.manga.readingProgress,
        ),
      );
    } catch (e) {
      final offline = await loadOfflineChapters(widget.manga.id);
      final found = offline?.firstWhereOrNull((c) => c.index.toInt() == widget.manga.readingProgress);
      if (found == null) {
        if (mounted) Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'chapter.not-downloaded')).ignore();
        return false;
      }
      chapter = found;
    }
    await syncReadingProgress(widget.manga, progress: widget.manga.readingProgress, chapterId: chapter.id);
    await _goToChapter(chapter);
    return true;
  }

  Future<void> _goToChapter(ChapterReply chapter, {double? initialFraction}) async {
    if (!mounted) return;

    _offsetDebounce?.cancel();
    await updateOffset(chapterId: _chapter.id, page: _lastOffsetPage, pixels: _lastOffsetPixels);
    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(name: chapterRouteNameFor(mangaId: widget.manga.id, chapter: chapter)),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, __, ___) => MangaChapterScreen(
          manga: widget.manga,
          chapter: chapter,
          source: widget.source,
          initialFraction: initialFraction,
        ),
      ),
    );
  }
}
