import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _connecting = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() {
        _connecting = true;
      });
      await Jiffy.setLocale('en');
      await FlutterI18n.refresh(context, Locale('en'));

      final preferences = await SharedPreferences.getInstance();
      final apiURL = preferences.getString('api_host');
      if (apiURL != null && api.getApiURL() != apiURL) {
        final apiURLParts = apiURL.split(':');
        final host = apiURLParts[0];
        final port = int.parse(apiURLParts[1]);
        api = API(host, port);
      }

      final abi = Abi.current();
      switch (abi) {
        case Abi.androidArm:
          break;
        default:
      }

      const storage = FlutterSecureStorage();

      try {
        final token = await storage.read(key: 'token');
        API.token = token;
        API.loggedIn = await api.user.me(Empty());
        if (!mounted) return;
        final locale = preferences.getString('language') ?? 'zh';
        await Jiffy.setLocale(locale);
        await FlutterI18n.refresh(context, Locale(locale));
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('root_nav');
      } catch (e) {
        storage.delete(key: 'token').ignore();
        API.token = null;

        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Image.asset('assets/image/icon.png', height: 200),
        child: Column(
          children: [
            Text(
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
            Visibility(
              visible: _connecting,
              child: Text('Connecting with server...'),
            )
          ],
        ),
      ),
    );
  }
}
