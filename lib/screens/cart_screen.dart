// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/screens/order_screen.dart';
import 'package:amazon_lite/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out",
            style: TextStyle(
              color: Colors.black54,
            )),
        backgroundColor: Colors.teal[200],
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  Spacer(),
                  Chip(label: Text('\$${cart.total.toStringAsFixed(2)}')),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cart.items.values.toList(), cart.total);
                        cart.clear();
                        Navigator.of(context).pushNamed(OrderScreen.routeName);
                      },
                      child: Text("ORDER NOW"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Card(
                child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, i) => BagItem(
                  id: cart.items.values.toList()[i].id,
                  price: cart.items.values.toList()[i].price,
                  quantity: cart.items.values.toList()[i].quantity,
                  title: cart.items.values.toList()[i].title),
            )),
          ),
        ],
      ),
    );
  }
}
