import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'app_locale';

  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  // --- حفظ واسترجاع ثيم التطبيق ---
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(_keyThemeMode, mode.name);
  }

  ThemeMode getThemeMode() {
    final modeName = _prefs.getString(_keyThemeMode);
    if (modeName == 'light') return ThemeMode.light;
    if (modeName == 'dark') return ThemeMode.dark;
    return ThemeMode.system; // الافتراضي حسب نظام الجهاز
  }

  // --- حفظ واسترجاع لغة التطبيق ---
  Future<void> saveLocale(Locale locale) async {
    await _prefs.setString(_keyLocale, locale.languageCode);
  }

  Locale getLocale() {
    final languageCode = _prefs.getString(_keyLocale);
    if (languageCode == 'ar') return const Locale('ar');
    return const Locale('en'); // اللغة الافتراضية
  }
}