import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/font_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeNotifier extends AsyncNotifier<FontSize> {
  @override
  Future<FontSize> build() async {
    return await _loadTheme();
  }

  Future<FontSize> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedFontSizeIndex = prefs.getInt('fontSize') ?? 2;
      return FontSize.values[savedFontSizeIndex];
    } catch (e) {
      return FontSize.medium;
    }
  }

  Future<void> toggleFontSize(FontSize fontSize) async {
    try {
      state = AsyncValue.data(fontSize);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('fontSize', fontSize.index);
    } catch (e) {
      rethrow;
    }
  }
}

final fontSizeProvider = AsyncNotifierProvider<FontSizeNotifier, FontSize>(() {
  return FontSizeNotifier();
});
