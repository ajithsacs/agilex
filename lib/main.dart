import 'package:agilex/api/Apidesign.dart';
import 'package:agilex/constants/routes.dart';
import 'package:agilex/services/auth/auth_services.dart';
import 'package:agilex/views/login_view.dart';
import 'package:agilex/views/register.dart';
import 'package:flutter/material.dart';
import 'views/Main_ui.dart';
import 'views/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Agilex Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const ApiDesign(),
    routes: {
      loginRoute: (context) => const Login(),
      registerRoute: (context) => const Register(),
      notesAppRoute: (context) => const NotesApp(),
      emailVerifyRout: (context) => const EmailVerify(),
      apiroute: ((context) => const ApiDesign()),
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
        future: AuthServices.firebase().init(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthServices.firebase().currentUser;
              if (user != null) {
                if (user.isEmailverifyed) {
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
