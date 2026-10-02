//


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../controllers/news_controller.dart';
import '../widgets/app_drawer.dart';
import '../widgets/article_card.dart';
import 'details_screen.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String category;

  const CategoryNewsScreen({super.key, required this.category});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  final _scrollController = ScrollController();
  String? _selectedSource;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCategory());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
        context.read<NewsController>().loadMore();
      }
    });
  }

  Future<void> _loadCategory() async {
    _selectedSource = null;
    await context.read<NewsController>().loadCategory(widget.category);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _categoryName(AppLocalizations l10n) {
    switch (widget.category) {
      case 'business': return l10n.business;
      case 'sports': return l10n.sports;
      case 'entertainment': return l10n.entertainment;
      case 'technology': return l10n.technology;
      case 'science': return l10n.science;
      case 'health': return l10n.health;
      default: return l10n.general;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeBgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(onGoHome: () => Navigator.popUntil(context, (route) => route.isFirst)),
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
                _categoryName(l10n),
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
            ),
          ),
        ),
      ),
      body: Consumer<NewsController>(
        builder: (context, controller, _) {
          final sources = <String>{
            for (final article in controller.articles)
              if (article.sourceName.trim().isNotEmpty && article.sourceName != 'Unknown') article.sourceName.trim(),
          }.toList();

          final visibleArticles = _selectedSource == null
              ? controller.articles
              : controller.articles.where((article) => article.sourceName == _selectedSource).toList();

          return RefreshIndicator(
            onRefresh: _loadCategory,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 52,
                  ),
                ),
                if (sources.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _SourceBar(
                      sources: sources,
                      selectedSource: _selectedSource,
                      onSelected: (source) => setState(() => _selectedSource = source),
                    ),
                  ),
                if (controller.isLoading && controller.articles.isEmpty)
                  SliverFillRemaining(
                    // التحميل الرئيسي بالـ Lottie احترافي
                    child: Center(
                      child: Lottie.asset(
                        'assets/json/loading.json',
                        width: 60,
                        height: 150,
                      ),
                    ),
                  )
                else if (controller.errorMessage != null && controller.articles.isEmpty)
                  SliverFillRemaining(
                    child: _ErrorState(message: controller.errorMessage!, onRetry: _loadCategory),
                  )
                else if (controller.articles.isEmpty)
                    SliverFillRemaining(child: Center(child: Text(l10n.noArticles)))
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            if (index == visibleArticles.length) {
                              return const Padding(
                                padding: EdgeInsets.all(18),
                                // تعديل التحميل السفلي إلى مؤشر عادي وبسيط
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final article = visibleArticles[index];
                            return ArticleCard(
                              article: article,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => DetailsScreen(article: article)),
                              ),
                            );
                          },
                          childCount: visibleArticles.length + (controller.isLoadingMore && _selectedSource == null ? 1 : 0),
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
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

class _SourceBar extends StatelessWidget {
  final List<String> sources;
  final String? selectedSource;
  final ValueChanged<String?> onSelected;

  const _SourceBar({required this.sources, required this.selectedSource, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        scrollDirection: Axis.horizontal,
        itemCount: sources.length,
        separatorBuilder: (_, __) => const SizedBox(width: 28),
        itemBuilder: (_, index) {
          final source = sources[index];
          final selected = selectedSource == source;
          return InkWell(
            onTap: () => onSelected(selected ? null : source),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
                      width: 1.6,
                    ),
                  ),
                ),
                child: Text(
                  source,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 42),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}