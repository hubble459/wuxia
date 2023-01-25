import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/model/manga.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/model/simple_manga.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/screen/manga/manga_chapter_screen.dart';
import 'package:wuxia/screen/manga/manga_chapters_screen.dart';

class MangaScreen extends StatefulWidget {
  final Reading? reading;
  final SimpleManga manga;

  const MangaScreen({Key? key, required this.manga, this.reading}) : super(key: key);

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
  late Manga _manga;
  late Reading? _reading;

  @override
  void initState() {
    super.initState();
    _reading = widget.reading;
    if (widget.manga is Manga) {
      _manga = widget.manga as Manga;
    } else {
      _manga = widget.manga.toManga();
      _animationController
          .repeat(period: const Duration(seconds: 1))
          .whenComplete(() => _animationController.repeat(period: const Duration(seconds: 1)));
      setState(() {});
      (() async {
        try {
          final manga = await api.manga(_manga.id);
          _manga = manga;
          if (_reading != null) {
            _reading!.manga.update(manga);
          }
        } finally {
          _animationController.reset();
          setState(() {});
        }
      })();
    }
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
                I18nText('title'),
                Text(
                  _manga.title,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white54),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  launchUrl(_manga.url, mode: LaunchMode.externalApplication);
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
                            final manga = await api.manga(_manga.id, force: true);
                            _manga = manga;
                            if (_reading != null) {
                              _reading!.manga.update(manga);
                            }
                          } catch (e) {
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
                    visible: _manga.cover != null,
                    child: CachedNetworkImage(imageUrl: _manga.cover.toString()),
                  ),
                  MangaDetails(
                    reading: _reading,
                    manga: _manga,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
              width: double.infinity,
              child: _reading != null
                  ? _ChapterSelector(
                      reading: _reading!,
                      refreshParent: () {
                        setState(() {});
                      },
                    )
                  : _NewMangaOptions(
                      manga: _manga,
                      refresh: (reading) {
                        _reading = reading;
                        _manga.reading = true;
                        setState(() {});
                      },
                    )),
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
  final Manga manga;
  final Function(Reading reading) refresh;

  const _NewMangaOptions({Key? key, required this.manga, required this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: Theme.of(context).colorScheme.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        final reading = await api.addToReading(manga);
        refresh(reading);
      },
      child: I18nText('manga.add'),
    );
  }
}

class _ChapterSelector extends StatefulWidget {
  final Reading reading;
  final Function() refreshParent;

  const _ChapterSelector({Key? key, required this.reading, required this.refreshParent}) : super(key: key);

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
                    builder: (context) => MangaChaptersScreen(reading: widget.reading),
                  ),
                )
                .then((value) => refresh());
          },
          child: I18nText('manga.chapters'),
        ),
        LinearProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
          value: widget.reading.progressPercentage,
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
                  widget.reading.progress = 1;
                  await api.updateProgress(widget.reading);
                  final chapter = await api.chapter(widget.reading);
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            reading: widget.reading,
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
                  if (widget.reading.progress == 0) {
                    widget.reading.progress = 1;
                    await api.updateProgress(widget.reading);
                  }
                  final chapter = await api.chapter(widget.reading);
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            reading: widget.reading,
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
                  widget.reading.progress = widget.reading.manga.chapterCount;
                  await api.updateProgress(widget.reading);
                  final chapter = await api.chapter(widget.reading);
                  if (!mounted) return;
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => MangaChapterScreen(
                            reading: widget.reading,
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
