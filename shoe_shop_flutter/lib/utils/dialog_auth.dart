import 'package:flutter/material.dart';

class DialogAuth {
  static void showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Login Required"),
        content: Text("You need to log in to perform this action."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushNamed(context, '/login');
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}