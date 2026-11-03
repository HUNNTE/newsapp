import 'package:flutter/material.dart';
import '../models/article.dart';
import '../theme/app_theme.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surfaceColor,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium, vertical: AppTheme.spacingSmall),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          child: Row(
            children: [
              // Gambar dengan placeholder jika kosong
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: article.urlToImage != null
                    ? Image.network(article.urlToImage!, width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (_, _, _) => _placeholder())
                    : _placeholder(),
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, style: AppTheme.subtitleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${article.sourceName ?? 'Tidak Diketahui'} • ${_formatDate(article.publishedAt)}', style: AppTheme.bodyStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 100, height: 100, color: Colors.grey[300],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return '';
    return date.split('T').first; // Ambil tanggal saja
  }
}