import '../models/article.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'news_service.dart';

class MockNewsService implements NewsService {
  // Ganti nilai ini untuk menguji state: 'success', 'error', atau 'empty'
  String simulationState = 'success';

  @override
  Future<List<Article>> fetchArticles({String? category, String? query}) async {
    // Jeda buatan 1-2 detik untuk simulasi loading jaringan
    await Future.delayed(const Duration(seconds: 1));

    if (simulationState == 'error') {
      throw Exception('Gagal memuat berita. Periksa koneksi Anda.');
    }

    // Memuat data dari file JSON lokal
    final jsonString = await rootBundle.loadString('assets/mock/articles.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> articlesJson = jsonData['articles'];

    List<Article> articles = articlesJson.map((json) => Article.fromJson(json)).toList();

    // Simulasi filter kategori (sederhana)
    if (category != null && category != 'Umum') {
      articles = articles.where((a) => 
        a.sourceName?.toLowerCase().contains(category.toLowerCase()) ?? false
      ).toList();
    }

    // Simulasi pencarian
    if (query != null && query.isNotEmpty) {
      articles = articles.where((a) => 
        a.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    if (simulationState == 'empty' || articles.isEmpty) {
      return [];
    }

    return articles;
  }
}