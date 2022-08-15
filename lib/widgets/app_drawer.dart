import 'package:amazon_lite/screens/order_screen.dart';
import 'package:amazon_lite/screens/products_overview_screen.dart';
import 'package:amazon_lite/screens/user_product_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello Friend"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              //Done a little jugaad wil rectify later
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverViewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.wallet_giftcard),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
