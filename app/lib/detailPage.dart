import 'package:app/readingPage.dart';
import 'package:flutter/material.dart';
import 'package:app/homePage.dart'; // Import the Book class from homePage.dart

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({Key? key, required this.book}) : super(key: key);

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
        SizedBox(height: 20),
        // Display book title
        Text(
          'Title: ${book.title}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Display book authors
        Text(
          'Authors: ${book.authors}',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 10),
        // Display book description
        Text(
          'Description: ${book.description}',
          style: TextStyle(fontSize: 16),
        ),
        ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadingPage(book: book),
      ),
    );
  },
  child: const Text('Read'),
),
      ],
    ),
  ),
),
    );
  }
}
