import 'package:flutter/material.dart';

import 'extensions.dart';

class AppAlerts {
  AppAlerts._();

  static void displaySnackBar(String error, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.surface),
        ),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }
}
