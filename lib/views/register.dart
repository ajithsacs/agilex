import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import '../firebase_options.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

//this the base class that handle state
class _RegisterState extends State<Register> {
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
            final username = _email.text; //this will convert the _email to text
            final password =
                _password.text; //this will convert _password to text
            try {
              final auth = FirebaseAuth.instance;
              final user = await auth.createUserWithEmailAndPassword(
                  email: username, password: password);
            } on FirebaseAuthException catch (e) {
              if (e.code == "email-already-in-use") {
                print("Email Already Exist");
              } else if (e.code == "weak-password") {
                print("Try Some good Password");
              } else {
                print("Something Went Wrong");
              }
              print(e.code);
            }
          },
          child: const Text("Registor")),
      TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
          child: const Text("Go to Login"))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: _createAccountEmailPassword());
  }
//this will create our Registration page with one button and 2 text box
}
