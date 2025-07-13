import 'dart:collection';

import 'package:dio/dio.dart';

import 'home_models.dart';
class BookRepository {
  final Dio _dio = Dio();

  Future<List<BookModel>> fetchBooks(String query) async {
    final String url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&filter=free-ebooks&orderBy=newest';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List items = response.data['items'] ?? [];
        return items.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Dio error: $e');
    }
  }

  Future<List<String>> fetchCategories() async {
    final books = await fetchBooks("computer");
    final allCategories = books.expand((book) => book.categories).toList();
    return LinkedHashSet<String>.from(allCategories).toList();
  }
}
