import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wuxia/firebase_options.dart';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/screen/login_screen.dart';
import 'package:wuxia/screen/manga/manga_chapter_route_loader.dart';
import 'package:wuxia/screen/manga/manga_route_loader.dart';
import 'package:wuxia/screen/root_nav_screen.dart' hide Route;
import 'package:wuxia/screen/setting/scraper_status_screen.dart';
import 'package:wuxia/screen/setting/statistics_screen.dart';
import 'package:wuxia/screen/settings_screen.dart';
import 'package:wuxia/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/store.dart';

extension ReadingManga on MangaReply {
  double get progressPercentage {
    final count = countChapters.toInt();
    if (count.isNaN || count == 0) {
      return 0.0;
    }
    return 1 / count * readingProgress;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Handling a background message: ${message.messageId}');
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: '.env');
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSize = 1000;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;
  final store = await Store.init();
  await Jiffy.setLocale(store.getLanguage() ?? 'en');

  runApp(const WuxiaApp());
}

class WuxiaApp extends StatefulWidget {
  const WuxiaApp({super.key});

  @override
  State<WuxiaApp> createState() => _WuxiaAppState();
}

class _WuxiaAppState extends State<WuxiaApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = Store.getStoreInstance();
    final namedRoutes = <String, WidgetBuilder>{
      'login': (context) => const LoginScreen(),
      'root_nav': (context) => const RootNavScreen(),
      'settings': (context) => const SettingsScreen(),
      'statistics': (context) => const StatisticsScreen(),
      'scraper_status': (context) => const ScraperStatusScreen(),
    };

    // Reconstructs the manga detail / chapter reader screens from just a
    // URL -- reached on a page refresh or a deep link, where (unlike a
    // normal in-app Navigator.push) there's no already-loaded object to
    // pass in, only whatever survived in the URL.
    Route<dynamic>? generateDynamicRoute(RouteSettings settings) {
      final name = settings.name ?? '';

      final chapterMatch = matchChapterRoute(name);
      if (chapterMatch != null) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MangaChapterRouteLoader(
            mangaId: chapterMatch.mangaId,
            sourceId: chapterMatch.sourceId,
            chapterIndex: chapterMatch.chapterIndex,
          ),
        );
      }

      final mangaMatch = matchMangaRoute(name);
      if (mangaMatch != null) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MangaRouteLoader(mangaId: mangaMatch.mangaId),
        );
      }

      return null;
    }

    return MaterialApp(
      title: '武俠',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // On web, Flutter otherwise boots straight into whatever route is in the
      // address bar (e.g. a refresh on #settings), skipping SplashScreen --
      // the only place that restores the session and populates API.loggedIn.
      initialRoute: '/',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {...const MaterialScrollBehavior().dragDevices, PointerDeviceKind.mouse},
      ),
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            fallbackFile: 'en',
            useCountryCode: false,
            useScriptCode: false,
            forcedLocale: Locale(store.getLanguage() ?? 'en'),
          ),
          missingTranslationHandler: (key, locale) {
            print('"$key" not found in ${locale?.languageCode}.yaml');
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: Locale(store.getLanguage() ?? 'en'),
      // MaterialApp.builder's `child` already contains the Navigator (and its
      // Overlay), so SelectionArea would sit as the Navigator's *parent* --
      // an Overlay ancestor of its own is required, hence the nested Overlay.
      builder: (context, child) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => SelectionArea(
              child: FlutterI18n.rootAppBuilder()(context, child),
            ),
          ),
        ],
      ),
      routes: namedRoutes,
      onGenerateRoute: generateDynamicRoute,
      // A page refresh or deep link landing directly on a manga/chapter page
      // otherwise starts with just that one route and nothing beneath it --
      // stranding the user with no way back. Seed root_nav underneath it so
      // back navigation (and the in-app back arrow) has somewhere to go.
      onGenerateInitialRoutes: (initialRouteName) {
        final isDeepLink = matchMangaRoute(initialRouteName) != null || matchChapterRoute(initialRouteName) != null;
        if (!isDeepLink) {
          final builder = initialRouteName == Navigator.defaultRouteName
              ? (BuildContext context) => const SplashScreen()
              : namedRoutes[initialRouteName];
          final settings = RouteSettings(name: initialRouteName);
          final route =
              builder != null ? MaterialPageRoute(settings: settings, builder: builder) : generateDynamicRoute(settings);
          return [if (route != null) route];
        }

        final rootRoute = MaterialPageRoute(
          settings: const RouteSettings(name: 'root_nav'),
          // This instance is seeded offstage from frame one (it's never the
          // visible route) so its text never actually gets laid out --
          // opt it out of the app-wide SelectionArea, which otherwise
          // crashes trying to compute a selection order over an unlaid-out
          // RenderParagraph. The normal in-app RootNavScreen (reached via
          // Splash) is visible before ever being buried, so it doesn't hit
          // this and keeps working as a normal SelectionArea participant.
          builder: (context) => const SelectionContainer.disabled(child: RootNavScreen()),
        );
        final targetRoute = generateDynamicRoute(RouteSettings(name: initialRouteName));

        return [rootRoute, if (targetRoute != null) targetRoute];
      },
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.pink,
        ),
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: Colors.transparent,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(left: 4.0, top: 12.0, bottom: 12.0),
        ),
      ),
      themeAnimationCurve: Curves.bounceInOut,
    );
  }
}
