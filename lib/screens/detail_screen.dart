import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../providers/bookmark_provider.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final isBookmarked = bookmarkProvider.isBookmarked(article);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => bookmarkProvider.toggleBookmark(article),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            const SizedBox(height: AppTheme.spacingMedium),
            Text(article.title, style: AppTheme.titleStyle),
            const SizedBox(height: AppTheme.spacingSmall),
            Text(
              'Oleh ${article.author ?? 'Anonim'} • ${article.sourceName ?? ''}',
              style: AppTheme.bodyStyle,
            ),
            const Divider(height: 32),
            Text(
              article.description ?? 'Tidak ada deskripsi.',
              style: AppTheme.bodyStyle.copyWith(
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            Text(article.content ?? '', style: AppTheme.bodyStyle),
            const SizedBox(height: AppTheme.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tahap integrasi API nanti
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Baca Selengkapnya'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
