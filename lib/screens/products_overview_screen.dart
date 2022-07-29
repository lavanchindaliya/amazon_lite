// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/product.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/cart_screen.dart';
import 'package:amazon_lite/widgets/Product_item.dart';
import 'package:amazon_lite/widgets/app_widget.dart';
import 'package:amazon_lite/widgets/badge.dart';
import 'package:amazon_lite/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorates, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text(
            'amazon',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Favorates) {
                      _showOnlyFav = true;
                    } else {
                      _showOnlyFav = false;
                      //
                    }
                  });
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('only favorates'),
                        value: FilterOptions.Favorates,
                      ),
                      PopupMenuItem(
                        child: Text('show all'),
                        value: FilterOptions.All,
                      ),
                    ]),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                value: cart.itemQuantity.toString(),
                color: Colors.amber,
                child: ch!,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_bag)),
            )
          ],
        ),
        body: ProductGrid(_showOnlyFav));
  }
}
