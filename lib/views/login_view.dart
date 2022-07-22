import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

firebaseLogin(email, passwords) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final username = email.text;
  final password = passwords.text;

  try {
    final auth = FirebaseAuth.instance;
    final user = await auth.signInWithEmailAndPassword(
        email: username, password: password);

    print(user);
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
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Column(
          children: [
            TextField(
              controller: _email,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(hintText: "password"),
            ),
            TextButton(
              onPressed: () {
                firebaseLogin(_email, _password);
              },
              child: const Text("Login"),
            )
          ],
        ));
  }
}
