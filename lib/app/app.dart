import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/screens/screens.dart';
import 'package:fresh_feed/utils/extensions.dart';

import '../config/theme/app_theme.dart';
import '../generated/l10n.dart';
import '../utils/languages.dart';

//ToDo: you need splash screen for themeState & languageState & languageState
class FreshFeedApp extends ConsumerWidget {
  const FreshFeedApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeProvider);
    final languageState = ref.watch(languageProvider);
    final userStream = ref.read(authStateNotifierProvider);
    Brightness brightnessSystem = MediaQuery.of(context).platformBrightness;
    Brightness brightnessTheme = Theme.of(context).brightness;
    return DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return SizeProvider(
          baseSize: const Size(411, 869),
          height: context.screenHeight,
          width: context.screenWidth,
          child: MaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            locale: Locale(languageState.value?.name ?? Language.en.name),
            // locale: Locale(Language.en.name),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.value ?? ThemeMode.system,
            // themeMode: ThemeMode.dark,
            home: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: themeState.value == ThemeMode.system
                    ? (brightnessSystem == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark)
                    : (brightnessTheme == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark),
              ),
              child: userStream.when(
                data: (user) {
                  if (user == null) {
                    return const SignScreen();
                  } else {
                    return const HomeScreen();
                  }
                },
                error: (error, stack) {
                  return const SignScreen();
                },
                loading: () {
                  // splash Screen
                  return const Scaffold();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
