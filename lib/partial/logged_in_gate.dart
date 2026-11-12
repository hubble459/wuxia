import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart' show GrpcError;
import 'package:wuxia/api.dart';
import 'package:wuxia/util/session.dart';

/// Builds [builder] once a session is restored. A web deep link can land on a screen directly,
/// skipping the screens that normally restore credentials before anything reads API.loggedIn.
class LoggedInGate extends StatefulWidget {
  final WidgetBuilder builder;

  const LoggedInGate({super.key, required this.builder});

  @override
  State<LoggedInGate> createState() => _LoggedInGateState();
}

class _LoggedInGateState extends State<LoggedInGate> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await restoreSession();
    if (!mounted) return;

    if (!API.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return widget.builder(context);
  }
}

/// A gRPC error's own message, for showing to the user.
String errorMessage(Object error) => error is GrpcError ? (error.message ?? error.codeName) : '$error';

void showErrorSnackBar(BuildContext context, Object error) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage(error))));
}
