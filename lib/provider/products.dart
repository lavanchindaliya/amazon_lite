// ignore_for_file: prefer_final_fields

import 'package:amazon_lite/models/http_exception.dart';
import 'package:amazon_lite/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  String? authToken;
  String? userId;
  Products(this.authToken, this.userId);
  List<Product> _items = [];

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

  Future<void> fetchAndSet([bool filterByUser = false]) async {
    final filterUrlString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    try {
      var url =
          'https://lite-144f1-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterUrlString';
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      url =
          "https://lite-144f1-default-rtdb.firebaseio.com/userFavorates/$userId/.json?auth=$authToken";
      final favorateResponse = await http.get(Uri.parse(url));
      final favorateData = json.decode(favorateResponse.body);

      List<Product> loadedProducts = [];
      if (extractedData.isEmpty) return;
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
            0,
            Product(
                id: prodId,
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'],
                imageUrl: prodData['imageUrl'],
                isFavorate: favorateData == null
                    ? false
                    : favorateData[prodId] ?? false));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeItem(String id) async {
    final url =
        "https://lite-144f1-default-rtdb.firebaseio.com/products/${id}.json?auth=$authToken";
    final _existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? _existingProduct = _items[_existingProductIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(_existingProductIndex, _existingProduct);
      notifyListeners();
      throw HttpException('Error occured while deleting the product');
    }
    _existingProduct = null;
  }

  Future<void> addProducts(Product newProdt) async {
    final url =
        "https://lite-144f1-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': newProdt.title,
            'price': newProdt.price,
            'description': newProdt.description,
            'imageUrl': newProdt.imageUrl,
            'id': DateTime.now().toString(),
            'creatorId': userId
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
          "https://lite-144f1-default-rtdb.firebaseio.com/products/${id}.json?auth=$authToken";
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
