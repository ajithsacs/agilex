import 'package:agilex/views/login_view.dart';
import 'package:agilex/views/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'views/main_UI.dart';
import 'views/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Agilex Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      "/login": (context) => const Login(),
      "/register": (context) => const Register(),
      "/Notes": (context) => const NotesApp(),
    },
  ));
}
// This widget is the root of your application.

//this will implement app start
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const NotesApp();
                } else {
                  return const EmailVerify();
                  //EmailVerify();
                }
              } else {
                return const Login();
              }
            // if (user != null) {
            //   if (user.emailVerified) {
            //     print("Email verified");
            //   } else {
            //     return const EmailVerify();
            //   }
            // } else {
            //   return const Login();
            // }
            //return const Login();
            // // print(FirebaseAuth.instance.currentUser);
            // final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            // } else {
            //   return EmailVerify();
            // }
            // return const Text("Done");

            default:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
