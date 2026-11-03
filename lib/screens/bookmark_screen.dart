import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/state_views.dart';
import '../theme/app_theme.dart';
import 'detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel Favorit'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, _) {
          if (provider.bookmarks.isEmpty) return const EmptyView();
          return ListView.builder(
            itemCount: provider.bookmarks.length,
            itemBuilder: (context, index) {
              final article = provider.bookmarks[index];
              return ArticleCard(
                article: article,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(article: article))),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favorit'),
        ],
      ),
    );
  }
}