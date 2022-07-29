import 'package:amazon_lite/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  BagItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.deleteItem(id);
      },
      key: ValueKey(id),
      background: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text("\$${price}")),
            ),
            title: Text("${title}"),
            subtitle: Text("\$${price * quantity}"),
            trailing: Text("X${quantity}"),
          )),
    );
  }
}
