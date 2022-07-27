// ignore_for_file: use_build_context_synchronously

import 'package:agilex/constants/response.dart';
import 'package:agilex/constants/routes.dart';
import 'package:agilex/fuctional/popup.dart';
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

//create acccount and exception error
  firebaseAccountCreate(username, password) async {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //this will convert _password to text
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      Navigator.of(
        context,
      ).pushNamed(emailVerifyRout);
    } on FirebaseAuthException catch (e) {
      if (e.code == emailAlreadyInUse) {
        showErrordialog(context, "Email in use try new");
      } else if (e.code == weekpassword) {
        showErrordialog(context, "You Password is week");
      } else {
        showErrordialog(context, "Somthing went Wrong ${e.code}");
      }
    } catch (e) {
      showErrordialog(context, "Error:${e.toString()}");
    }
  }

//this route to register page
  registerRout() {
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
  }

//register account design
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
        onPressed: () {
          final username = _email.text; //this will convert the _email to text
          final password = _password.text;
          firebaseAccountCreate(username, password);
        },
        child: const Text("Registor"),
      ),
      TextButton(
        onPressed: () {
          registerRout();
        },
        child: const Text("Go to Login"),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: _createAccountEmailPassword());
  }
//this will create our Registration page with one button and 2 text box
}
