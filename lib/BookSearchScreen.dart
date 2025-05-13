import 'package:book_search_app/book_detail_screen.dart';
import 'package:book_search_app/services/api_service.dart';
import 'package:flutter/material.dart';

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> books = [];
  bool isLoading = false;

  // Function to search books based on user input
  void searchBooks(String query) async {
    if (query.isEmpty) {
      setState(() {
        books = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await apiService.fetchBooks(query);
      setState(() {
        books = result;
      });
    } catch (e) {
      setState(() {
        books = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (query) {
                searchBooks(query);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                hintText: 'Search for books...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),

            // Loading Indicator
            if (isLoading)
              Center(child: CircularProgressIndicator()),

            // No Results Found UI
            if (books.isEmpty && !isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.red),
                    SizedBox(height: 10),
                    Text('No books found, please try again.', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),

            // Book List
            if (!isLoading && books.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    var book = books[index];
                    return Card(
                      elevation: 8,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Image.network(
                          book['volumeInfo']['imageLinks'] != null
                              ? book['volumeInfo']['imageLinks']['thumbnail'] ?? ''
                              : '',
                          height: 50,
                          width: 50,
                        ),
                        title: Text(
                          book['volumeInfo']['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(book['volumeInfo']['authors']?.join(', ') ?? 'Unknown'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(book: book),
                            ),
                          );
                        },

                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
