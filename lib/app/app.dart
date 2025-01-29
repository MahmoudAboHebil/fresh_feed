import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/test_screens/theme_page.dart';

import '../config/theme/app_theme.dart';
import '../generated/l10n.dart';
import '../utils/languages.dart';

//
class FreshFeedApp extends ConsumerWidget {
  const FreshFeedApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeProvider);
    final languageState = ref.watch(languageProvider);

    if (themeState.isLoading || languageState.isLoading) {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Center(
          child: Scaffold(body: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(languageState.value?.name ?? Language.en.name),
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
      home: const ThemePage(),
    );
  }
}
