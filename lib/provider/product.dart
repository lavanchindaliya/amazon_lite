import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorate;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.isFavorate});

  Future<void> toggleFavorate(String id) async {
    isFavorate = !isFavorate;
    notifyListeners();
    try {
      final url =
          "https://lite-144f1-default-rtdb.firebaseio.com/products/${id}.";
      final respose = await https.get(
        Uri.parse(url),
      );
      await https.patch(Uri.parse(url),
          body: json.encode(
              {'isFavorate': !json.decode(respose.body)['isFavorate']}));
    } catch (_) {
      isFavorate = !isFavorate;
      notifyListeners();
    }
  }
}
