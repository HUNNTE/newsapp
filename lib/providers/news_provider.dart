import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';

enum NewsStatus { loading, success, error, empty }

class NewsProvider extends ChangeNotifier {
  final NewsService _service;
  NewsStatus _status = NewsStatus.loading;
  List<Article> _articles = [];
  String? _errorMessage;

  NewsProvider(this._service);

  NewsStatus get status => _status;
  List<Article> get articles => _articles;
  String? get errorMessage => _errorMessage;

  // Fungsi async untuk mengambil data
  Future<void> fetchArticles({String? category, String? query}) async {
    _status = NewsStatus.loading;
    notifyListeners();

    try {
      _articles = await _service.fetchArticles(category: category, query: query);
      _status = _articles.isEmpty ? NewsStatus.empty : NewsStatus.success;
    } catch (e) {
      _status = NewsStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}