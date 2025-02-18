import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';

import 'animated_bottom_nav_tap.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeProvider);
    Brightness brightnessSystem = MediaQuery.of(context).platformBrightness;
    Brightness brightnessTheme = Theme.of(context).brightness;

    final isLight = themeState.value == ThemeMode.system
        ? (brightnessSystem == Brightness.light)
        : (brightnessTheme == Brightness.light);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.secondary, width: 1.5),
        ),
      ),
      height: context.setMinSize(50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedBottomNavTap(
            icon: Icons.home_filled,
            isLight: isLight,
            iconSize: 26,
            navItem: NavbarItem.Home,
            callBack: () {
              print('Home');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            navItem: NavbarItem.Discover,
            callBack: () {
              print('Discover');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            activeIcon: Icons.category,
            icon: Icons.category_outlined,
            navItem: NavbarItem.Topics,
            callBack: () {
              print('Topics');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.bookmark_outline_outlined,
            activeIcon: Icons.bookmark,
            navItem: NavbarItem.Bookmarks,
            callBack: () {
              print('Bookmarks');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.person,
            navItem: NavbarItem.Profile,
            callBack: () {
              print('Profile');
            },
          ),
        ],
      ),
    );
  }
}
