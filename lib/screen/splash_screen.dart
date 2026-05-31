import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/util/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _connecting = false;

  void setupAPI() {
    final store = Store.getStoreInstance();
    final apiURL = store.getApiHost();
    if (apiURL != null && api.getApiURL() != apiURL) {
      final apiURLParts = apiURL.split(':');
      final host = apiURLParts[0];
      final port = int.parse(apiURLParts[1]);
      api = API(host, port);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setupAPI();

    final store = Store.getStoreInstance();
    final token = await store.readToken();

    if (token == null) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    setState(() => _connecting = true);

    API.token = token;
    try {
      API.loggedIn = await api.user.me(Empty());
    } catch (e) {
      if (e is GrpcError && e.code == StatusCode.unauthenticated) {
        await store.removeToken();
        API.token = null;
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('login');
        return;
      }
      // Network error — continue offline with empty user
      API.loggedIn = UserFullReply();
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('root_nav');
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
