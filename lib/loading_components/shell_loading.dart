import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/theme_provider.dart';

class ShellLoading extends ConsumerWidget {
  const ShellLoading({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeProvider);

    Brightness brightnessSystem = MediaQuery.of(context).platformBrightness;
    Brightness brightnessTheme = Theme.of(context).brightness;

    final isDarkMode = themeState.value == ThemeMode.system
        ? (brightnessSystem == Brightness.dark)
        : (brightnessTheme == Brightness.dark);

    Color baseColor = isDarkMode
        ? Colors.black.withOpacity(0.3) // Dark theme base
        : Colors.grey.withOpacity(0.3); // Light theme base
    Color highlightColor = isDarkMode
        ? Colors.black.withOpacity(1) // Dark theme highlight
        : Colors.grey.withOpacity(1); // Light theme highlight

    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
