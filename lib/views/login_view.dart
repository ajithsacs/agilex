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
    final user = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    print(user);
    Navigator.of(context).pushNamedAndRemoveUntil("/Notes", (route) => false);
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'user-not-found') {
      print("plz registor");
    } else if (e.code == "wrong-password") {
      print("Wrong password");
    } else if (e.code == "network-request-failed") {
      print("network error");
    } else {
      print(e.code);
    }
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
    var routes = "/register";
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: _loginDesign(_email, _password, context, routes));
  }
}
