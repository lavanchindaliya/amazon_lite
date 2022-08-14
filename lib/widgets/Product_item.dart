// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:amazon_lite/provider/auth.dart';
import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final bool isFavorate;
  // final String title;
  // final String id;

  // ProductItem(
  //     {required this.imageUrl,
  //     required this.isFavorate,
  //     required this.title,
  //     required this.id});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (cxt, product, child) => IconButton(
              icon: Icon(
                  product.isFavorate ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red),
              onPressed: () =>
                  {product.toggleFavorate(product.id, authData.token)},
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addItem(product.price, product.id, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Item added to cart"),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                    label: 'UNDO',
                  ),
                ));
              },
              icon: Icon(Icons.shopping_cart_outlined)),
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
