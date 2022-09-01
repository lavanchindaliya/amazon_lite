// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:amazon_lite/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    const TextStyle lightPart = TextStyle(
        color: Colors.blueGrey,
        fontFamily: "Manrope",
        fontWeight: FontWeight.w300,
        fontSize: 25);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                loadedProduct.title,
                style: lightPart,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  height: 300,
                  width: double.infinity,
                  child: Hero(
                      tag: loadedProduct.id,
                      child: Image.network(loadedProduct.imageUrl,
                          fit: BoxFit.cover))),
              SizedBox(
                height: 10,
              ),
              Text('₹ ${loadedProduct.price}',
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
