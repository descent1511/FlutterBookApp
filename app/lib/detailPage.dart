import 'package:app/models/bookAPIs.dart';
import 'package:app/readingPage.dart';
import 'package:flutter/material.dart';
// Import the Book class from homePage.dart

class DetailPage extends StatelessWidget {
  final BookAPIs book;

  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
  padding: const EdgeInsets.all(20.0),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display book cover image
        Image.network(book.coverImageUrl),
        const SizedBox(height: 20),
        // Display book title
        Text(
          'Title: ${book.title}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Display book authors
        Text(
          'Authors: ${book.authors}',
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 10),
        // Display book description
        Text(
          'Description: ${book.description}',
          style: const TextStyle(fontSize: 16),
        ),
        ElevatedButton(
  onPressed: () {
  },
  child: const Text('Buy Now'),
),
      ],
    ),
  ),
),
    );
  }
}