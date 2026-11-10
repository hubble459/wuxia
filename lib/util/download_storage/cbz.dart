import 'dart:convert';
import 'dart:typed_data';

/// Builds the headers of an uncompressed (method 0) ZIP -- page images are
/// already compressed, and storing them lets callers stream each entry's
/// data straight from disk next to these headers. No ZIP64, so the archive
/// is capped at 4 GiB / 65535 entries.
class StoredZipBuilder {
  final BytesBuilder _central = BytesBuilder(copy: false);
  int _offset = 0;
  int _count = 0;

  static const _utf8Flag = 0x0800;

  /// 1980-01-01, the earliest valid DOS date (all-zero is an invalid month).
  static const _dosDate = (1 << 5) | 1;

  /// The local header to write right before an entry's [size] bytes of data.
  Uint8List add(String name, int size, int crc) {
    final nameBytes = utf8.encode(name);
    if (_offset + 30 + nameBytes.length + size > 0xFFFFFFFF || _count + 1 > 0xFFFF) {
      throw StateError('Too large to export as a single CBZ (over 4 GiB or 65535 pages)');
    }

    final local = ByteData(30)
      ..setUint32(0, 0x04034b50, Endian.little)
      ..setUint16(4, 20, Endian.little)
      ..setUint16(6, _utf8Flag, Endian.little)
      ..setUint16(12, _dosDate, Endian.little)
      ..setUint32(14, crc, Endian.little)
      ..setUint32(18, size, Endian.little)
      ..setUint32(22, size, Endian.little)
      ..setUint16(26, nameBytes.length, Endian.little);
    final central = ByteData(46)
      ..setUint32(0, 0x02014b50, Endian.little)
      ..setUint16(4, 20, Endian.little)
      ..setUint16(6, 20, Endian.little)
      ..setUint16(8, _utf8Flag, Endian.little)
      ..setUint16(14, _dosDate, Endian.little)
      ..setUint32(16, crc, Endian.little)
      ..setUint32(20, size, Endian.little)
      ..setUint32(24, size, Endian.little)
      ..setUint16(28, nameBytes.length, Endian.little)
      ..setUint32(42, _offset, Endian.little);
    _central
      ..add(central.buffer.asUint8List())
      ..add(nameBytes);

    _offset += 30 + nameBytes.length + size;
    _count++;
    return (BytesBuilder(copy: false)
          ..add(local.buffer.asUint8List())
          ..add(nameBytes))
        .takeBytes();
  }

  /// The central directory and end record, written after every entry.
  Uint8List finish() {
    final central = _central.takeBytes();
    final end = ByteData(22)
      ..setUint32(0, 0x06054b50, Endian.little)
      ..setUint16(8, _count, Endian.little)
      ..setUint16(10, _count, Endian.little)
      ..setUint32(12, central.length, Endian.little)
      ..setUint32(16, _offset, Endian.little);
    return (BytesBuilder(copy: false)
          ..add(central)
          ..add(end.buffer.asUint8List()))
        .takeBytes();
  }
}

/// Chapter folders in reading order.
List<String> sortChapterFolders(List<String> folders) =>
    folders..sort((a, b) => (double.tryParse(a) ?? 0).compareTo(double.tryParse(b) ?? 0));

/// Zero-padded `<chapter>/<page>.<ext>` so every comic reader's plain
/// string sort matches reading order.
String cbzEntryName(String chapterFolder, String pageFile, int pageIndex) {
  final chapterParts = chapterFolder.split('.');
  final chapter = [chapterParts.first.padLeft(4, '0'), ...chapterParts.skip(1)].join('.');
  final dot = pageFile.lastIndexOf('.');
  final ext = dot == -1 ? '' : pageFile.substring(dot);
  return '$chapter/${pageIndex.toString().padLeft(4, '0')}$ext';
}

final _crcTable = List<int>.generate(256, (n) {
  var c = n;
  for (var k = 0; k < 8; k++) {
    c = (c & 1) != 0 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
  }
  return c;
});

int crc32(Uint8List bytes) {
  var crc = 0xFFFFFFFF;
  for (final b in bytes) {
    crc = _crcTable[(crc ^ b) & 0xFF] ^ (crc >>> 8);
  }
  return (crc ^ 0xFFFFFFFF) & 0xFFFFFFFF;
}
