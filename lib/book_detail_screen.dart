import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volumeInfo = book['volumeInfo'];

    return Scaffold(
      appBar: AppBar(
        title: Text(volumeInfo['title'] ?? 'Book Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (volumeInfo['imageLinks'] != null)
              Image.network(volumeInfo['imageLinks']['thumbnail']),
            SizedBox(height: 16),
            Text(
              volumeInfo['title'] ?? 'No Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By ${volumeInfo['authors']?.join(', ') ?? 'Unknown Author'}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              volumeInfo['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            if (volumeInfo['previewLink'] != null)
              ElevatedButton(
                child: Text('Preview Book'),
                onPressed: () {
                  // Open link using browser
                  final url = volumeInfo['previewLink'];
                  // You can use url_launcher package here
                },
              ),
          ],
        ),
      ),
    );
  }
}
