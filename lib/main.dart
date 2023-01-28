import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/screen/login_screen.dart';
import 'package:wuxia/screen/register_screen.dart';
import 'package:wuxia/screen/root_nav_screen.dart';
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
        'register': (context) => const RegisterScreen(),
        'root_nav': (context) => const RootNavScreen(),
        'settings': (context) => const SettingsScreen(),
      },
      themeMode: ThemeMode.dark,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          cardColor: Colors.white,
          accentColor: Colors.tealAccent,
          backgroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.black87,
          cardColor: Colors.black12,
          brightness: Brightness.dark,
          primaryColorDark: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
