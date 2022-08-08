// ignore_for_file: prefer_final_fields

import 'package:amazon_lite/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     isFavorate: false),
    // Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     isFavorate: false),
    // Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //     isFavorate: false),
    // Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //     isFavorate: false),
  ];

  var _showFavoratesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFavorate).toList();
  }

  // void showFavorates() {
  //   _showFavoratesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoratesOnly = false;
  //   notifyListeners();
  // }]]

  Future<void> fetchAndSet() async {
    try {
      const url =
          'https://lite-144f1-default-rtdb.firebaseio.com/products.json';
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorate: prodData['isFavorate']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void removeItem(String id) {
    final url =
        "https://lite-144f1-default-rtdb.firebaseio.com/products/${id}.json";
    http.delete(Uri.parse(url));
    _items.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  Future<void> addProducts(Product newProdt) async {
    const url = "https://lite-144f1-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': newProdt.title,
            'price': newProdt.price,
            'description': newProdt.description,
            'imageUrl': newProdt.imageUrl,
            'isFavorate': newProdt.isFavorate,
            'id': DateTime.now().toString()
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: newProdt.title,
          description: newProdt.description,
          price: newProdt.price,
          imageUrl: newProdt.imageUrl,
          isFavorate: newProdt.isFavorate);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProducts(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://lite-144f1-default-rtdb.firebaseio.com/products/${id}.json";
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'isFavorate': newProduct.isFavorate
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else
      print('error in products.dart file');
    notifyListeners();
  }

  Product findById(id) {
    return items.firstWhere((prod) => prod.id == id);
  }
}
