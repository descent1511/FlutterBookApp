import 'package:app/homePage.dart';
import 'package:app/json/rootAppJson.dart';
import 'package:app/favoritePage.dart';
import 'package:app/profilePage.dart';
import 'package:app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Set background color
      bottomNavigationBar: getTabs(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        HomePage(),
        FavoritePage(),
        ProfilePage(),
      ],
    );
  }

  Widget getTabs() {
    return SalomonBottomBar(
      currentIndex: pageIndex,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      selectedItemColor: Colors.teal, // Set selected item color
      unselectedItemColor: Colors.grey, // Set unselected item color
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Add margin to bottom bar
      items: List.generate(rootAppJson.length, (index) {
        return SalomonBottomBarItem( // Set selected item indicator color
          icon: Icon(rootAppJson[index]['icon']),
          title: Text(rootAppJson[index]['text']),
        );
      }),
    );
  }
}
