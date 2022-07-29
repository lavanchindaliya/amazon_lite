import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/cart_screen.dart';
import 'package:amazon_lite/screens/product_detail_screen.dart';
import 'package:amazon_lite/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amaxon',
        theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Lato'),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen()
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  String title;
  Home({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)));
  }
}
