import 'dart:convert';

import 'package:amazon_lite/provider/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    const url = 'https://lite-144f1-default-rtdb.firebaseio.com/order.json';
    final response = await https.get(Uri.parse(url));
    List<OrderItem> loadedOrder = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) return;
    extractedData.forEach((orderId, orderData) {
      loadedOrder.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['listOfItems'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://lite-144f1-default-rtdb.firebaseio.com/order.json';
    final timeStamp = DateTime.now();
    final response = await https.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'listOfItems': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));
    await fetchAndSetOrder();
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp));
    notifyListeners();
  }
}
