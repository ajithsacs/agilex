import 'package:agilex/constants/routes.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as dev show log;

enum MenuAction { logout, settings }

class NotesApp extends StatefulWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  State<NotesApp> createState() => _NotesAppState();
}

PopupMenuButton dropDown(context) {
  return PopupMenuButton<MenuAction>(onSelected: (value) async {
    switch (value) {
      case MenuAction.logout:
        final logout = await showLogoutDialog(
          context,
        );
        if (logout) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(loginRoute, (route) => false);
        }

        break;
      case MenuAction.settings:
        // TODO: Handle this case.
        break;
    }
  }, itemBuilder: (context) {
    return const [
      PopupMenuItem<MenuAction>(
        value: MenuAction.logout,
        child: Text("logout"),
      ),
      PopupMenuItem<MenuAction>(
        value: MenuAction.settings,
        child: Text("Settings"),
      )
    ];
  });
}

TextButton dialogbutton(dialog, context, sataus) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).pop(sataus);
    },
    child: Text(dialog),
  );
}

Future<bool> showLogoutDialog(context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert Logout "),
          content: const Text("Are you sure to logout !"),
          actions: [
            dialogbutton("Ok", context, true),
            dialogbutton("Cancel", context, true)
          ],
        );
      }).then((value) => value ?? false);
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
