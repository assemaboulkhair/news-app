// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class AppSettingsController extends ChangeNotifier {
// //   ThemeMode themeMode = ThemeMode.dark;
// //   Locale locale = const Locale('en');
// //
// //   Future<void> load() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final theme = prefs.getString('theme');
// //     final language = prefs.getString('language');
// //     themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
// //     locale = language == 'ar' ? const Locale('ar') : const Locale('en');
// //     notifyListeners();
// //   }
// //
// //   Future<void> setTheme(ThemeMode mode) async {
// //     themeMode = mode;
// //     notifyListeners();
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('theme', mode == ThemeMode.light ? 'light' : 'dark');
// //   }
// //
// //   Future<void> setLocale(Locale value) async {
// //     locale = value;
// //     notifyListeners();
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('language', value.languageCode);
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppSettingsController extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.dark;
//   Locale locale = const Locale('en');
//
//   // دالة تحميل البيانات عند بداية التشغيل
//   Future<void> load() async {
//     final prefs = await SharedPreferences.getInstance();
//     final theme = prefs.getString('theme');
//     final language = prefs.getString('language');
//
//     themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
//     locale = language == 'ar' ? const Locale('ar') : const Locale('en');
//     notifyListeners();
//   }
//
//   Future<void> setTheme(ThemeMode mode) async {
//     if (themeMode == mode) return; // منع إعادة البناء لو نفس الثيم
//     themeMode = mode;
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('theme', mode == ThemeMode.light ? 'light' : 'dark');
//   }
//
//   Future<void> setLocale(Locale value) async {
//     if (locale == value) return; // منع إعادة البناء لو نفس اللغة
//     locale = value;
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('language', value.languageCode);
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  Locale locale = const Locale('en');

  // قراءة الخيارات المحفوظة فور تشغيل التطبيق
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');
    final language = prefs.getString('language');

    themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    locale = language == 'ar' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  // حفظ وتغيير الوضع الداكن/الفاتح
  Future<void> setTheme(ThemeMode mode) async {
    if (themeMode == mode) return;
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', mode == ThemeMode.light ? 'light' : 'dark');
  }

  // حفظ وتغيير اللغة
  Future<void> setLocale(Locale value) async {
    if (locale == value) return;
    locale = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value.languageCode);
  }
}