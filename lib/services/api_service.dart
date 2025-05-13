import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  final String _apiKey = 'AIzaSyCIPaZzFJ6I6DOrp48beXHPPLKQcfhzUV4';

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
