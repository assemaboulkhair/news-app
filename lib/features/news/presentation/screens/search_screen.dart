import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_settings_controller.dart';
import '../controllers/news_controller.dart';
import '../widgets/article_card.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 400) {
        final settings = context.read<AppSettingsController>();
        context.read<NewsController>().loadMore(language: settings.locale.languageCode);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _submit() {
    final settings = context.read<AppSettingsController>();
    context.read<NewsController>().search(_controller.text, language: settings.locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.search)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(icon: const Icon(Icons.close), onPressed: () => _controller.clear()),
              ),
            ),
          ),
          Expanded(
            child: Consumer<NewsController>(
              builder: (_, controller, __) {
                if (controller.isLoading) return const Center(child: CircularProgressIndicator());
                if (controller.errorMessage != null && controller.articles.isEmpty) {
                  return Center(child: Text(controller.errorMessage!));
                }
                if (controller.articles.isEmpty) return Center(child: Text(l10n.noArticles));
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.articles.length + (controller.isLoadingMore ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index == controller.articles.length) {
                      return const Padding(padding: EdgeInsets.all(18), child: Center(child: CircularProgressIndicator()));
                    }
                    final article = controller.articles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(article: article))),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
