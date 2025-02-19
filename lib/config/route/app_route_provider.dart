import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/config/route/route_path.dart';
import 'package:go_router/go_router.dart';

import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import 'app_route.dart';

final appRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) async {
      //ToDo : handling the auth here
      final themeState = ref.read(themeProvider);
      final languageState = ref.read(languageProvider);
      final userStream = ref.read(authStateNotifierProvider);

      bool isThemDone = false;
      bool isLangDone = false;
      bool isUserDone = false;
      User? user;
      userStream.whenData(
        (value) {
          user = value;
          isUserDone = true;
          return;
        },
      );
      themeState.whenData(
        (value) {
          isThemDone = true;
          return;
        },
      );
      languageState.whenData(
        (value) {
          isLangDone = true;
          return;
        },
      );
      final isLoadingFinished = isUserDone && isLangDone && isThemDone;
      if (isLoadingFinished && state.uri.toString() == RoutePath.splashScreen) {
        if (user == null) {
          return RoutePath.signIn;
        } else {
          return RoutePath.home;
        }
      }
      return null;
    },
    initialLocation: RoutePath.splashScreen,
    navigatorKey: parentNavigationKey,
    routes: appRoute,
  );
});
