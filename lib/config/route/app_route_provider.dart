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
      final themeState = await ref.read(themeProvider.future);
      final languageState = await ref.read(languageProvider.future);
      final user = await ref.read(authStateNotifierProvider.future);

      if (state.uri.toString() == RoutePath.splashScreen) {
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
