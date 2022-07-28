import 'package:flutter/material.dart';
import '../fuctional/dropdown.dart';
// import 'dart:developer' as dev show log;



class NotesApp extends StatefulWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  State<NotesApp> createState() => _NotesAppState();
}


class _NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI "),
        actions: [dropDown(context)],
      ),
      body: Column(children: const [
        Text("You are Logied in sucessfully and your Email is verifyed"),
        Text("Welcome"),
      ]),
    );
  }
}
