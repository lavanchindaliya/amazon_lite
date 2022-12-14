import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void deleteItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  int get itemQuantity {
    return _items.length;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price,
              imageUrl: value.imageUrl));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void addItem(double price, String productId, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price,
              imageUrl: value.imageUrl));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: productId,
              title: title,
              quantity: 1,
              price: price,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  double get total {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
}
