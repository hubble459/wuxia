import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/chapter.pb.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/reading.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/screen/manga/manga_chapters_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _manga = widget.manga;
    _animationController
        .repeat(period: const Duration(seconds: 1))
        .whenComplete(() => _animationController.repeat(period: const Duration(seconds: 1)));
    setState(() {});
    (() async {
      try {
        _manga = await api.manga.get(Id(id: _manga.id));
      } finally {
        _animationController.reset();
        setState(() {});
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_manga);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_manga.title),
                Text(
                  Uri.parse(_manga.url).host,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  launchUrlString(_manga.url, mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.open_in_browser),
              ),
              RotationTransition(
                turns: CurvedAnimation(parent: _animationController, curve: Curves.linear),
                child: IconButton(
                  onPressed: _animationController.isAnimating
                      ? null
                      : () async {
                          _animationController
                              .repeat(period: const Duration(seconds: 1))
                              .whenComplete(() => _animationController.repeat(period: const Duration(seconds: 1)));

                          setState(() {});

                          try {
                            _manga = await api.manga.update(Id(id: _manga.id));
                          } catch (e) {
                            log('force update manga', error: e);
                            Fluttertoast.showToast(msg: e.toString());
                          } finally {
                            _animationController.reset();
                            setState(() {});
                          }
                        },
                  tooltip: FlutterI18n.translate(context, 'basic.refresh'),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Visibility(
                    visible: _manga.hasCover(),
                    child: Hero(
                      tag: widget.type.getTag(_manga.url),
                      child: CachedNetworkImage(imageUrl: _manga.cover.toString()),
                    ),
                  ),
                  MangaDetails(
                    manga: _manga,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
              width: double.infinity,
              child: _manga.hasReadingProgress()
                  ? _ChapterSelector(
                      manga: _manga,
                      refreshParent: () {
                        setState(() {});
                      },
                    )
                  : _NewMangaOptions(manga: _manga)),
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

  const _NewMangaOptions({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: Theme.of(context).colorScheme.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        final m = await api.reading.create(ReadingPostRequest(mangaId: manga.id));
        manga.mergeFromMessage(m);
      },
      child: I18nText('manga.add'),
    );
  }
}

mixin ReadingManga on MangaReply {
  get progressPercentage {
    final count = countChapters.toInt();
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => MangaChaptersScreen(manga: widget.manga),
                  ),
                )
                .then((value) => refresh());
          },
          child: I18nText('manga.chapters'),
        ),
        LinearProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
          value: widget.manga.progressPercentage,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: MaterialButton(
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                color: Theme.of(context).colorScheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  widget.manga.readingProgress = 1;
                  await api.reading.edit(ReadingPatchRequest(
                    mangaId: widget.manga.id,
                    progress: widget.manga.readingProgress,
                  ));
                  final chapter = await api.chapter.get(ChapterRequest(
                    mangaId: widget.manga.id,
                    index: widget.manga.readingProgress,
                  ));
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            manga: widget.manga,
                            chapter: chapter,
                          ),
                        ),
                      )
                      .then((value) => refresh());
                },
                child: I18nText('manga.first'),
              ),
            ),
            Flexible(
              flex: 2,
              child: MaterialButton(
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                color: Theme.of(context).colorScheme.secondary,
                splashColor: Theme.of(context).primaryColorLight,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  if (widget.manga.readingProgress == 0) {
                    widget.manga.readingProgress = 1;
                    await api.reading.edit(ReadingPatchRequest(
                      mangaId: widget.manga.id,
                      progress: widget.manga.readingProgress,
                    ));
                  }
                  final chapter = await api.chapter.get(ChapterRequest(
                    mangaId: widget.manga.id,
                    index: widget.manga.readingProgress,
                  ));
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            manga: widget.manga,
                            chapter: chapter,
                          ),
                        ),
                      )
                      .then((value) => refresh());
                },
                child: I18nText('manga.continue'),
              ),
            ),
            Flexible(
              flex: 1,
              child: MaterialButton(
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                color: Theme.of(context).colorScheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  widget.manga.readingProgress = widget.manga.countChapters.toInt();
                  await api.reading.edit(ReadingPatchRequest(
                    mangaId: widget.manga.id,
                    progress: widget.manga.readingProgress,
                  ));
                  final chapter = await api.chapter.get(ChapterRequest(
                    mangaId: widget.manga.id,
                    index: widget.manga.readingProgress,
                  ));
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            manga: widget.manga,
                            chapter: chapter,
                          ),
                        ),
                      )
                      .then((value) => refresh());
                },
                child: I18nText('manga.last'),
              ),
            )
          ],
        ),
      ],
    );
  }

  refresh() {
    setState(() {});
    widget.refreshParent();
  }
}
