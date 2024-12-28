import 'package:flutter/material.dart';

class SnackbarUtil {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Optional: adjust duration
        behavior: SnackBarBehavior.floating, // Optional: make it floating
      ),
    );
  }
}
