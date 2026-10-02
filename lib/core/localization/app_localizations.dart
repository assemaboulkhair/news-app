import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [Locale('en'), Locale('ar')];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  bool get isArabic => locale.languageCode == 'ar';

  String get appName => isArabic ? 'أخبار' : 'News App';
  String get goodMorning => isArabic ? 'صباح الخير' : 'Good Morning';
  String get intro => isArabic ? 'إليك بعض الأخبار لك' : 'Here is Some News For You';
  String get home => isArabic ? 'الرئيسية' : 'Home';
  String get general => isArabic ? 'عام' : 'General';
  String get business => isArabic ? 'أعمال' : 'Business';
  String get sports => isArabic ? 'رياضة' : 'Sports';
  String get entertainment => isArabic ? 'ترفيه' : 'Entertainment';
  String get technology => isArabic ? 'تكنولوجيا' : 'Technology';
  String get science => isArabic ? 'علوم' : 'Science';
  String get health => isArabic ? 'صحة' : 'Health';
  String get viewAll => isArabic ? 'عرض الكل' : 'View All';
  String get viewFullArticle => isArabic ? 'عرض المقال كاملًا' : 'View Full Article';
  String get search => isArabic ? 'بحث' : 'Search';
  String get settings => isArabic ? 'الإعدادات' : 'Settings';
  String get theme => isArabic ? 'المظهر' : 'Theme';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get dark => isArabic ? 'داكن' : 'Dark';
  String get light => isArabic ? 'فاتح' : 'Light';
  String get english => 'English';
  String get arabic => 'العربية';
  String get noArticles => isArabic ? 'لا توجد أخبار متاحة' : 'No articles available';
  String get loading => isArabic ? 'جاري التحميل...' : 'Loading...';
  String get error => isArabic ? 'حدث خطأ أثناء تحميل الأخبار' : 'Something went wrong while loading news';
  String get retry => isArabic ? 'إعادة المحاولة' : 'Retry';
  String get source => isArabic ? 'المصدر' : 'Source';
  String get by => isArabic ? 'بواسطة' : 'By';
  String get minutesAgo => isArabic ? 'منذ دقائق' : 'minutes ago';
  String get goToHome => isArabic ? 'الصفحة الرئيسية' : ' Home';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
