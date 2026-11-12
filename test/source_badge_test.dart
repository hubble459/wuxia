import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/partial/source_badge.dart';

MangaSourceReply _source(int id, String hostname, String title, {bool primary = false}) => MangaSourceReply(
  id: id,
  hostname: hostname,
  language: 'en',
  title: title,
  countChapters: Int64(100 + id),
  isPrimary: primary,
);

void main() {
  final sources = [
    _source(1, 'roliascan.com', 'The Greatest Estate Developer', primary: true),
    _source(2, 'www.mangaread.org', "The World's Best Engineer"),
    _source(3, 'mangadex.org', 'Yeokdaegeum Yeongji Seolgyesa'),
  ];

  Future<void> pump(WidgetTester tester, {required List<MangaSourceReply> picked}) async {
    API.loggedIn = UserFullReply(permissions: 0x4);
    await tester.binding.setSurfaceSize(const Size(400, 700));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [FlutterI18nDelegate(translationLoader: FileTranslationLoader(fallbackFile: 'en'))],
        home: Scaffold(
          appBar: AppBar(title: const Text('Manga')),
          body: Stack(
            children: [
              const Placeholder(),
              Positioned.fill(
                child: SourceBadge(
                  mangaId: 1,
                  sources: sources,
                  selected: sources[0],
                  onSelected: picked.add,
                  onSourcesChanged: () {},
                  top: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('unfolds, picks a source and folds back up', (tester) async {
    final picked = <MangaSourceReply>[];
    await pump(tester, picked: picked);
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/source_badge_closed.png'));
    expect(find.text('www.mangaread.org (en)'), findsNothing);

    await tester.tap(find.text('roliascan.com'));
    await tester.pumpAndSettle();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/source_badge_open.png'));
    expect(find.text("The World's Best Engineer"), findsOneWidget);

    await tester.tap(find.text('www.mangaread.org (en)'));
    await tester.pumpAndSettle();
    expect(picked.single.id, 2);
    expect(find.text('www.mangaread.org (en)'), findsNothing);
    // Opening the list asks the server which sites are down; let that request time out.
    await tester.pump(const Duration(seconds: 30));
  });

  testWidgets('a tap outside closes it without picking', (tester) async {
    final picked = <MangaSourceReply>[];
    await pump(tester, picked: picked);
    await tester.tap(find.text('roliascan.com'));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(40, 600));
    await tester.pumpAndSettle();

    expect(picked, isEmpty);
    expect(find.text('mangadex.org (en)'), findsNothing);
    await tester.pump(const Duration(seconds: 30));
  });
}
