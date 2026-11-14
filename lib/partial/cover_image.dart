import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/image_error_placeholder.dart';
import 'package:wuxia/util/tools.dart';

/// [manga]'s cover from the network (through the image cache). When that
/// fails -- e.g. offline with the image no longer cached -- shows the cover
/// saved with its download instead, if there is one.
class CoverImage extends StatelessWidget {
  final MangaReply manga;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool useOldImageOnUrlChange;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  const CoverImage({
    super.key,
    required this.manga,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.useOldImageOnUrlChange = false,
    this.progressIndicatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: manga.cover,
      fit: fit,
      width: width,
      height: height,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      progressIndicatorBuilder: progressIndicatorBuilder,
      errorListener: (_) {},
      errorWidget: (context, url, error) => _DownloadedCover(mangaId: manga.id, fit: fit, width: width, height: height),
    );
  }
}

class _DownloadedCover extends StatefulWidget {
  final int mangaId;
  final BoxFit fit;
  final double? width;
  final double? height;

  const _DownloadedCover({required this.mangaId, required this.fit, this.width, this.height});

  @override
  State<_DownloadedCover> createState() => _DownloadedCoverState();
}

class _DownloadedCoverState extends State<_DownloadedCover> {
  late Future<Uint8List?> _bytes = loadDownloadedCover(widget.mangaId);

  @override
  void didUpdateWidget(_DownloadedCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mangaId != widget.mangaId) _bytes = loadDownloadedCover(widget.mangaId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _bytes,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes != null) {
          return Image.memory(
            bytes,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            errorBuilder: (context, error, stack) => const ImageErrorPlaceholder(),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) return SizedBox(width: widget.width, height: widget.height);
        return const ImageErrorPlaceholder();
      },
    );
  }
}
