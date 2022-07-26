import 'package:agilex/constants/routes.dart';
import 'package:agilex/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

Column emailVerifyDesign(context) {
  return Column(
    children: [
      const Center(
        child: Text("We Have Send code to Email "),
      ),
      const Text("if not Send code to Email"),
      TextButton(
          onPressed: () async {
            //final user = FirebaseAuth.instance.currentUser;
            await AuthServices.firebase().sendEmailverification();
            //await user?.sendEmailVerification();
          },
          child: const Text("Send Email")),
      TextButton(
          onPressed: () async {
            //await FirebaseAuth.instance.signOut();
            await AuthServices.firebase().logout();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
          child: const Text("Restart")),
    ],
  );
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verify"),
      ),
      body: emailVerifyDesign(context),
    );
  }
}
