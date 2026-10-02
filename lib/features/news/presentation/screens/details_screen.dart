import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../data/models/article_model.dart';
import 'webview_screen.dart';

class DetailsScreen extends StatelessWidget {
  final ArticleModel article;

  const DetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: Text(l10n.general, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
        children: [
          if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage!,
                height: 230,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const SizedBox(height: 230, child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          const SizedBox(height: 16),
          Text(article.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, height: 1.2)),
          const SizedBox(height: 8),
          Text(
            '${l10n.by} ${article.author ?? article.sourceName} • ${formatPublishedDate(article.publishedAt?.toIso8601String())}',
            style: TextStyle(fontSize: 11, color: Theme.of(context).hintColor),
          ),
          const SizedBox(height: 18),
          if (article.description != null) ...[
            Text(article.description!, style: const TextStyle(fontSize: 15, height: 1.55)),
            const SizedBox(height: 14),
          ],
          if (article.content != null && article.content!.isNotEmpty)
            Text(article.content!, style: const TextStyle(fontSize: 15, height: 1.55)),
          const SizedBox(height: 22),
          if (article.url != null && article.url!.isNotEmpty)
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WebViewScreen(url: article.url!, title: article.sourceName)),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l10n.viewFullArticle, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
        ],
      ),
    );
  }
}
