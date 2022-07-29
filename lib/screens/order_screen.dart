// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/orders.dart' as ord;
import 'package:amazon_lite/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderScreen';
  @override
  Widget build(BuildContext context) {
    final orderDate = Provider.of<ord.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => OrderItem(order: orderDate.orders[i]),
        itemCount: orderDate.orders.length,
      ),
    );
  }
}
