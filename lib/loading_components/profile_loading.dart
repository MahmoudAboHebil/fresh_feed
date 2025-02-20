import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../generated/l10n.dart';
import '../providers/theme_provider.dart';

class ProfileLoading extends ConsumerWidget {
  const ProfileLoading({super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Header
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: context.setMinSize(70),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Gap(context.setHeight(16)),

        // Followed Channels
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: context.setMinSize(50),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Gap(context.setHeight(24)),
        Text(
          S.of(context).GeneralSettings,
          style: TextStyle(fontSize: context.setSp(20)),
        ),
        Gap(context.setHeight(24)),

        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: context.setMinSize(150),
            height: context.setMinSize(20),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Gap(context.setHeight(16)),

        // Settings Items (Repeated for each)
        ...List.generate(7,
            (index) => _buildShimmerItem(baseColor, highlightColor, context)),

        // Logout Button
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: context.setMinSize(50),
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerItem(
      Color baseColor, Color highlightColor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          height: context.setMinSize(50),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
