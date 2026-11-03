import 'package:flutter/material.dart';
import '../models/article.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Article> _bookmarks = [];

  List<Article> get bookmarks => _bookmarks;

  // Menambah atau menghapus bookmark
  void toggleBookmark(Article article) {
    final index = _bookmarks.indexWhere((a) => a.title == article.title);
    if (index != -1) {
      _bookmarks.removeAt(index);
    } else {
      _bookmarks.add(article);
    }
    notifyListeners();
  }

  // Mengecek apakah artikel sudah di-bookmark
  bool isBookmarked(Article article) {
    return _bookmarks.any((a) => a.title == article.title);
  }
}