import 'dart:convert';
import 'package:app/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> fetchBooks(String query) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];

      setState(() {
        books = items.map((item) => Book.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks('flutter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to the home page!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchBooks(_controller.text);
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(book: books[index]),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            // Display book cover image
                            Expanded(
                              child: Image.network(books[index].coverImageUrl),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              books[index].title,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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

class Book {
  final String title;
  final String coverImageUrl;
  final List<String> authors;
  final String description;

  Book({
    required this.title,
    required this.coverImageUrl,
    required this.authors,
    required this.description,
  });

factory Book.fromJson(Map<String, dynamic> json) {
  String title = json['volumeInfo']['title'] as String;
  List<String> titleWords = title.split(' ');
  if (titleWords.length > 6) {
    title = titleWords.take(6).join(' ') + '...';
  }

  List<String> authors = json['volumeInfo']['authors'] != null
      ? List<String>.from(json['volumeInfo']['authors'])
      : [];

  return Book(
    title: title,
    coverImageUrl: json['volumeInfo']['imageLinks'] != null
        ? json['volumeInfo']['imageLinks']['thumbnail'] as String
        : 'default_image_url_or_empty_string',
    authors: authors,
    description: json['volumeInfo']['description'] != null
        ? json['volumeInfo']['description'] as String
        : 'No description available',
  );
}

}
