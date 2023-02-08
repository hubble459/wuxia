import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap.pb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      final preferences = await SharedPreferences.getInstance();
      final apiURL = preferences.getString('api_host');
      if (apiURL != null && api.getApiURL() != apiURL) {
        final apiURLParts = apiURL.split(':');
        final host = apiURLParts[0];
        final port = int.parse(apiURLParts[1]);
        api = API(host, port);
      }

      final abi = Abi.current();
      abi == Abi

      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      try {
        API.token = token;
        API.loggedIn = await api.user.me(Empty());
        if (!mounted) return;
        final locale = preferences.getString('language') ?? 'zh';
        await Jiffy.locale(locale);
        if (!mounted) return;
        FlutterI18n.refresh(context, Locale(locale));
        Navigator.of(context).pushReplacementNamed('root_nav');
      } catch (e) {
        await storage.delete(key: 'token');
        API.token = null;

        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('login');
      }
    });

    return Scaffold(
      body: Center(
        // child: Image.asset('assets/image/icon.png', height: 200),
        child: Text(
          FlutterI18n.translate(context, 'title'),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                offset: Offset(5.0, 5.0),
                blurRadius: 2.0,
                color: Colors.grey,
              ),
            ],
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
