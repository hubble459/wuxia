import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/screen/login_screen.dart';
import 'package:wuxia/screen/root_nav_screen.dart';
import 'package:wuxia/screen/setting/statistics_screen.dart';
import 'package:wuxia/screen/settings_screen.dart';
import 'package:wuxia/screen/splash_screen.dart';

extension ReadingManga on MangaReply {
  get progressPercentage {
    final count = countChapters.toInt();
    return 1 / count * readingProgress;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '武俠',
      debugShowCheckedModeBanner: false,
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
