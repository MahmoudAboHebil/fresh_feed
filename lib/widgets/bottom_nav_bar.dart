import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/config/config.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';
import 'animated_bottom_nav_tap.dart';

//(Done): build the page UI take care about theme_done, responsive_done, orientation_done
//progress==>
//(Done): localization
//(Done): page validation logic

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
      alignment: Alignment.center,
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
            text: S.of(context).Home,
            isLight: isLight,
            iconSize: 26,
            navItem: NavbarItem.Home,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() != RoutePath.home) {
                context.goNamed(RouteName.home);
                print('Home');
              }
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            text: S.of(context).Discover,
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            navItem: NavbarItem.Discover,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.discover) {
                context.goNamed(RouteName.discover);

                print('Discover');
              }
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            text: S.of(context).Topics,
            activeIcon: Icons.category,
            icon: Icons.category_outlined,
            navItem: NavbarItem.Topics,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.topics) {
                context.goNamed(RouteName.topics);

                print('Topics');
              }
            },
          ),
          AnimatedBottomNavTap(
            isLight: isLight,
            icon: Icons.bookmark_outline_outlined,
            activeIcon: Icons.bookmark,
            text: S.of(context).Bookmarks,
            navItem: NavbarItem.Bookmarks,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.bookmarks) {
                context.goNamed(RouteName.bookmarks);

                print('Bookmarks');
              }
            },
          ),
          AnimatedBottomNavTap(
            text: S.of(context).Profile,
            isLight: isLight,
            icon: Icons.person,
            navItem: NavbarItem.Profile,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.profile) {
                context.goNamed(RouteName.profile);
              }

              print('Profile');
            },
          ),
        ],
      ),
    );
  }
}
