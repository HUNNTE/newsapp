import '../models/article.dart';

// Kelas abstrak sebagai titik sambung. UI tidak boleh tahu ini Mock atau API.
abstract class NewsService {
  Future<List<Article>> fetchArticles({String? category, String? query});
}