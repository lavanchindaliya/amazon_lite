// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/screens/order_screen.dart';
import 'package:amazon_lite/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  TextStyle boldPart = TextStyle(
      fontFamily: "Manrope", fontWeight: FontWeight.w600, fontSize: 25);
  TextStyle lightPart = TextStyle(
      color: Colors.blueGrey,
      fontFamily: "Manrope",
      fontWeight: FontWeight.w300,
      fontSize: 25);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
                Text(
                  "Your ",
                  style: boldPart,
                ),
                Text(
                  'cart',
                  style: lightPart,
                ),
              ]),
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
                      OrderButton(cart: cart)
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
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.total <= 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOrder(
                        widget.cart.items.values.toList(), widget.cart.total);
                    widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pushNamed(OrderScreen.routeName);
                  },
            child: Text("ORDER NOW"));
  }
}
