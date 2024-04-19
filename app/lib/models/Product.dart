import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int id;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.id,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Book 1",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
  Product(
    id: 2,
    title: "Book 2",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
  Product(
    id: 3,
    title: "Book 3",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
  Product(
    id: 4,
    title: "Book 4",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
  Product(
    id: 5,
    title: "Book 5",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
  Product(
    id: 6,
    title: "Book 6",
    description: dummyText,
    image: "assets/images/book_1.png",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
