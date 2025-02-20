import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/config/config.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/widgets/app_error_widget.dart';
import 'package:fresh_feed/widgets/bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';

import '../loading_components/shell_loading.dart';
import '../utils/navbar_item.dart';
import 'navbar_screens/home_screen.dart';

class ShellScreen extends ConsumerStatefulWidget {
  static ShellScreen builder(BuildContext buildContext, GoRouterState state) =>
      ShellScreen();
  const ShellScreen({
    super.key,
    this.child = const HomeScreen(),
  });
  final Widget? child;
  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      GoRouter.of(context).routerDelegate.addListener(() {
        if (mounted) {
          final navItem = getCurrentRoute();
          final navProv = ref.read(navBarProvider);
          if (navItem != navProv) {
            ref.read(navBarProvider.notifier).state = navItem;
          }
        }
      });
    });
  }

  NavbarItem getCurrentRoute() {
    final currentRoute = GoRouter.of(context).state.uri;
    try {
      RegExp regExp = RegExp(r'^/\w+\b');
      var firstRoute = regExp.firstMatch(currentRoute.toString())?.group(0);

      if (firstRoute != null) {
        if (firstRoute == RoutePath.discover) {
          return NavbarItem.Discover;
        } else if (firstRoute == RoutePath.topics) {
          return NavbarItem.Topics;
        } else if (firstRoute == RoutePath.bookmarks) {
          return NavbarItem.Bookmarks;
        } else if (firstRoute == RoutePath.profile) {
          return NavbarItem.Profile;
        } else {
          return NavbarItem.Home;
        }
      }
      return NavbarItem.Home;
    } catch (e) {
      return NavbarItem.Home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(userNotifierProvider);
    final networkStream = ref.watch(networkInfoStreamNotifierProv);
    final userBookmarksProv = ref.read(userBookmarksNotifierProvider.notifier);
    final userFollowedChannelsProv =
        ref.read(userFollowedChannelsNotifierProvider.notifier);
    ref.listen(userListenerProvider, (prev, now) async {
      print(
          'userListenerProvider (SignInUp) about user Bookmarks-article=====> shell');
      try {
        await userBookmarksProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });
    ref.listen(userListenerProvider, (prev, now) async {
      print(
          'userListenerProvider (SignInUp) about user followed-channels=====> shell');
      try {
        await userFollowedChannelsProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        final navItem = getCurrentRoute();

        if (navItem != NavbarItem.Home) {
          ref.read(navBarProvider.notifier).state = NavbarItem.Home;
          context.goNamed(RouteName.home);
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: networkStream.when(
          data: (net) {
            // return const ShellLoading();
            if (!net)
              return Center(
                child: Text('no network Shell'),
              );
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: widget.child!,
                  ),
                  BottomNavBar()
                ],
              ),
            );
          },
          error: (error, stackTrace) => const AppErrorWidget(
            buttonText: null,
            callBack: null,
          ),
          loading: () => const ShellLoading(),
        ),
      ),
    );
  }
}
