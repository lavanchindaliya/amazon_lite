// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;
  final String imageUrl;

  BagItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      onDismissed: (direction) {
        cart.deleteItem(id);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content:
                        Text('Do you want to remove element form the cart'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No'))
                    ]));
      },
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.orange,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage(imageUrl),
              ),
            ),
            title: Text("${title}"),
            subtitle: Text("\$${price * quantity}"),
            trailing: Text("X${quantity}"),
          )),
    );
  }
}
