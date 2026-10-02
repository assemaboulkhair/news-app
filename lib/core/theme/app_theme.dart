// import 'package:flutter/material.dart';
//
// class AppTheme {
//   static const Color accent = Color(0xFF111111);
//   static const Color lightBackground = Color(0xFFF7F7F7);
//   static const Color darkBackground = Color(0xFF111111);
//
//   static ThemeData light() {
//     final scheme = ColorScheme.fromSeed(
//       seedColor: accent,
//       brightness: Brightness.light,
//     );
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       colorScheme: scheme,
//       scaffoldBackgroundColor: lightBackground,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: lightBackground,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       cardTheme: CardThemeData(
//         color: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.black, width: 1),
//         ),
//       ),
//     );
//   }
//
//   static ThemeData dark() {
//     final scheme = ColorScheme.fromSeed(
//       seedColor: Colors.white,
//       brightness: Brightness.dark,
//     );
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       colorScheme: scheme,
//       scaffoldBackgroundColor: darkBackground,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: darkBackground,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       cardTheme: CardThemeData(
//         color: const Color(0xFF1B1B1B),
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: const Color(0xFF1B1B1B),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white, width: 1),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AppTheme {
  // درجات النيفي بلو الراقي المتناسقة مع تطبيق الأخبار
  static const Color accent = Color(0xFF3A86EF5); // لون تباين هادئ لو احتجته
  static const Color lightBackground = Color(0xFFF7F7F7);

  // خلفية الكحلي الغامق للوضع الداكن (بدل الأسود)
  static const Color darkBackground = Color(0xFF0B132B);
  // درجة كحلي أفتح قليلاً للكروت والعناصر عشان تظهر بارزة وجميلة فوق الخلفية
  static const Color darkCardColor = Color(0xFF162238);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3A86EF),
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: darkCardColor, // الكروت بقت بالنيفي الأفتح شوية عشان تظهر بوضوح شيك
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70, width: 1),
        ),
      ),
    );
  }
}