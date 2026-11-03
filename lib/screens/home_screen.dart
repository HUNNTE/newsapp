import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/state_views.dart';
import '../theme/app_theme.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Umum';
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = ['Umum', 'Bisnis', 'Olahraga', 'Teknologi'];

  @override
  void initState() {
    super.initState();
    // Memuat data saat layar pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berita Terkini'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          // Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Cari berita...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
              onSubmitted: (value) => context.read<NewsProvider>().fetchArticles(category: _selectedCategory, query: value),
            ),
          ),
          // Chip Kategori
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(label: Text(cat), selected: _selectedCategory == cat, onSelected: (selected) {
                    setState(() => _selectedCategory = cat);
                    context.read<NewsProvider>().fetchArticles(category: cat, query: _searchController.text);
                  }),
                );
              },
            ),
          ),
          // Daftar Berita
          Expanded(child: Consumer<NewsProvider>(
            builder: (context, provider, _) {
              if (provider.status == NewsStatus.loading) return const LoadingView();
              if (provider.status == NewsStatus.error) return ErrorView(message: provider.errorMessage ?? 'Error', onRetry: () => provider.fetchArticles(category: _selectedCategory, query: _searchController.text));
              if (provider.status == NewsStatus.empty) return const EmptyView();

              return RefreshIndicator(
                onRefresh: () => provider.fetchArticles(category: _selectedCategory, query: _searchController.text),
                child: ListView.builder(
                  itemCount: provider.articles.length,
                  itemBuilder: (context, index) {
                    final article = provider.articles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(article: article))),
                    );
                  },
                ),
              );
            },
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/bookmark');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favorit'),
        ],
      ),
    );
  }
}