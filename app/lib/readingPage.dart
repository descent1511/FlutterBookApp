import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:epubx/epubx.dart' as epubx;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingPage extends StatefulWidget {
  final String epubPath;

  ReadingPage({Key? key, required this.epubPath}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  List<String> _chapters = [];
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadBook();
    _loadProgress();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
        _saveProgress();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadBook() async {
    try {
      final bytes = await rootBundle.load(widget.epubPath);
      final epubBook =
          await epubx.EpubReader.readBook(bytes.buffer.asUint8List());

      final chapters = <String>[];
      for (var chapter in epubBook.Chapters ?? []) {
        chapters.add(chapter.HtmlContent);
      }

      setState(() {
        _chapters = chapters;
      });
    } catch (e) {
      print('Error reading .epub file: $e');
    }
  }

Future<void> _loadProgress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int page = prefs.getInt(widget.epubPath) ?? 0;
  _pageController.jumpToPage(page);
  // Delay the UI update to allow the page controller to complete the jump
  Future.delayed(Duration(milliseconds: 200), () {
    setState(() {
      _currentPage = page;
    });
  });
}

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.epubPath, _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Reading EPUB - Page ${_currentPage + 1}/${_chapters.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _chapters.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(_chapters[index]),
            ),
          );
        },
      ),
    );
  }
}
