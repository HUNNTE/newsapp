import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/news_service.dart';
import 'services/mock_news_service.dart';
import 'providers/news_provider.dart';
import 'providers/bookmark_provider.dart';
import 'screens/home_screen.dart';
import 'screens/bookmark_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Inisialisasi NewsService (Tahap front end pakai Mock)
  final NewsService newsService = MockNewsService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider(newsService)),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        colorSchemeSeed: AppTheme.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
      ),
      home: const HomeScreen(),
      routes: {
        '/bookmark': (context) => const BookmarkScreen(),
      },
    );
  }
}