import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/theme_provider.dart';

class UserScreenLoading extends ConsumerWidget {
  const UserScreenLoading({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Profile",
          style: TextStyle(
              fontSize: context.setSp(23),
              color: context.textTheme.bodyLarge?.color),
        ),
        automaticallyImplyLeading: true,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: context.textTheme.bodyLarge?.color,
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.setWidth(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Placeholder
              Gap(context.setMinSize(100)),
              Center(
                child: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: CircleAvatar(
                    radius: context.setWidth(50),
                    backgroundColor: baseColor,
                  ),
                ),
              ),
              Gap(context.setHeight(16)),

              // Name Field Placeholder
              _buildShimmerBox(context,
                  height: 50,
                  baseColor: baseColor,
                  highlightColor: highlightColor),
              Gap(context.setHeight(16)),

              // Email Field Placeholder
              _buildShimmerBox(context,
                  height: 50,
                  baseColor: baseColor,
                  highlightColor: highlightColor),
              Gap(context.setHeight(16)),

              // Mobile Number Field Placeholder
              _buildShimmerBox(context,
                  height: 50,
                  baseColor: baseColor,
                  highlightColor: highlightColor),
              Gap(context.setHeight(32)),

              // Update Profile Button Placeholder
              _buildShimmerBox(context,
                  height: 50,
                  width: double.infinity,
                  baseColor: baseColor,
                  highlightColor: highlightColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBox(BuildContext context,
      {double height = 50,
      double width = double.infinity,
      required Color baseColor,
      required Color highlightColor}) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: context.setHeight(height),
        width: width,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
