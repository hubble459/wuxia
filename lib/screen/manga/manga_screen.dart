import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/gen/rumgap/v1/scrape_error.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/screen/manga/manga_chapters_screen.dart';
import 'package:wuxia/util/tools.dart';

class MangaScreen extends StatefulWidget {
  final MangaReply manga;
  final HeroScreenType type;

  const MangaScreen({Key? key, required this.manga, required this.type}) : super(key: key);

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
      if (e is GrpcError) {
        print('details');
        print(e.details);
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

            // TODO 16/11/2023: Show dialog telling end user to switch manga provider
            // showDialog(context: context, builder: (context) => const DeadProviderDialog());
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
    } finally {
      // Stop loading animation
      _animationController.reset();
      setState(() {});
    }
  }

  var _imageHeight = 400.0;

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
      onPopInvoked: (didPop) async {
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
                    child: Text(
                      Uri.parse(_manga.url).host,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                      overflow: TextOverflow.ellipsis,
                    ),
                    preferredSize: Size.fromHeight(1),
                  ),
                  background: Visibility(
                    visible: _manga.hasCover(),
                    child: Hero(
                      tag: widget.type.getTag(_manga.url),
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

  const _NewMangaOptions({Key? key, required this.manga, required this.refreshParent}) : super(key: key);

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
  get progressPercentage {
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

  const _ChapterSelector({Key? key, required this.manga, required this.refreshParent}) : super(key: key);

  @override
  State<_ChapterSelector> createState() => _ChapterSelectorState();
}

class _ChapterSelectorState extends State<_ChapterSelector> {
  final _scrollController = ItemScrollController();
  final _itemPositionListener = ItemPositionsListener.create();
  var _pageSize = 20;

  openChapters() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MangaChaptersScreen(manga: widget.manga),
      ),
    );
    refresh();
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
                  'Failed to load chapters...',
                  style: TextStyle(color: Colors.red),
                )
              ]
            : [
                // Chapters
                Expanded(
                  child: Container(
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
                            shrinkWrap: true,
                            itemCount: chapters.items.length,
                            itemBuilder: (context, index) {
                              final chapter = chapters.items[index];
                              if (index == 0 || index == chapters.items.length - 1) {
                                return MaterialButton(
                                  onPressed: openChapters,
                                  minWidth: 1,
                                  child: Icon(index == 0 ? Icons.arrow_left : Icons.arrow_right),
                                );
                              }
                              return MaterialButton(
                                color:
                                    widget.manga.readingProgress >= chapter.index.toInt() ? Colors.grey.withOpacity(0.2) : null,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                onPressed: () {},
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
                  minWidth: 10,
                  onPressed: () {},
                  child: I18nText('manga.continue'),
                ),
              ]),
      ],
    );
  }

  refresh() {
    setState(() {});
    widget.refreshParent();
  }
}
