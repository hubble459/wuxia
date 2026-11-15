import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/util/tools.dart';

ChapterReply _chapter(double number, int index) => ChapterReply(id: index, number: number, index: Int64(index));

void main() {
  group('mergeDownloadedChapters', () {
    test('keeps a downloaded chapter the server no longer lists', () {
      final previous = [_chapter(1, 1), _chapter(2, 2), _chapter(3, 3)];
      final server = [_chapter(1, 1), _chapter(3, 2), _chapter(4, 3)];

      final merged = mergeDownloadedChapters(server, previous, {'1', '2', '3'});

      expect(merged.map((c) => c.number), [1, 2, 3, 4]);
      final kept = merged.firstWhere((c) => c.number == 2);
      expect(kept.index, Int64(2), reason: 'a kept chapter keeps its index');
      expect(kept.id, 2);
    });

    test('drops a chapter the server no longer lists when its pages are not on disk', () {
      final merged = mergeDownloadedChapters([_chapter(1, 1)], [_chapter(1, 1), _chapter(2, 2)], {'1'});

      expect(merged.map((c) => c.number), [1]);
    });

    test('the server copy wins when both have a chapter number', () {
      final merged = mergeDownloadedChapters([_chapter(2.5, 7)], [_chapter(2.5, 3)], {'2.5'});

      expect(merged.single.index, Int64(7));
    });

    test('keeps a removed chapter only once', () {
      final merged = mergeDownloadedChapters([], [_chapter(5, 1), _chapter(5, 2)], {'5'});

      expect(merged, hasLength(1));
    });
  });

  group('finished chapters', () {
    test('round-trip through the file contents', () {
      final folders = {'1', '2.5', '10'};

      expect(decodeFinishedChapters(encodeFinishedChapters(folders)), folders);
    });

    test('ignore blank lines', () {
      expect(decodeFinishedChapters(Uint8List.fromList('1\n\n2\n'.codeUnits)), {'1', '2'});
    });

    test('an empty list decodes to nothing', () {
      expect(decodeFinishedChapters(encodeFinishedChapters(const [])), isEmpty);
    });
  });
}
