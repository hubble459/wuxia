import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/constant.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/partial/dialog/change_host_dialog.dart';
import 'package:wuxia/util/validator_builder.dart';

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
    super.dispose();
  }

  void submit() async {
    error = null;
    final invalid = !fkLogin.currentState!.validate();

    if (invalid) {
      return;
    }

    try {
      UserTokenReply user;
      if (isLogin) {
        user = await login();
      } else {
        user = await register();
      }

      API.token = user.token;
      API.loggedIn = user.user;

      // Asynchronously save username and token
      (() async {
        const FlutterSecureStorage().write(key: 'token', value: user.token).ignore();
        final instance = await SharedPreferences.getInstance();
        instance.setString('username', user.user.username);
      })();

      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('root_nav');
    } catch (e) {
      if (e is GrpcError) {
        print(e);
        setState(() {
          error = e.message ?? e.codeName;
        });
      }
    }
  }

  ResponseFuture<UserTokenReply> login() {
    return api.user.login(UserRequest(
      username: uController.text,
      password: pController.text,
    ));
  }

  ResponseFuture<UserTokenReply> register() {
    return api.user.register(UserRegisterRequest(
      username: uController.text,
      email: eController.text,
      password: pController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.api),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ChangeAPIDialog(),
                );
              },
            )
          ],
        ),
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
                    ...(error != null
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                error!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )
                          ]
                        : []),
                    Form(
                      key: fkLogin,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: ValidatorBuilder.translate(context, 'login.username')
                                .required()
                                .minLength(3)
                                .maxLength(20)
                                .build(),
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
                                    validator: ValidatorBuilder.translate(context, 'login.email').required().isEmail().build(),
                                    controller: eController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      label: I18nText('login.email'),
                                    ),
                                  ),
                                ]),
                          const SizedBox(height: Constants.padding),
                          TextFormField(
                            obscureText: true,
                            validator: ValidatorBuilder.translate(context, 'login.password')
                                .required()
                                .minLength(3)
                                .maxLength(255)
                                .hasNumber()
                                .hasSpecialCharacter()
                                .hasUppercase()
                                .hasLowercase()
                                .build(),
                            textInputAction: isLogin ? TextInputAction.done : TextInputAction.next,
                            onFieldSubmitted: (password) => submit(),
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
                                    validator: ValidatorBuilder.translate(context, 'login.confirm_password')
                                        .required()
                                        .custom((value) => value == pController.text
                                            ? null
                                            : FlutterI18n.translate(context, 'validator.password_not_match'))
                                        .build(),
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (password) => submit(),
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
                                    onPressed: submit,
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
                        onPressed: () => setState(() {
                          error = null;
                          isLogin = !isLogin;
                        }),
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
