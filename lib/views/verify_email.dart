import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

Column emailVerifyDesign() {
  return Column(
    children: [
      const Center(
        child: Text("Send code to Email "),
      ),
      TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            var email = await FirebaseAuth.instance.currentUser
                ?.sendEmailVerification();
          },
          child: Text("Send Email"))
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
      body: emailVerifyDesign(),
    );
  }
}
