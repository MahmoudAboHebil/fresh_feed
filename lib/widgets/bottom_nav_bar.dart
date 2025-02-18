import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/config/config.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:go_router/go_router.dart';

import 'animated_bottom_nav_tap.dart';

//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//progress==>
//TODO: localization
//TODO: page validation logic

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
              context.goNamed(RouteName.home);
              print('Home');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            navItem: NavbarItem.Discover,
            callBack: () {
              context.goNamed(RouteName.discover);

              print('Discover');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            activeIcon: Icons.category,
            icon: Icons.category_outlined,
            navItem: NavbarItem.Topics,
            callBack: () {
              context.goNamed(RouteName.topics);

              print('Topics');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.bookmark_outline_outlined,
            activeIcon: Icons.bookmark,
            navItem: NavbarItem.Bookmarks,
            callBack: () {
              context.goNamed(RouteName.bookmarks);

              print('Bookmarks');
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.person,
            navItem: NavbarItem.Profile,
            callBack: () {
              context.goNamed(RouteName.profile);

              print('Profile');
            },
          ),
        ],
      ),
    );
  }
}
