// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/orders.dart' as ord;
import 'package:amazon_lite/widgets/app_widget.dart';
import 'package:amazon_lite/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ord.Orders>(context, listen: false)
        .fetchAndSetOrder()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderDate = Provider.of<ord.Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (_, i) => OrderItem(order: orderDate.orders[i]),
              itemCount: orderDate.orders.length,
            ),
    );
  }
}
