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

  void toggleFavorite(String epubFile) {
    setState(() {
      if (favoriteFiles.contains(epubFile)) {
        favoriteFiles.remove(epubFile);
      } else {
        favoriteFiles.add(epubFile);
      }
    });
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
        title: Text('Downloaded books'),
      ),
      body: ListView.builder(
        itemCount: epubFiles.length,
        itemBuilder: (context, index) {
          final epubFile = epubFiles[index];
          return ListTile(
            title: Text(path.basenameWithoutExtension(epubFile)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(favoriteFiles.contains(epubFile)
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => toggleFavorite(epubFile),
                ),
                IconButton(
                  icon: Icon(Icons.open_in_new),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadingPage(epubPath: epubFile),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
