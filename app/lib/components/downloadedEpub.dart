import 'dart:convert';
import 'dart:io';

import 'package:app/readingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class DownloadedEpub extends StatefulWidget {
  @override
  _DownloadedEpubState createState() => _DownloadedEpubState();
}

class _DownloadedEpubState extends State<DownloadedEpub> {
  List<String> epubFiles = [];
  Set<String> favoriteFiles = {};

  @override
  void initState() {
    super.initState();
    loadEpubFiles();
  }

  Future<void> loadEpubFiles() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifestMap = json.decode(manifestContent) as Map<String, dynamic>;
      final epubPaths = manifestMap.keys.where((String key) =>
          key.contains('assets/books/') && key.endsWith('.epub'));
      setState(() {
        epubFiles = epubPaths.toList();
      });
    } catch (e) {
      print('Error loading .epub files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Set app bar background color
        title: const Text(
          'Downloaded Books',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        elevation: 0, // Remove app bar elevation
      ),
      body: Container(
        color: Colors.teal[50], // Set container color lighter than app bar
        child: ListView.builder(
          itemCount: epubFiles.length,
          itemBuilder: (context, index) {
            final epubFile = epubFiles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingPage(epubPath: epubFile),
                  ),
                );
              },
              child: Card(
                elevation: 2, // Add elevation for a card-like effect
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  tileColor: Colors.white, // Set list tile background color
                  title: Text(
                    path.basenameWithoutExtension(epubFile),
                    style: const TextStyle(
                        color: Colors.black87), // Set text color to black
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.teal, // Set icon color to teal
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
