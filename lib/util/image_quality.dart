/// Reader page quality. Capped by width (rumgap's `?maxwidth=`) so long-strip pages keep a
/// readable width instead of being shrunk until their height fits.
enum ImageQuality {
  original(null, null),
  high(1440, 85),
  medium(1080, 75),
  low(720, 60);

  const ImageQuality(this.maxWidth, this.quality);

  final int? maxWidth;
  final int? quality;

  /// [url] with this quality's cap added, keeping the signed query params already on it.
  String apply(String url) {
    if (maxWidth == null) return url;
    final uri = Uri.parse(url);
    return uri.replace(queryParameters: {...uri.queryParameters, 'maxwidth': '$maxWidth', 'quality': '$quality'}).toString();
  }

  static ImageQuality? fromName(String? name) => values.where((quality) => quality.name == name).firstOrNull;
}
