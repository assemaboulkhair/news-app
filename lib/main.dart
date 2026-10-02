// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'core/localization/app_localizations.dart';
// import 'core/theme/app_settings_controller.dart';
// import 'core/theme/app_theme.dart';
// import 'features/news/data/datasources/news_remote_data_source.dart';
// import 'features/news/data/repositories/news_repository.dart';
// import 'features/news/presentation/controllers/news_controller.dart';
// import 'features/news/presentation/screens/splash_screen.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final settings = AppSettingsController();
//   await settings.load();
//
//   final dio = Dio(BaseOptions(
//     baseUrl: 'https://newsapi.org/v2',
//     connectTimeout: const Duration(seconds: 15),
//     receiveTimeout: const Duration(seconds: 15),
//     sendTimeout: const Duration(seconds: 15),
//   ));
//   final dataSource = NewsRemoteDataSource(dio);
//   final repository = NewsRepository(dataSource);
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: settings),
//         ChangeNotifierProvider(create: (_) => NewsController(repository)),
//       ],
//       child: const NewsApp(),
//     ),
//   );
// }
//
// class NewsApp extends StatelessWidget {
//   const NewsApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSettingsController>(
//       builder: (context, settings, _) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'News App',
//           theme: AppTheme.light(),
//           darkTheme: AppTheme.dark(),
//           themeMode: settings.themeMode,
//           locale: settings.locale,
//           supportedLocales: AppLocalizations.supportedLocales,
//           localizationsDelegates: const [
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           home: const SplashScreen(),
//         );
//       },
//     );
//   }
// }



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_settings_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository.dart';
import 'features/news/presentation/controllers/news_controller.dart';
import 'features/news/presentation/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل الثيم واللغة المحفوظة مسبقاً
  final settings = AppSettingsController();
  await settings.load();

  final dio = Dio(BaseOptions(
    baseUrl: 'https://newsapi.org/v2',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
  ));
  final dataSource = NewsRemoteDataSource(dio);
  final repository = NewsRepository(dataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(create: (_) => NewsController(repository)),
      ],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsController>(
      builder: (context, settings, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        );
      },
    );
  }
}