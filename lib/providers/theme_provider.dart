import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeMode:
// 0 => system
// 1 => light
// 2 => dark

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return await _loadTheme();
  }

  Future<ThemeMode> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeIndex = prefs.getInt('themeMode') ?? 0;
      return ThemeMode.values[savedThemeIndex];
    } catch (e) {
      return ThemeMode.system;
    }
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    try {
      state = AsyncValue.data(mode);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('themeMode', mode.index);
    } catch (e) {
      rethrow;
    }
  }
}

final themeProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
