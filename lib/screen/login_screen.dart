import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/user.pb.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final uController = TextEditingController();
  final pController = TextEditingController();

  String? uError;
  String? pError;

  @override
  void initState() {
    SharedPreferences.getInstance().then((instance) async {
      final uname = instance.getString('username');
      uController.text = uname ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    uController.dispose();
    pController.dispose();
    super.dispose();
  }

  void _login() async {
    final instance = await SharedPreferences.getInstance();
    final String username = uController.text;
    final String password = pController.text;
    instance.setString('username', username);
    try {
      final user = await api.user.login(UserRequest(
        username: username,
        password: password,
      ));
      API.token = user.token;
      await const FlutterSecureStorage().write(key: 'token', value: user.token);

      print(user.token);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('root_nav');
    } catch (e) {
      if (e is GrpcError) {
        pError = e.message;
      }

      setState(() {
        pController.text = '';
      });
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
                FlutterI18n.translate(context, 'login.welcome'),
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
                          textInputAction: TextInputAction.done,
                          onSubmitted: (password) => _login(),
                          controller: pController,
                          decoration: InputDecoration(
                              errorText: pError,
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: FlutterI18n.translate(
                                context,
                                'login.password',
                              ),
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
                              FlutterI18n.translate(context, 'login.title'),
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: _login,
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, 'register');
                            },
                            style: const ButtonStyle(),
                            child: Text(
                              FlutterI18n.translate(context, 'login.sign_up'),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
