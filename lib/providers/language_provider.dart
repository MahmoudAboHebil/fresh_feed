import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageNotifier extends AsyncNotifier<Language> {
  @override
  Future<Language> build() async {
    return await _loadLanguage();
  }

  Future<Language> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageString =
          Language.stringToLanguage(prefs.getString('language')) ?? Language.en;

      return savedLanguageString;
    } catch (e) {
      return Language.en;
    }
  }

  Future<void> toggleLanguage(Language language) async {
    try {
      state = AsyncValue.data(language);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', language.name);
    } catch (e) {
      rethrow;
    }
  }
}

final languageProvider = AsyncNotifierProvider<LanguageNotifier, Language>(() {
  return LanguageNotifier();
});
