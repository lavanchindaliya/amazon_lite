import 'package:amazon_lite/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final title =
        Provider.of<Products>(context, listen: false).findById(productId).title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
