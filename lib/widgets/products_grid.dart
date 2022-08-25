// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/widgets/Product_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool _showOnlyFav;
  ProductGrid(this._showOnlyFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = (_showOnlyFav) ? productData.favItems : productData.items;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(
                  // id: products[i].id,
                  // imageUrl: products[i].imageUrl,
                  // isFavorate: products[i].isFavorate,
                  // title: products[i].title
                  ),
            ));

    // GridView.builder(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2,
    //         childAspectRatio: 3 / 2,
    //         crossAxisSpacing: 10,
    //         mainAxisSpacing: 10),
    //     padding: EdgeInsets.all(10),
    //     itemCount: products.length,
    //     itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
    //           value: products[i],
    //           child: ProductItem(
    //               // id: products[i].id,
    //               // imageUrl: products[i].imageUrl,
    //               // isFavorate: products[i].isFavorate,
    //               // title: products[i].title
    //               ),
    //         ));
    // }
  }
}
