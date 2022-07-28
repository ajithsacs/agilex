import 'package:agilex/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';

enum MenuAction { logout, settings }

PopupMenuButton dropDown(context) {
  return PopupMenuButton<MenuAction>(onSelected: (value) async {
    switch (value) {
      case MenuAction.logout:
        final logout = await showLogoutDialog(
          context,
        );
        if (logout) {
          await AuthServices.firebase().logout();
          // ;await FirebaseAuth.instance
          //     .signOut() // this logout user from the app and firebase
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
            dialogbutton("Cancel", context, false)
          ],
        );
      }).then((value) => value ?? false);
}
