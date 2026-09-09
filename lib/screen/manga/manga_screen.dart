import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/scrape_error.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/dialog/dead_provider_dialog.dart';
import 'package:wuxia/partial/dialog/source_picker_dialog.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/partial/dialog/add_manga_dialog.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/screen/manga/manga_bottom_bar.dart';
import 'package:wuxia/screen/manga/manga_downloader.dart';
import 'package:wuxia/screen/search_screen.dart';
import 'package:wuxia/util/tools.dart';

enum _MangaMenuAction { addSource, addSourceFromUrl, download, forceRescrape }

/// The three ways manga data can be refreshed, cheapest first:
/// - [cached]: plain read from rumgap's own store, no scraping.
/// - [rescrape]: triggers a scrape, but lets the server decide whether it's
///   actually due for one.
/// - [forceRescrape]: always scrapes regardless of staleness -- admin only,
///   since it's the most expensive and easiest to abuse.
enum _RefreshMode { cached, rescrape, forceRescrape }

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

  // The source chapters/reading actions are currently scoped to. Kept as a
  // single stable object (mutated in place rather than reassigned) so that
  // widgets further down the navigation stack (MangaChaptersScreen,
  // MangaChapterScreen) which hold the same reference automatically see a
  // source switch made from within them once we're back on this screen.
  late MangaSourceReply _selectedSource;
  bool _selectedSourceInitialized = false;

  void _syncSelectedSource() {
    if (_manga.sources.isEmpty) {
      _selectedSource = MangaSourceReply();
      _selectedSourceInitialized = true;
      return;
    }

    if (_selectedSourceInitialized) {
      final stillExists = _manga.sources.firstWhereOrNull((s) => s.id == _selectedSource.id);
      if (stillExists != null) {
        _selectedSource.clear();
        _selectedSource.mergeFromMessage(stillExists);
        return;
      }
    }

    final preferredHostname = API.loggedIn.preferredHostnames.firstOrNull;
    final preferred = _manga.sources.firstWhereOrNull((s) => s.hostname == preferredHostname);
    final primary = _manga.sources.firstWhereOrNull((s) => s.isPrimary);
    _selectedSource = (preferred ?? primary ?? _manga.sources.first).deepCopy();
    _selectedSourceInitialized = true;
  }

  Future<void> _switchSource() async {
    if (_manga.sources.length <= 1) return;

    final selected = await showSourcePickerDialog(context, _manga.sources.toList());
    if (selected != null && mounted) {
      setState(() {
        _selectedSource.clear();
        _selectedSource.mergeFromMessage(selected);
      });
    }
  }

  Future<void> loadManga({_RefreshMode mode = _RefreshMode.cached}) async {
    // Start loading animation
    _animationController
        .repeat(period: const Duration(seconds: 1))
        .whenComplete(() => _animationController.repeat(period: const Duration(seconds: 1)));
    setState(() {});

    try {
      switch (mode) {
        case _RefreshMode.cached:
          _manga = await api.manga.get(GetMangaRequest(id: _manga.id));
        case _RefreshMode.rescrape:
          _manga = await api.manga.update(UpdateMangaRequest(id: _manga.id, force: false));
        case _RefreshMode.forceRescrape:
          _manga = await api.manga.update(UpdateMangaRequest(id: _manga.id, force: true));
      }
      if (!kIsWeb) {
        // A chapter read while offline couldn't sync its progress to the
        // server (see `syncReadingProgress`) -- now that a fetch just
        // succeeded, retry it.
        await flushPendingProgress(_manga);
      }
      _syncSelectedSource();
    } catch (e) {
      if (!kIsWeb && mode == _RefreshMode.cached) {
        final localDir = await findDownloadedMangaDir(_manga.id);
        if (localDir != null) {
          try {
            final bytes = await File('${localDir.path}/manga.pb').readAsBytes();
            _manga = MangaReply.fromBuffer(bytes);
            _syncSelectedSource();
            return;
          } catch (_) {
            // Fall through to the normal online-error handling below --
            // corrupt/unreadable local copy shouldn't hide the real error.
          }
        }
      }

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
        showDialog(
          context: context,
          builder: (context) => DeadProviderDialog(
            mangaTitle: _manga.title,
            mangaId: _manga.id,
            sources: _manga.sources,
            onSwitchSource: (source) {
              setState(() {
                _selectedSource.clear();
                _selectedSource.mergeFromMessage(source);
              });
            },
            onMangaUpdated: (manga) {
              setState(() {
                _manga = manga;
                _syncSelectedSource();
              });
            },
          ),
        );
      }
    } finally {
      // Stop loading animation
      _animationController.reset();
      setState(() {});
    }
  }

  final _imageHeight = 400.0;

  @override
  void initState() {
    _manga = widget.manga;
    _syncSelectedSource();

    loadManga();

    super.initState();
  }

  static const _wideBreakpoint = 900.0;

  List<Widget> _appBarActions(BuildContext context) {
    return [
      OpenURLAction(url: _selectedSource.url),
      IconButton(
        onPressed: _manga.sources.length > 1 ? _switchSource : null,
        tooltip: FlutterI18n.translate(context, 'manga.switch_source'),
        icon: const Icon(Icons.swap_horiz),
      ),
      RotationTransition(
        turns: CurvedAnimation(parent: _animationController, curve: Curves.linear),
        child: IconButton(
          onPressed: _animationController.isAnimating ? null : () => loadManga(),
          onLongPress: _animationController.isAnimating ? null : () => loadManga(mode: _RefreshMode.rescrape),
          tooltip: FlutterI18n.translate(context, 'basic.refresh'),
          icon: const Icon(Icons.refresh),
        ),
      ),
      PopupMenuButton<_MangaMenuAction>(
        onSelected: (action) async {
          if (action == _MangaMenuAction.addSource) {
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
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(),
                    body: SearchScreen(query: chosen, existingMangaId: _manga.id),
                  ),
                ),
              );
              if (result is MangaReply && mounted) {
                setState(() {
                  _manga = result;
                  _syncSelectedSource();
                });
              }
            }
          } else if (action == _MangaMenuAction.addSourceFromUrl) {
            final result = await showDialog<MangaReply>(
              context: context,
              builder: (_) => AddMangaDialog(existingMangaId: _manga.id),
            );
            if (result != null && mounted) {
              setState(() {
                _manga = result;
                _syncSelectedSource();
              });
            }
          } else if (action == _MangaMenuAction.download) {
            MangaDownloader(manga: _manga, source: _selectedSource).download(context);
          } else if (action == _MangaMenuAction.forceRescrape) {
            loadManga(mode: _RefreshMode.forceRescrape);
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(
            value: _MangaMenuAction.addSource,
            child: Text(FlutterI18n.translate(context, 'manga.add-source')),
          ),
          PopupMenuItem(
            value: _MangaMenuAction.addSourceFromUrl,
            child: Text(FlutterI18n.translate(context, 'manga.add-source-url')),
          ),
          if (!kIsWeb)
            PopupMenuItem(
              value: _MangaMenuAction.download,
              child: Text(FlutterI18n.translate(context, 'manga.download')),
            ),
          if (API.loggedIn.isAdmin)
            PopupMenuItem(
              value: _MangaMenuAction.forceRescrape,
              child: Text(FlutterI18n.translate(context, 'manga.force-rescrape')),
            ),
        ],
      ),
    ];
  }

  Widget _sourceSwitcher(BuildContext context, {TextStyle? style}) {
    return GestureDetector(
      onTap: _switchSource,
      child: Text(
        _selectedSource.hostname,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _coverImage({BoxFit fit = BoxFit.fitWidth}) {
    return Visibility(
      visible: _manga.hasCover(),
      child: Hero(
        tag: widget.heroTag ?? widget.type.getTag(_manga.id.toString()),
        child: CachedNetworkImage(
          imageUrl: _manga.cover,
          fit: fit,
        ),
      ),
    );
  }

  Widget _buildNarrowBody(BuildContext context) {
    return CustomScrollView(
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
              child: _sourceSwitcher(context, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54)),
            ),
            background: _coverImage(),
          ),
          actions: _appBarActions(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList.list(
            children: [
              ResponsiveContent(
                maxWidth: 800,
                child: MangaDetails(
                  manga: _manga,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildWideBody(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: _sourceSwitcher(context, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white54)),
          actions: _appBarActions(context),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ResponsiveContent(
              maxWidth: 1100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _manga.title.replaceAll('\n', ' '),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          if (_manga.altTitles.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _manga.altTitles.join(' · '),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: _coverImage(fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: MangaDetails(manga: _manga, showTitle: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(_manga.deepCopy());
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: isWide ? _buildWideBody(context) : _buildNarrowBody(context),
          bottomNavigationBar: _animationController.isAnimating
              ? null
              : SizedBox(
                  width: double.infinity,
                  child: _manga.hasReadingProgress()
                      ? ChapterSelector(
                          manga: _manga,
                          source: _selectedSource,
                          refreshParent: () {
                            setState(() {});
                          },
                        )
                      : NewMangaOptions(
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

