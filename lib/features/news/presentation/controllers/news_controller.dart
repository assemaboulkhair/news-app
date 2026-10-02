import 'package:flutter/foundation.dart';

import '../../data/models/article_model.dart';
import '../../data/repositories/news_repository.dart';

class NewsController extends ChangeNotifier {
  final NewsRepository repository;

  NewsController(this.repository);

  final List<ArticleModel> articles = [];
  String selectedCategory = 'general';
  String? searchQuery;
  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;
  int currentPage = 1;
  int totalResults = 0;

  bool get hasMore => articles.length < totalResults && articles.isNotEmpty;

  Future<void> loadCategory(String category, {String? language}) async {
    selectedCategory = category;
    searchQuery = null;
    currentPage = 1;
    totalResults = 0;
    errorMessage = null;
    articles.clear();
    isLoading = true;
    notifyListeners();

    try {
      final page = await repository.getTopHeadlines(
        category: category,
        page: 1,
        language: language,
      );
      articles.addAll(page.articles);
      totalResults = page.totalResults;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> search(String query, {String? language}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    searchQuery = trimmed;
    currentPage = 1;
    totalResults = 0;
    errorMessage = null;
    articles.clear();
    isLoading = true;
    notifyListeners();

    try {
      final page = await repository.searchArticles(
        query: trimmed,
        page: 1,
        language: language,
      );
      articles.addAll(page.articles);
      totalResults = page.totalResults;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore({String? language}) async {
    if (isLoadingMore || isLoading || !hasMore) return;
    isLoadingMore = true;
    notifyListeners();

    try {
      final nextPage = currentPage + 1;
      final page = searchQuery == null
          ? await repository.getTopHeadlines(
              category: selectedCategory,
              page: nextPage,
              language: language,
            )
          : await repository.searchArticles(
              query: searchQuery!,
              page: nextPage,
              language: language,
            );
      currentPage = nextPage;
      articles.addAll(page.articles);
      totalResults = page.totalResults;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }
}
