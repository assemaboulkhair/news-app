class ArticleModel {
  final String? sourceId;
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const ArticleModel({
    required this.sourceId,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'];
    return ArticleModel(
      sourceId: source is Map ? source['id']?.toString() : null,
      sourceName: source is Map ? (source['name']?.toString() ?? 'Unknown') : 'Unknown',
      author: json['author']?.toString(),
      title: json['title']?.toString() ?? 'Untitled',
      description: json['description']?.toString(),
      url: json['url']?.toString(),
      urlToImage: json['urlToImage']?.toString(),
      publishedAt: DateTime.tryParse(json['publishedAt']?.toString() ?? ''),
      content: json['content']?.toString(),
    );
  }
}

class NewsPage {
  final List<ArticleModel> articles;
  final int totalResults;

  const NewsPage({required this.articles, required this.totalResults});
}
