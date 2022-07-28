
import 'package:agilex/constants/routes.dart';
import 'package:agilex/fuctional/errordialog.dart';
import 'package:agilex/services/auth/auth_services.dart';
import 'package:agilex/services/auth/authexception.dart';
import 'package:flutter/material.dart';


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
  firebaseAccountCreate(username, password) async{
    AuthServices.firebase().init();
    //this will convert _password to text
    try {
      final auth = AuthServices.firebase();
      await auth.createUser(
        email: username,
        password: password,
      );
      AuthServices.firebase().sendEmailverification();
      //FirebaseAuth.instance.currentUser?.sendEmailVerification();
      //  Navigator.of(context).pushNamed(emailVerifyRout);
      Navigator.pushNamed(context, emailVerifyRout);
    } on EmailAlreadyInUse {
      showErrordialog(context, "Email in use try new");
    } on WeekpasswordAuthException {
      showErrordialog(context, "You Password is week");
    } on GenericAuthException {
      showErrordialog(context, "Somthing went Wrong ");
    }
  }

  /* this is the old code for firebase account create exception handeling */

  //   on FirebaseAuthException catch (e) {
  //     if (e.code == emailAlreadyInUse) {
  //       showErrordialog(context, "Email in use try new");
  //     } else if (e.code == weekpassword) {
  //       showErrordialog(context, "You Password is week");
  //     } else {
  //       showErrordialog(context, "Somthing went Wrong ${e.code}");
  //     }
  //   } catch (e) {
  //     showErrordialog(context, "Error:${e.toString()}");
  //   }

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
