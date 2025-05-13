import 'package:book_search_app/BookSearchScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set primary color for app
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookSearchScreen(),
    );
  }
}
