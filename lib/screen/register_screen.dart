// import 'package:flutter/material.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';
// import 'package:grpc/grpc.dart';
// import 'package:wuxia/api.dart';
// import 'package:wuxia/constant.dart';
// import 'package:wuxia/gen/user.pb.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final uController = TextEditingController();
//   final eController = TextEditingController();
//   final pController = TextEditingController();
//   final cController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void register() async {
//     final String username = uController.text;
//     final String email = eController.text;
//     final String password = pController.text;
//     final String confirmPassword = cController.text;

//     if (password != confirmPassword) {
//       cError = FlutterI18n.translate(context, 'login.password_not_match');
//       setState(() {});
//     }

//     try {
//       await api.user.register(UserRegisterRequest(
//         username: username,
//         email: email,
//         password: password,
//       ));
//       if (!mounted) {
//         return;
//       }
//       Navigator.of(context).pushReplacementNamed('root_nav');
//     } catch (e) {
//       if (e is GrpcError) {
//         // TODO: Better error handling uwu
//         uError = e.message;
//         eError = e.message;
//         pError = e.message;
//         setState(() {});
//       }
//     }
//   }

//   String? requiredField(String? value) {
//     return value != null && value.isNotEmpty ? null : 'This field is required';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Form(
//             child: Column(
//               children: [
//                 Text(
//                   FlutterI18n.translate(context, 'login.sign_up'),
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 TextFormField(
//                   controller: uController,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     errorText: uError,
//                     label: I18nText('login.username'),
//                   ),
//                 ),
//                 const SizedBox(height: Constants.padding),
//                 TextFormField(
//                   controller: eController,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     errorText: eError,
//                     label: I18nText('login.email'),
//                   ),
//                 ),
//                 const SizedBox(height: Constants.padding),
//                 TextFormField(
//                   obscureText: true,
//                   textInputAction: TextInputAction.next,
//                   controller: pController,
//                   decoration: InputDecoration(
//                     errorText: pError,
//                     label: I18nText('login.password'),
//                   ),
//                 ),
//                 const SizedBox(height: Constants.padding),
//                 TextFormField(
//                   obscureText: true,
//                   textInputAction: TextInputAction.done,
//                   onFieldSubmitted: (password) => register(),
//                   controller: cController,
//                   decoration: InputDecoration(
//                     errorText: cError,
//                     label: I18nText('login.confirm_password'),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       FlutterI18n.translate(context, 'login.sign_up'),
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: const Color(0xff4c505b),
//                       child: IconButton(
//                         color: Colors.white,
//                         onPressed: register,
//                         icon: const Icon(
//                           Icons.arrow_forward,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, 'login');
//                     },
//                     style: const ButtonStyle(),
//                     child: Text(
//                       FlutterI18n.translate(context, 'login.title'),
//                       textAlign: TextAlign.left,
//                       style: const TextStyle(decoration: TextDecoration.underline, color: Color(0xff4c505b), fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
