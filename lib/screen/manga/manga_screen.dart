import 'dart:async';

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
import 'package:wuxia/partial/action/export_cbz_action.dart';
import 'package:wuxia/partial/action/open_url_action.dart';
import 'package:wuxia/partial/dialog/dead_provider_dialog.dart';
import 'package:wuxia/partial/dialog/manga_picker_dialog.dart';
import 'package:wuxia/partial/dialog/merge_confirm_dialog.dart';
import 'package:wuxia/partial/dialog/source_picker_dialog.dart';
import 'package:wuxia/partial/source_badge.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/partial/manga_details.dart';
import 'package:wuxia/screen/social/comments_screen.dart';
import 'package:wuxia/partial/dialog/add_manga_dialog.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/screen/manga/manga_bottom_bar.dart';
import 'package:wuxia/screen/search_screen.dart';
import 'package:wuxia/util/download_manager.dart';
import 'package:wuxia/util/tools.dart';

enum _MangaMenuAction {
  addSource,
  addSourceFromUrl,
  download,
  exportCbz,
  forceRescrape,
  mergeInto,
  mergeFrom,
  manageSources,
  moveSourceOut,
  moveSourceIn,
  toggleNsfw,
  deleteManga,
}

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

    final remembered = _manga.sources.firstWhereOrNull((s) => s.id == _manga.selectedSourceId);
    final preferredHostname = API.loggedIn.preferredHostnames.firstOrNull;
    final preferred = _manga.sources.firstWhereOrNull((s) => s.hostname == preferredHostname);
    final primary = _manga.sources.firstWhereOrNull((s) => s.isPrimary);
    _selectedSource = (remembered ?? preferred ?? primary ?? _manga.sources.first).deepCopy();
    _selectedSourceInitialized = true;
  }

  /// [_manga] as the selected source has it. The server already sends a manga with the
  /// details of the source it remembers for this user, but a switch on a manga outside
  /// the reading list isn't remembered, so the local selection decides what's shown.
  MangaReply get _shown => _manga.withSourceDetails(_selectedSource);

  void _selectSource(MangaSourceReply source) {
    setState(() {
      _selectedSource.clear();
      _selectedSource.mergeFromMessage(source);
    });
    _refreshDownloaded();
    _rememberSource(source);
  }

  /// Admin-only list to set a source primary or remove it outright.
  Future<void> _manageSources() async {
    final selected = await showSourcePickerDialog(
      context,
      _manga.sources.toList(),
      allowAdminActions: true,
      onSourcesChanged: loadManga,
      mangaId: _manga.id,
    );
    if (selected != null && mounted) _selectSource(selected);
  }

  /// Tells the server about a switch, which remembers it (for manga in the reading list)
  /// and returns the source's details freshly scraped when they were stale. Offline the
  /// local switch just stands.
  Future<void> _rememberSource(MangaSourceReply source) async {
    try {
      final result = await api.manga.selectSource(SelectSourceRequest(mangaSourceId: source.id));
      if (!mounted || _selectedSource.id != source.id) return;
      setState(() {
        _manga = result;
        _syncSelectedSource();
      });
    } catch (_) {}
  }

  /// Deletes this manga for everyone (mod/admin-only, irreversible), then pops back with
  /// no result so the list it was opened from drops it.
  Future<void> _deleteManga() async {
    if (!await confirmDeleteManga(context, _manga) || !mounted) return;
    try {
      await api.manga.delete(DeleteMangaRequest(id: _manga.id));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// Marks this manga 18+ or not (mod/admin-only).
  Future<void> _toggleNsfw() async {
    try {
      final result = await api.manga.setNsfw(SetNsfwRequest(mangaId: _manga.id, nsfw: !_manga.nsfw));
      if (mounted) setState(() => _manga.nsfw = result.nsfw);
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// Merges this manga into another (admin-only, irreversible) - this manga is deleted,
  /// all its sources/chapters/reading progress move onto the picked one.
  Future<void> _mergeInto() async {
    final target = await showMangaPickerDialog(context, excludeMangaId: _manga.id);
    if (target == null || !mounted) return;

    if (!await showMergeConfirmDialog(context, source: _manga, target: target) || !mounted) return;

    try {
      await api.manga.mergeManga(MergeMangaRequest(sourceMangaId: _manga.id, targetMangaId: target.id));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// Merges another manga into this one (admin-only, irreversible) - the picked manga is
  /// deleted, its sources/chapters/reading progress move onto this one.
  Future<void> _mergeFrom() async {
    final source = await showMangaPickerDialog(context, excludeMangaId: _manga.id);
    if (source == null || !mounted) return;

    if (!await showMergeConfirmDialog(context, source: source, target: _manga) || !mounted) return;

    try {
      final result = await api.manga.mergeManga(MergeMangaRequest(sourceMangaId: source.id, targetMangaId: _manga.id));
      if (mounted) {
        setState(() {
          _manga = result;
          _syncSelectedSource();
        });
      }
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// Moves one of this manga's sources onto another manga (admin-only). If it was this
  /// manga's only source, this manga is now gone too (see MoveSource on the server).
  Future<void> _moveSourceOut() async {
    final source = await showSourcePickerDialog(context, _manga.sources.toList());
    if (source == null || !mounted) return;

    final target = await showMangaPickerDialog(context, excludeMangaId: _manga.id);
    if (target == null || !mounted) return;

    final wasOnlySource = _manga.sources.length == 1;
    try {
      await api.manga.moveSource(MoveSourceRequest(mangaSourceId: source.id, targetMangaId: target.id));
      if (!mounted) return;
      if (wasOnlySource) {
        Navigator.of(context).pop();
      } else {
        loadManga();
      }
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// Pulls a source from another manga onto this one (admin-only) - the mirror of
  /// _moveSourceOut, for when you're already on the manga that should keep it.
  Future<void> _moveSourceIn() async {
    final other = await showMangaPickerDialog(context, excludeMangaId: _manga.id);
    if (other == null || !mounted || other.sources.isEmpty) return;

    final source = await showSourcePickerDialog(context, other.sources.toList());
    if (source == null || !mounted) return;

    try {
      final result = await api.manga.moveSource(MoveSourceRequest(mangaSourceId: source.id, targetMangaId: _manga.id));
      if (mounted) {
        setState(() {
          _manga = result;
          _syncSelectedSource();
        });
      }
    } catch (e) {
      if (mounted) Fluttertoast.showToast(msg: e.toString());
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
      if (downloadsSupported) {
        // A chapter read while offline couldn't sync its progress to the
        // server (see `syncReadingProgress`) -- now that a fetch just
        // succeeded, retry it.
        await flushPendingProgress(_manga);
      }
      _syncSelectedSource();
    } catch (e) {
      if (downloadsSupported && mode == _RefreshMode.cached) {
        final offline = await loadOfflineManga(_manga.id);
        if (offline != null) {
          _manga = offline;
          _syncSelectedSource();
          return;
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

  /// Chapter count of this manga's last finished download, `0` for a
  /// download that never finished, or `null` if it isn't downloaded.
  int? _downloadedChapters;

  /// Whether this manga has a download to export.
  bool get _isDownloaded => _downloadedChapters != null;

  StreamSubscription<void>? _downloadCompleted;

  Future<void> _refreshDownloaded() async {
    if (!downloadsSupported) return;
    final downloaded = await loadDownloadedChapterCount(_manga.id, _selectedSource.id);
    if (mounted && downloaded != _downloadedChapters) setState(() => _downloadedChapters = downloaded);
  }

  @override
  void initState() {
    _manga = widget.manga;
    _syncSelectedSource();

    loadManga();
    _refreshDownloaded();
    _downloadCompleted = downloadManager.completed
        .where((task) => task.manga.id == _manga.id)
        .listen((_) => _refreshDownloaded());

    super.initState();
  }

  static const _wideBreakpoint = 900.0;

  double _toolbarHeight(BuildContext context) {
    final theme = Theme.of(context);
    return theme.appBarTheme.toolbarHeight ?? (theme.useMaterial3 ? 64.0 : kToolbarHeight);
  }

  /// "Download" when not downloaded yet, disabled while queued or once the
  /// last finished download already has every chapter, and "Update
  /// download" when new chapters came out or an earlier download didn't
  /// finish -- re-running a download skips every page already on disk.
  PopupMenuItem<_MangaMenuAction> _downloadMenuItem() {
    final downloaded = _downloadedChapters;
    final (key, enabled) = switch (downloaded) {
      _ when downloadManager.taskFor(_manga.id) != null => ('manga.downloading', false),
      null => ('manga.download', true),
      _ when downloaded >= _shown.countChapters.toInt() => ('manga.downloaded', false),
      _ => ('manga.update-download', true),
    };
    return PopupMenuItem(value: _MangaMenuAction.download, enabled: enabled, child: Text(FlutterI18n.translate(context, key)));
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      OpenURLAction(url: _selectedSource.url),
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
                    .map((t) => SimpleDialogOption(onPressed: () => Navigator.of(ctx).pop(t), child: Text(t)))
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
            downloadManager.enqueue(context, _shown, _selectedSource).then((_) => _refreshDownloaded());
          } else if (action == _MangaMenuAction.exportCbz) {
            exportMangaCbz(context, _manga.id, sourceId: _selectedSource.id);
          } else if (action == _MangaMenuAction.forceRescrape) {
            loadManga(mode: _RefreshMode.forceRescrape);
          } else if (action == _MangaMenuAction.mergeInto) {
            _mergeInto();
          } else if (action == _MangaMenuAction.mergeFrom) {
            _mergeFrom();
          } else if (action == _MangaMenuAction.manageSources) {
            _manageSources();
          } else if (action == _MangaMenuAction.moveSourceOut) {
            _moveSourceOut();
          } else if (action == _MangaMenuAction.moveSourceIn) {
            _moveSourceIn();
          } else if (action == _MangaMenuAction.toggleNsfw) {
            _toggleNsfw();
          } else if (action == _MangaMenuAction.deleteManga) {
            _deleteManga();
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(value: _MangaMenuAction.addSource, child: Text(FlutterI18n.translate(context, 'manga.add-source'))),
          PopupMenuItem(
            value: _MangaMenuAction.addSourceFromUrl,
            child: Text(FlutterI18n.translate(context, 'manga.add-source-url')),
          ),
          if (downloadsSupported) _downloadMenuItem(),
          if (_isDownloaded)
            PopupMenuItem(value: _MangaMenuAction.exportCbz, child: Text(FlutterI18n.translate(context, 'downloads.export_cbz'))),
          if (API.loggedIn.isAdmin)
            PopupMenuItem(
              value: _MangaMenuAction.forceRescrape,
              child: Text(FlutterI18n.translate(context, 'manga.force-rescrape')),
            ),
          if (API.loggedIn.isAdmin)
            PopupMenuItem(value: _MangaMenuAction.mergeInto, child: Text(FlutterI18n.translate(context, 'manga.merge-into'))),
          if (API.loggedIn.isAdmin)
            PopupMenuItem(value: _MangaMenuAction.mergeFrom, child: Text(FlutterI18n.translate(context, 'manga.merge-from'))),
          if (API.loggedIn.isAdmin && _manga.sources.isNotEmpty)
            PopupMenuItem(
              value: _MangaMenuAction.manageSources,
              child: Text(FlutterI18n.translate(context, 'manga.manage-sources')),
            ),
          if (API.loggedIn.isAdmin && _manga.sources.isNotEmpty)
            PopupMenuItem(
              value: _MangaMenuAction.moveSourceOut,
              child: Text(FlutterI18n.translate(context, 'manga.move-source-out')),
            ),
          if (API.loggedIn.isAdmin)
            PopupMenuItem(
              value: _MangaMenuAction.moveSourceIn,
              child: Text(FlutterI18n.translate(context, 'manga.move-source-in')),
            ),
          if (API.loggedIn.isModOrAdmin)
            PopupMenuItem(
              value: _MangaMenuAction.toggleNsfw,
              child: Text(FlutterI18n.translate(context, _manga.nsfw ? 'manga.unmark-nsfw' : 'manga.mark-nsfw')),
            ),
          if (API.loggedIn.isModOrAdmin)
            PopupMenuItem(
              value: _MangaMenuAction.deleteManga,
              child: Text(FlutterI18n.translate(context, 'manga.delete'), style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
    ];
  }

  Widget _coverImage({BoxFit fit = BoxFit.fitWidth}) {
    return Visibility(
      visible: _shown.hasCover(),
      child: Hero(
        tag: widget.heroTag ?? widget.type.getTag(_manga.id.toString()),
        child: CachedNetworkImage(
          imageUrl: _shown.cover,
          fit: fit,
          errorWidget: (context, url, error) => const ImageErrorPlaceholder(),
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
            title: Text(
              _shown.title.replaceAll('\n', ' '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white70),
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
                child: Column(children: [MangaDetails(manga: _shown), CommentsPreview(mangaId: _manga.id)]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWideBody(BuildContext context) {
    return Column(
      children: [
        AppBar(actions: _appBarActions(context)),
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
                          Text(_shown.title.replaceAll('\n', ' '), style: Theme.of(context).textTheme.headlineSmall),
                          if (_shown.altTitles.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _shown.altTitles.join(' · '),
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
                      child: Column(
                        children: [MangaDetails(manga: _shown, showTitle: false), CommentsPreview(mangaId: _manga.id)],
                      ),
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
          body: Stack(
            children: [
              SelectionArea(child: isWide ? _buildWideBody(context) : _buildNarrowBody(context)),
              if (_manga.sources.isNotEmpty)
                Positioned.fill(
                  child: SourceBadge(
                    mangaId: _manga.id,
                    sources: _manga.sources.toList(),
                    selected: _selectedSource,
                    onSelected: _selectSource,
                    onSourcesChanged: loadManga,
                    top: _toolbarHeight(context),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: _animationController.isAnimating
              ? null
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isInReadingList(_manga))
                        NewMangaOptions(
                          manga: _manga,
                          refreshParent: () {
                            setState(() {});
                          },
                        ),
                      ChapterSelector(
                        manga: _manga,
                        source: _selectedSource,
                        refreshParent: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _downloadCompleted?.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
