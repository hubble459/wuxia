import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/util/session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _connecting = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() => _connecting = true);
    await restoreSession();

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(API.isLoggedIn ? 'root_nav' : 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              child: I18nText('splash.connecting'),
            )
          ],
        ),
      ),
    );
  }
}
