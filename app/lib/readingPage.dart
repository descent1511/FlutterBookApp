import 'package:app/homePage.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatelessWidget {
  final Book book;

  const ReadingPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading ${book.title}'),
      ),
      body: Center(
        child: Text('Reading content goes here'),
      ),
    );
  }
}