// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/widgets/Product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurProducts extends StatelessWidget {
  static const TextStyle boldPart = TextStyle(
      fontFamily: "Manrope",
      fontWeight: FontWeight.w600,
      fontSize: 25,
      color: Colors.black);
  static const TextStyle lightPart = TextStyle(
      color: Colors.blueGrey,
      fontFamily: "Manrope",
      fontWeight: FontWeight.w300,
      fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: const [
                Text(
                  "Our ",
                  style: boldPart,
                ),
                Text(
                  'Products',
                  style: lightPart,
                ),
              ]),
              Consumer<Products>(
                builder: (context, prodData, _) => SingleChildScrollView(
                  child: Container(
                    height: 588,
                    child: GridView.builder(
                      itemCount: prodData.items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 4 / 5,
                              crossAxisCount: 2),
                      itemBuilder: (cxt, i) => ChangeNotifierProvider.value(
                        value: prodData.items[i],
                        child: ProductItem(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
