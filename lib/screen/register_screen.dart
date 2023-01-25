import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final uController = TextEditingController();
  final pController = TextEditingController();
  final cController = TextEditingController();
  String? uError;
  String? pError;
  String? cError;

  @override
  void dispose() {
    uController.dispose();
    pController.dispose();
    cController.dispose();
    super.dispose();
  }

  void _register() async {
    uError = null;
    pError = null;
    cError = null;
    final String username = uController.text;
    final String password = pController.text;
    final String confirmPassword = cController.text;
    if (password != confirmPassword) {
      cError = FlutterI18n.translate(context, 'login.password_not_match');
      setState(() {});
    }

    try {
      await api.register(username: username, password: password);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('root_nav');
    } catch (e) {
      final dynamic errorJson = e;
      uError = errorJson['username'];
      pError = errorJson['password'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child: Text(
                FlutterI18n.translate(context, 'login.sign_up'),
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: uController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              errorText: uError,
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: FlutterI18n.translate(context, 'login.username'),
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          controller: pController,
                          decoration: InputDecoration(
                              errorText: pError,
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: FlutterI18n.translate(context, 'login.password'),
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (password) => _register(),
                          controller: cController,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              errorText: cError,
                              hintText: FlutterI18n.translate(context, 'login.confirm_password'),
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FlutterI18n.translate(context, 'login.sign_up'),
                              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: _register,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            style: const ButtonStyle(),
                            child: Text(
                              FlutterI18n.translate(context, 'login.title'),
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(decoration: TextDecoration.underline, color: Color(0xff4c505b), fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
