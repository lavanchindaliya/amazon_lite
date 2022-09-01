// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

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
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFFECEFF1),
                  blurRadius: 2.0,
                  //spreadRadius: 5.0,
                  offset: Offset(3, 3))
            ]),
        margin: EdgeInsets.all(8),
        // color: Colors.red,
        height: 10,
        width: 150,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Hero(
                tag: product.id,
                child: Image(
                  fit: BoxFit.cover,
                  height: 80,
                  width: 120,
                  image: NetworkImage(product.imageUrl),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Expanded(child: Text(""))
              ],
            ),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (ctx, i) =>
                          Icon(Icons.star, color: Colors.amber, size: 10)),
                ),
                Expanded(child: Text(''))
              ],
            ),
            Row(
              children: [
                Text(
                  "₹ ${product.price}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                Expanded(child: Text(""))
              ],
            ),
            Row(
              children: [
                Expanded(child: Text("")),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 15,
                  child: IconButton(
                      onPressed: () {
                        cart.addItem(product.price, product.id, product.title,
                            product.imageUrl);
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
                      icon: Icon(Icons.shopping_cart_rounded,
                          size: 15, color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
    //   ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: GridTile(
    //       child: GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
    //               arguments: product.id);
    //         },
    //         child: Hero(
    //           tag: product.id,
    //           child: FadeInImage(
    //             placeholder: AssetImage('assets/image/placeHolder.png'),
    //             image: NetworkImage(product.imageUrl),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       footer: GridTileBar(
    //         leading: Consumer<Product>(
    //           builder: (cxt, product, child) => IconButton(
    //             icon: Icon(
    //                 product.isFavorate ? Icons.favorite : Icons.favorite_border,
    //                 color: Colors.red),
    //             onPressed: () => {
    //               product.toggleFavorate(
    //                   product.id, authData.token, authData.userId)
    //             },
    //           ),
    //         ),
    //         trailing: IconButton(
    //             onPressed: () {
    //               cart.addItem(product.price, product.id, product.title);
    //               ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                 content: Text("Item added to cart"),
    //                 duration: Duration(seconds: 1),
    //                 action: SnackBarAction(
    //                   onPressed: () {
    //                     cart.removeSingleItem(product.id);
    //                   },
    //                   label: 'UNDO',
    //                 ),
    //               ));
    //             },
    //             icon: Icon(Icons.shopping_cart_outlined)),
    //         backgroundColor: Colors.black54,
    //         title: Text(
    //           product.title,
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
    //   );
  }
}
