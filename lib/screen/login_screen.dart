import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/constant.dart';
import 'package:wuxia/gen/user.pb.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fkLogin = GlobalKey<FormState>();
  final uController = TextEditingController();
  final eController = TextEditingController();
  final pController = TextEditingController();
  final cController = TextEditingController();
  bool isLogin = true;

  String? error;

  @override
  void initState() {
    if (isLogin) {
      SharedPreferences.getInstance().then((instance) async {
        final uname = instance.getString('username');
        uController.text = uname ?? '';
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    uController.dispose();
    eController.dispose();
    pController.dispose();
    cController.dispose();
    super.dispose();
  }

  void login() async {
    final invalid = !fkLogin.currentState!.validate();
    if (invalid) {
      return;
    }

    final username = uController.text;
    final password = pController.text;

    try {
      final user = await api.user.login(UserRequest(
        username: username,
        password: password,
      ));
      SharedPreferences.getInstance().then((instance) => instance.setString('username', username));

      API.token = user.token;
      await const FlutterSecureStorage().write(key: 'token', value: user.token);

      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('root_nav');
    } catch (e) {
      if (e is GrpcError) {
        error = e.message;
      }

      setState(() {
        pController.text = '';
      });
    }
  }

  void register() async {
    final invalid = !fkLogin.currentState!.validate();
    if (invalid) {
      return;
    }

    final String username = uController.text;
    final String email = eController.text;
    final String password = pController.text;
    final String confirmPassword = cController.text;

    if (password != confirmPassword) {
      error = FlutterI18n.translate(context, 'login.password_not_match');
      setState(() {});
    }

    try {
      await api.user.register(UserRegisterRequest(
        username: username,
        email: email,
        password: password,
      ));
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('root_nav');
    } catch (e) {
      if (e is GrpcError) {
        setState(() {
          error = e.message;
        });
      }
    }
  }

  String? requiredField(String? value) {
    return value != null && value.isNotEmpty ? null : 'This field is required';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      FlutterI18n.translate(context, isLogin ? 'login.welcome' : 'login.sign_up'),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Form(
                      key: fkLogin,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: requiredField,
                            controller: uController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              label: I18nText('login.username'),
                            ),
                          ),
                          ...(isLogin
                              ? []
                              : [
                                  const SizedBox(
                                    height: Constants.padding,
                                  ),
                                  TextFormField(
                                    validator: requiredField,
                                    controller: eController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      label: I18nText('login.email'),
                                    ),
                                  ),
                                ]),
                          const SizedBox(height: Constants.padding),
                          TextFormField(
                            obscureText: true,
                            validator: requiredField,
                            textInputAction: isLogin ? TextInputAction.done : TextInputAction.next,
                            onFieldSubmitted: (password) => login(),
                            controller: pController,
                            decoration: InputDecoration(
                              label: I18nText('login.password'),
                            ),
                          ),
                          ...(isLogin
                              ? []
                              : [
                                  const SizedBox(height: Constants.padding),
                                  TextFormField(
                                    validator: requiredField,
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (password) => register(),
                                    controller: cController,
                                    decoration: InputDecoration(
                                      label: I18nText('login.confirm_password'),
                                    ),
                                  )
                                ]),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FlutterI18n.translate(context, isLogin ? 'login.title' : 'login.sign_up'),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                CircleAvatar(
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: isLogin ? login : register,
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => isLogin = !isLogin),
                        style: const ButtonStyle(),
                        child: Text(
                          FlutterI18n.translate(context, isLogin ? 'login.sign_up' : 'login.title'),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
