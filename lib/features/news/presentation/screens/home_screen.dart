
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../widgets/app_drawer.dart';
import '../widgets/category_card.dart';
import 'category_news_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _categoryImages = <String, String>{
    'general': 'assets/images/general.png',
    'business': 'assets/images/business.png',
    'sports': 'assets/images/sports.png',
    'entertainment': 'assets/images/Entertainment.png',
    'technology': 'assets/images/technology.png',
    'science': 'assets/images/science.png',
    'health': 'assets/images/health.png',
  };

  String _categoryName(AppLocalizations l10n, String category) {
    switch (category) {
      case 'business': return l10n.business;
      case 'sports': return l10n.sports;
      case 'entertainment': return l10n.entertainment;
      case 'technology': return l10n.technology;
      case 'science': return l10n.science;
      case 'health': return l10n.health;
      default: return l10n.general;
    }
  }

  void _openCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CategoryNewsScreen(category: category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries = _categoryImages.entries.toList();
    final themeBgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(onGoHome: () {}),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: AppBar(
              backgroundColor: themeBgColor.withOpacity(0.7),
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: 48,
              centerTitle: true,
              title: Text(
                l10n.home,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              leading: Builder(
                builder: (context) => Center(
                  child: CompactGlassIconButton(
                    icon: Icons.menu_rounded,
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CompactGlassIconButton(
                      icon: Icons.search_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.of(context).padding.top + 52,
          16,
          24,
        ),
        children: [
          Text(l10n.goodMorning, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          Text(l10n.intro, style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor)),
          const SizedBox(height: 14),
          ...List.generate(entries.length, (index) {
            final entry = entries[index];
            return CategoryCard(
              title: _categoryName(l10n, entry.key),
              imageUrl: entry.value,
              imageOnRight: index.isOdd,
              onTap: () => _openCategory(context, entry.key),
              viewAllText: l10n.viewAll,
            );
          }),
        ],
      ),
    );
  }
}

class CompactGlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CompactGlassIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.white.withOpacity(0.12)
            : colorScheme.onSurface.withOpacity(0.06),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.3)
              : colorScheme.onSurface.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Icon(
          icon,
          color: isDark ? Colors.white : colorScheme.onSurface,
          size: 18,
        ),
      ),
    );
  }
}




