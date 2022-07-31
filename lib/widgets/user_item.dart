import 'package:amazon_lite/screens/addproduct_screen.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String url;
  final String title;
  UserItem({required this.url, required this.title});
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
                  Navigator.of(context).pushNamed(AddEditProduct.routeName);
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {},
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
