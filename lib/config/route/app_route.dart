import 'package:flutter/material.dart';
import 'package:fresh_feed/config/route/route_name.dart';
import 'package:fresh_feed/config/route/route_path.dart';
import 'package:fresh_feed/screens/screens.dart';
import 'package:go_router/go_router.dart';

final parentNavigationKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRoute = [
  ShellRoute(
    parentNavigatorKey: parentNavigationKey,
    navigatorKey: _shellNavigatorKey,
    pageBuilder: (context, state, child) {
      return MaterialPage(
        maintainState: true,
        name: state.fullPath,
        child: ShellScreen(
          child: child,
        ),
      );
    },
    routes: [
      GoRoute(
        name: RouteName.home,
        path: RoutePath.home,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.discover,
        path: RoutePath.discover,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const DiscoverScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.topics,
        path: RoutePath.topics,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const TopicsScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.bookmarks,
        path: RoutePath.bookmarks,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const BookmarksScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.profile,
        path: RoutePath.profile,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const ProfileScreen(),
          );
        },
      ),
    ],
  ),
  GoRoute(
    name: RouteName.signIn,
    path: RoutePath.signIn,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const SignScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.user,
    path: RoutePath.user,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const UserScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.followedChannels,
    path: RoutePath.followedChannels,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const FollowedChannelsScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.createAccount,
    path: RoutePath.createAccount,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const CreateAccountScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.forgotPassword,
    path: RoutePath.forgotPassword,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const ForgotPasswordScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.splashScreen,
    path: RoutePath.splashScreen,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const SplashScreen(),
      );
    },
  ),
];
