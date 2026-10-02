import '../datasources/news_remote_data_source.dart';
import '../models/article_model.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  NewsRepository(this.remoteDataSource);

  Future<NewsPage> getTopHeadlines({required String category, required int page, String? language}) {
    return remoteDataSource.getTopHeadlines(category: category, page: page, language: language);
  }

  Future<NewsPage> searchArticles({required String query, required int page, String? language}) {
    return remoteDataSource.searchArticles(query: query, page: page, language: language);
  }
}
