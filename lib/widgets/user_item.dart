import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/addproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final String id;
  final String url;
  final String title;
  UserItem({required this.url, required this.title, required this.id});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddEditProduct.routeName, arguments: id);
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).removeItem(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
