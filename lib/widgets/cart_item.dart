import 'package:flutter/material.dart';

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
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text("\$${price}")),
          ),
          title: Text("${title}"),
          subtitle: Text("\$${price * quantity}"),
          trailing: Text("X${quantity}"),
        ));
  }
}
