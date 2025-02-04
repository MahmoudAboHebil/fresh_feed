import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTheme {
  const AppTheme._();
  static final ThemeData lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xfff44236), // Primary color
      secondary: Color(0xfff6fafd), // Secondary color
      secondaryContainer: Color(0xff767676),
      tertiary: Color(0xff989898),

      appBarColor: Color(0xFFF8F8F8), // Light app bar
      error: Color(0xff990101), // Error color
    ),
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold, // Smooth design
    blendLevel: 5, // Soft blending
    appBarOpacity: 0.98,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      elevatedButtonSchemeColor: SchemeColor.primary,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      bottomNavigationBarElevation: 0,
    ),
    typography: Typography.material2021(),
    useMaterial3: true, // Enable Material 3 styles
    textTheme: GoogleFonts.poppinsTextTheme(), // Apply Google Font
  );

  static final ThemeData darkTheme = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xfff44236),
      secondary: Color(0xff29292b),
      secondaryContainer: Color(0xff6f6f71),
      tertiary: Color(0xff989898),
      appBarColor: Color(0xff212121),
      error: Color(0xffff6767),
    ),
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    scaffoldBackground: const Color(0xff212121),
    blendLevel: 20,
    appBarOpacity: 0.95,
    subThemesData: const FlexSubThemesData(
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 10,
      inputDecoratorBorderWidth: 1,
      inputDecoratorFocusedBorderWidth: 1,
      inputDecoratorUnfocusedHasBorder: true,
      interactionEffects: true, //here
      blendOnLevel: 20,
      elevatedButtonSchemeColor: SchemeColor.primary,
      useM2StyleDividerInM3: true,
      useMaterial3Typography: true,
      bottomNavigationBarElevation: 0,
    ),
    typography: Typography.material2021(),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
