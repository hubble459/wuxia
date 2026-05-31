import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/gen/rumgap/v1/scrape_error.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/dialog/dead_provider_dialog.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/screen/manga/manga_chapters_screen.dart';
import 'package:wuxia/screen/search_screen.dart';
import 'package:wuxia/util/tools.dart';

enum _MangaMenuAction { searchAlternatives, download }

class MangaScreen extends StatefulWidget {
  final MangaReply manga;
  final HeroScreenType type;
  final String? heroTag;

  const MangaScreen({super.key, required this.manga, required this.type, this.heroTag});

  @override
  State<MangaScreen> createState() => _MangaScreenState();
}

class _MangaScreenState extends State<MangaScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    upperBound: 1,
    lowerBound: 0,
    value: 0,
  );
  late MangaReply _manga;

  Future<void> loadManga({bool force = false}) async {
    // Start loading animation
    _animationController
        .repeat(period: const Duration(seconds: 1))
        .whenComplete(() => _animationController.repeat(period: const Duration(seconds: 1)));
    setState(() {});

    try {
      if (force) {
        _manga = await api.manga.update(Id(id: _manga.id));
      } else {
        _manga = await api.manga.get(Id(id: _manga.id));
      }
    } catch (e) {
      print('error');
      print(e);

      if (e is GrpcError && e.details != null) {
        final error = ScrapeError.fromBuffer((e.details![0] as dynamic).value);
        switch (error.type) {
          case ScrapeErrorType.CloudflareIUAM:
            // Tell user to wait for a couple of minutes and try again
            Fluttertoast.showToast(msg: 'CloudFlare is in "I\'m Under Attack Mode". Wait a couple of minutes before trying again')
                .ignore();
            break;
          case ScrapeErrorType.WebsiteNotSupported:
            // User should look for alternatives
            Fluttertoast.showToast(msg: 'WIP; but you probably have to replace this manga from a different website').ignore();
            break;
          case ScrapeErrorType.WebScrapingError:
            // Scraper is broken
            // Either switch from provider or wait till scraper is fixed
            Fluttertoast.showToast(msg: error.message).ignore();
            break;
          default:
            Fluttertoast.showToast(msg: error.message).ignore();
        }
      } else {
        Fluttertoast.showToast(msg: e.toString()).ignore();
      }
      if (mounted && context.mounted) {
        showDialog(context: context, builder: (context) => DeadProviderDialog(mangaTitle: _manga.title));
      }
    } finally {
      // Stop loading animation
      _animationController.reset();
      setState(() {});
    }
  }

  Future<void> _downloadManga() async {
    final totalChapters = _manga.countChapters.toInt();
    if (totalChapters == 0) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.no-chapters')).ignore();
      return;
    }

    final progress = ValueNotifier<int>(0);
    var cancelled = false;

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(FlutterI18n.translate(ctx, 'manga.download')),
        content: ValueListenableBuilder<int>(
          valueListenable: progress,
          builder: (_, downloaded, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: downloaded / totalChapters),
              const SizedBox(height: 8),
              Text('$downloaded / $totalChapters'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              cancelled = true;
              Navigator.of(ctx).pop();
            },
            child: Text(FlutterI18n.translate(ctx, 'basic.cancel')),
          ),
        ],
      ),
    );

    try {
      final dir = await getDownloadDirectory();
      final safeName = _manga.title.replaceAll(RegExp(r'[^\w\s\-]'), '_');
      final mangaDir = Directory('${dir.path}/$safeName');

      final chapters = await api.chapter.index(PaginateChapterQuery(
        id: _manga.id,
        reversed: false,
        paginateQuery: PaginateQuery(page: Int64(0), perPage: Int64(totalChapters)),
      ));

      await mangaDir.create(recursive: true);
      await File('${mangaDir.path}/manga.pb').writeAsBytes(_manga.writeToBuffer());
      await File('${mangaDir.path}/chapters.pb').writeAsBytes(chapters.writeToBuffer());

      for (final chapter in chapters.items) {
        if (cancelled) break;

        final chapterDir = Directory('${mangaDir.path}/${chapter.number.toStringAsFixed(1).replaceAll('.0', '')}');
        await chapterDir.create(recursive: true);

        final images = await api.chapter.images(Id(id: chapter.id));
        for (var i = 0; i < images.items.length; i++) {
          if (cancelled) break;
          final url = images.items[i];
          final response = await http.get(
            Uri.parse(url),
            headers: {'Referer': getReferer(chapter, url)},
          );
          final ext = url.split('.').last.split('?').first;
          await File('${chapterDir.path}/$i.$ext').writeAsBytes(response.bodyBytes);
        }

        progress.value++;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString()).ignore();
    } finally {
      progress.dispose();
      if (mounted && !cancelled) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'manga.download-complete')).ignore();
      }
    }
  }

  final _imageHeight = 400.0;

  @override
  void initState() {
    _manga = widget.manga;

    loadManga();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(_manga.deepCopy());
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                snap: false,
                floating: true,
                stretch: true,
                expandedHeight: _imageHeight,
                flexibleSpace: FlexibleSpaceBar(
                  title: PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Text(
                      Uri.parse(_manga.url).host,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  background: Visibility(
                    visible: _manga.hasCover(),
                    child: Hero(
                      tag: widget.heroTag ?? widget.type.getTag(_manga.url),
                      child: CachedNetworkImage(
                        imageUrl: _manga.cover,
                        fit: BoxFit.fitWidth,
                        httpHeaders: {
                          'Referer': getReferer(_manga),
                        },
                      ),
                    ),
                  ),
                ),
                actions: [
                  OpenURLAction(url: _manga.url),
                  RotationTransition(
                    turns: CurvedAnimation(parent: _animationController, curve: Curves.linear),
                    child: IconButton(
                      onPressed: _animationController.isAnimating ? null : () => loadManga(force: true),
                      tooltip: FlutterI18n.translate(context, 'basic.refresh'),
                      icon: const Icon(Icons.refresh),
                    ),
                  ),
                  PopupMenuButton<_MangaMenuAction>(
                    onSelected: (action) async {
                      if (action == _MangaMenuAction.searchAlternatives) {
                        final titles = [_manga.title, ..._manga.altTitles];
                        final chosen = await showDialog<String>(
                          context: context,
                          builder: (ctx) => SimpleDialog(
                            title: Text(FlutterI18n.translate(ctx, 'manga.search-alternatives')),
                            children: titles
                                .map((t) => SimpleDialogOption(
                                      onPressed: () => Navigator.of(ctx).pop(t),
                                      child: Text(t),
                                    ))
                                .toList(),
                          ),
                        );
                        if (chosen != null && context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                appBar: AppBar(),
                                body: SearchScreen(query: chosen),
                              ),
                            ),
                          );
                        }
                      } else if (action == _MangaMenuAction.download) {
                        _downloadManga();
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: _MangaMenuAction.searchAlternatives,
                        child: Text(FlutterI18n.translate(context, 'manga.search-alternatives')),
                      ),
                      PopupMenuItem(
                        value: _MangaMenuAction.download,
                        child: Text(FlutterI18n.translate(context, 'manga.download')),
                      ),
                    ],
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList.list(
                  children: [
                    MangaDetails(
                      manga: _manga,
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: _animationController.isAnimating
              ? null
              : SizedBox(
                  width: double.infinity,
                  child: _manga.hasReadingProgress()
                      ? _ChapterSelector(
                          manga: _manga,
                          refreshParent: () {
                            setState(() {});
                          },
                        )
                      : _NewMangaOptions(
                          manga: _manga,
                          refreshParent: () {
                            setState(() {});
                          },
                        ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _NewMangaOptions extends StatelessWidget {
  final MangaReply manga;
  final Function() refreshParent;

  const _NewMangaOptions({required this.manga, required this.refreshParent});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: Theme.of(context).colorScheme.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        final m = await api.reading.create(ReadingPostRequest(mangaId: manga.id));
        manga.clear();
        manga.mergeFromMessage(m);
        refreshParent();
      },
      child: I18nText('manga.add'),
    );
  }
}

mixin ReadingManga on MangaReply {
  double get progressPercentage {
    final count = countChapters.toInt();
    if (count.isNaN || count == 0) {
      return 0.0;
    }
    return 100 / count * readingProgress;
  }
}

class _ChapterSelector extends StatefulWidget {
  final MangaReply manga;
  final Function() refreshParent;

  const _ChapterSelector({required this.manga, required this.refreshParent});

  @override
  State<_ChapterSelector> createState() => _ChapterSelectorState();
}

class _ChapterSelectorState extends State<_ChapterSelector> {
  final _scrollController = ItemScrollController();
  final _itemPositionListener = ItemPositionsListener.create();
  var _pageSize = 20;

  Future<void> openChapters() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MangaChaptersScreen(manga: widget.manga),
      ),
    );
    refresh();
  }

  Future<void> continueReading() async {
    if (widget.manga.readingProgress == 0) {
      widget.manga.readingProgress = 1;
      await api.reading.update(ReadingPatchRequest(
        mangaId: widget.manga.id,
        progress: widget.manga.readingProgress,
      ));
    }
    final chapter = await api.chapter.get(ChapterRequest(
      mangaId: widget.manga.id,
      index: widget.manga.readingProgress,
    ));
    if (!mounted) return;
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => MangaChapterScreen(
              manga: widget.manga,
              chapter: chapter,
            ),
          ),
        )
        .then((value) => refresh());
  }

  Future<void> gotoChapter(ChapterReply chapter) async {
    widget.manga.readingProgress = chapter.index.toInt();
    await api.reading.update(ReadingPatchRequest(
      mangaId: widget.manga.id,
      progress: widget.manga.readingProgress,
    ));

    if (!mounted) return;

    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => MangaChapterScreen(
              manga: widget.manga,
              chapter: chapter,
            ),
          ),
        )
        .then((value) => refresh());
  }

  PaginateQuery get paginateQuery {
    final progress = widget.manga.readingProgress;
    final till = progress;
    final from = max(till - _pageSize, 0);
    var page = max((from / _pageSize).floor(), (till / _pageSize).floor());
    final items = widget.manga.countChapters - (page * _pageSize);
    if (items < _pageSize) {
      page -= 1;
      _pageSize *= 2;
    }

    return PaginateQuery(
      page: Int64(page),
      perPage: Int64(_pageSize),
    );
  }

  Future<ChaptersReply> getChapters() async {
    // TODO 26/11/2023: Keep this in memory (inside manga object?)
    return api.chapter.index(PaginateChapterQuery(
      id: widget.manga.id,
      reversed: true,
      paginateQuery: paginateQuery,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Chapter button
        IconButton(onPressed: widget.manga.countChapters == 0 ? null : openChapters, icon: Icon(Icons.list_alt)),

        ...(widget.manga.countChapters == 0
            ? [
                Text(
                  FlutterI18n.translate(context, 'manga.no-chapters'),
                  style: TextStyle(color: Colors.red),
                )
              ]
            : [
                // Chapters
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: SimpleFutureBuilder(
                        future: getChapters(),
                        onLoadedBuilder: (context, ChaptersReply chapters) {
                          chapters.items.insert(0, ChapterReply());
                          chapters.items.add(ChapterReply());
                          return ScrollablePositionedList.builder(
                            initialScrollIndex: widget.manga.readingProgress % _pageSize,
                            itemScrollController: _scrollController,
                            itemPositionsListener: _itemPositionListener,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: chapters.items.length,
                            itemBuilder: (context, index) {
                              final chapter = chapters.items[index];
                              if (index == 0 || index == chapters.items.length - 1) {
                                return MaterialButton(
                                  onPressed: openChapters,
                                  minWidth: 0,
                                  child: Icon(index == 0 ? Icons.arrow_left : Icons.arrow_right),
                                );
                              }
                              return MaterialButton(
                                color: widget.manga.readingProgress >= chapter.index.toInt()
                                    ? Colors.grey.withValues(alpha: 0.2)
                                    : null,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                onPressed: () => gotoChapter(chapter),
                                child: Text(chapter.number.toStringAsFixed(1).replaceAll('.0', '')),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Continue
                MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 50,
                  color: Theme.of(context).colorScheme.secondary,
                  splashColor: Theme.of(context).primaryColorLight,
                  minWidth: 0,
                  onPressed: continueReading,
                  child: I18nText('manga.continue'),
                ),
              ]),
      ],
    );
  }

  void refresh() {
    setState(() {});
    widget.refreshParent();
  }
}
