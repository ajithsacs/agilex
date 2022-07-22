import 'package:agilex/views/registor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Agilex Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Login(),
  ));
}
// This widget is the root of your application.

//this will implement the the work such as design the app start
