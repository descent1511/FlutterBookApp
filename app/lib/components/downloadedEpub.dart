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

  @override
  void initState() {
    super.initState();
    loadEpubFiles();
  }

  Future<void> loadEpubFiles() async {
    try {
      final manifestContent =
          await rootBundle.loadString('AssetManifest.json');
      final manifestMap =
          json.decode(manifestContent) as Map<String, dynamic>;
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
        title: Text('Downloaded EPUBs'),
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
                  icon: Icon(Icons.open_in_new),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadingPage(),
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

  Future<void> _deleteEpubFile(String epubFile) async {
    try {
      final file = File(epubFile);
      await file.delete();
      setState(() {
        epubFiles.remove(epubFile);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('EPUB file deleted successfully.'),
        ),
      );
    } catch (e) {
      print('Error deleting EPUB file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete EPUB file.'),
        ),
      );
    }
  }
}
