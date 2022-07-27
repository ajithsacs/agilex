import 'package:agilex/constants/response.dart';
import 'package:agilex/constants/routes.dart';
import 'package:agilex/fuctional/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

// this is firebase logic
firebaseLogin(email, passwords, context) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final username = email.text;
  final password = passwords.text;

  try {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
        email: username, password: password);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(notesAppRoute, (route) => false);
  } on FirebaseAuthException catch (e) {
    if (e.code == usernotfound) {
      showErrordialog(context, "Email not found");
    } else if (e.code == wrongpassword) {
      showErrordialog(context, "Invalid Cerdntials try again");
    } else if (e.code == networkerror) {
      showErrordialog(context, "Network Error");
    } else {
      showErrordialog(context, "Error ${e.code}");
    }
  } catch (e) {
    showErrordialog(context, "some thing went wrong ${e.toString()}");
  }
}

//design of login
Column _loginDesign(email, password, context, routes) {
  return Column(
    children: [
      TextField(
        controller: email,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: "Email"),
      ),
      TextField(
        controller: password,
        obscureText: true,
        decoration: const InputDecoration(hintText: "password"),
      ),
      TextButton(
        onPressed: () {
          firebaseLogin(email, password, context);
        },
        child: const Text("Login"),
      ),
      TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(routes, (routes) => false);
          },
          child: const Text("Registor user"))
    ],
  );
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;

  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var routes = registerRoute;
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: _loginDesign(_email, _password, context, routes));
  }
}
