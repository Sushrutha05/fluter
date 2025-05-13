import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  final String _apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

  Future<List<dynamic>> fetchBooks(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$query&key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items'] ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
