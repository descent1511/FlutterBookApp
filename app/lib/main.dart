import 'package:app/rootApp.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signUpPage.dart';
import 'homePage.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootApp(), // Set the home to RootApp()
  ));
}