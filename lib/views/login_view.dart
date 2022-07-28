import 'package:agilex/constants/routes.dart';
import 'package:agilex/fuctional/errordialog.dart';
import 'package:agilex/services/auth/auth_services.dart';
import 'package:agilex/services/auth/authexception.dart';
import 'package:flutter/material.dart';

// this is firebase logic
firebaseLogin(email, passwords, context) async {
  AuthServices.firebase().init();
  final username = email.text;
  final password = passwords.text;

  try {
    final auth = AuthServices.firebase();
    final user = await auth.login(email: username, password: password);
    //final user = AuthServices.firebase().currentUser;
    if (user.isEmailverifyed) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(notesAppRoute, (route) => false);
    } else {
      Navigator.popAndPushNamed(context, emailVerifyRout);
    }
  } on EmailnotFound {
    showErrordialog(context, "Email not found");
  } on InvalidPassword {
    showErrordialog(context, "Invalid Cerdntials try again");
  } on NetworkNotFoundException {
    showErrordialog(context, "Network Error");
  } on WeekpasswordAuthException {
    showErrordialog(context, "week password Error");
  } on GenericAuthException {
    showErrordialog(context, "Authentication error");
  }
  //* firebase coe was repleaced and we used servics folder to do that */
  // } on FirebaseAuthException  catch (e) {
  //   if (e.code == usernotfound) {
  //     showErrordialog(context, "Email not found");
  //   } else if (e.code == wrongpassword) {
  //     showErrordialog(context, "Invalid Cerdntials try again");
  //   } else if (e.code == networkerror) {
  //     showErrordialog(context, "Network Error");
  //   } else {
  //     showErrordialog(context, "Error ${e.code}");
  //   }
  // } catch (e) {
  //   showErrordialog(context, "some thing went wrong ${e.toString()}");
  // }
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
