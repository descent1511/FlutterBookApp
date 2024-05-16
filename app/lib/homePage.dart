import 'dart:convert';
import 'package:app/detailPage.dart';

import 'package:app/models/bookAPIs.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  const HomePage({super.key});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<BookAPIs> BookFromAPIs = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> fetchBooks(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=7'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'] ?? [];

      setState(() {
        BookFromAPIs = items.map((item) => BookAPIs.fromJson(item)).toList();


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

                itemCount: BookFromAPIs.length,

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

                          builder: (context) => DetailPage(book: BookFromAPIs[index]),

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

                              child: Image.network(BookFromAPIs[index].coverImageUrl),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              BookFromAPIs[index].title,

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




