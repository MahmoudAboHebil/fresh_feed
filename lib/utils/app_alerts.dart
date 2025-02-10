import 'package:flutter/material.dart';

import 'extensions.dart';

class AppAlerts {
  AppAlerts._();

  static void displaySnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontSize: context.setSp(context.textTheme.bodyMedium!.fontSize!)),
        ),
        backgroundColor: context.colorScheme.surface,
      ),
    );
  }

  static void displayDialog(Function callBack, String okTextString,
      String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(okTextString),
            onPressed: () async {
              await callBack();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static Future<bool> displayPermissionDialog(Future<bool> Function() callBack,
      String okTextString, String content, BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Required"),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(okTextString),
            onPressed: () async {
              bool callbackResult = await callBack();
              Navigator.pop(context, callbackResult);
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false), // Return false
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
