import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wuxia/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/screen/login_screen.dart';
import 'package:wuxia/screen/root_nav_screen.dart';
import 'package:wuxia/screen/setting/statistics_screen.dart';
import 'package:wuxia/screen/settings_screen.dart';
import 'package:wuxia/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wuxia/util/store.dart';

extension ReadingManga on MangaReply {
  get progressPercentage {
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
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp();

    print('Handling a background message: ${message.messageId}');
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: '.env');
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Store.init();
  runApp(const WuxiaApp());
}

class WuxiaApp extends StatefulWidget {
  const WuxiaApp({Key? key}) : super(key: key);

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
    return MaterialApp(
      title: '武俠',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            fallbackFile: 'en',
            useCountryCode: false,
            useScriptCode: false,
          ),
          missingTranslationHandler: (key, locale) {
            log('"$key" not found in ${locale?.languageCode}.yaml');
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      builder: FlutterI18n.rootAppBuilder(),
      home: const SplashScreen(),
      routes: {
        'login': (context) => const LoginScreen(),
        'root_nav': (context) => const RootNavScreen(),
        'settings': (context) => const SettingsScreen(),
        'statistics': (context) => const StatisticsScreen(),
      },
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
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
        ),
      ),
      themeAnimationCurve: Curves.bounceInOut,
    );
  }
}
