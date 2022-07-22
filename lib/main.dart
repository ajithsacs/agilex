import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LoginView());
}

class RegistorView extends StatefulWidget {
  const RegistorView({Key? key}) : super(key: key);

  @override
  State<RegistorView> createState() => _RegistorViewState();
}

class _RegistorViewState extends State<RegistorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _email;

  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Column _createAccountEmailPassword() {
    return Column(children: [
      TextField(
        controller: _email,
        enableSuggestions: false,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: "email"),
      ),
      TextField(
        controller: _password,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(hintText: "password"),
      ),
      TextButton(
          onPressed: () async {
            Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform);
            final username = _email.text;
            final password = _password.text;
            final auth = FirebaseAuth.instance;
            final user = await auth.createUserWithEmailAndPassword(
                email: username, password: password);
            RegistorView();
          },
          child: const Text("Registor"))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("agilex_Sample_01")),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return _createAccountEmailPassword();
              default:
                return const Scaffold(body: Center(child: Text("Looding...")));
            }
          },
        ));
  }
}
