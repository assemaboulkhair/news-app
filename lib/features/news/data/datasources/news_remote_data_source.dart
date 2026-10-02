import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/article_model.dart';

class NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSource(this.dio);

  String get _apiKey => AppConstants.newsApiKey;

  Future<NewsPage> getTopHeadlines({
    required String category,
    required int page,
    String? language,
  }) async {
    return _request(
      '/top-headlines',
      queryParameters: {
        'country': AppConstants.defaultCountry,
        'category': category,
        'page': page,
        'pageSize': AppConstants.pageSize,
      },
    );
  }

  Future<NewsPage> searchArticles({
    required String query,
    required int page,
    String? language,
  }) async {
    return _request(
      '/everything',
      queryParameters: {
        'q': query,
        'language': AppConstants.defaultLanguage,
        'sortBy': 'publishedAt',
        'page': page,
        'pageSize': AppConstants.pageSize,
      },
    );
  }

  Future<NewsPage> _request(
      String path, {
        required Map<String, dynamic> queryParameters,
      }) async {
    final response = await dio.get<Map<String, dynamic>>(
      path,
      queryParameters: {
        ...queryParameters,
        'apiKey': _apiKey,
      },
      options: Options(responseType: ResponseType.json),
    );

    final data = response.data ?? {};
    if (data['status'] != 'ok') {
      throw Exception(data['message']?.toString() ?? 'News API request failed');
    }

    final rawArticles = (data['articles'] as List?) ?? const [];
    final articles = rawArticles
        .whereType<Map>()
        .map((item) => ArticleModel.fromJson(Map<String, dynamic>.from(item)))
        .where((article) => article.title.trim().isNotEmpty && article.title != '[Removed]')
        .toList();

    return NewsPage(
      articles: articles,
      totalResults: (data['totalResults'] as num?)?.toInt() ?? articles.length,
    );
  }
}