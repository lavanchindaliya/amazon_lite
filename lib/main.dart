import 'package:amazon_lite/provider/auth.dart';
import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/authScreen.dart';
import 'package:amazon_lite/screens/cart_screen.dart';
import 'package:amazon_lite/screens/addproduct_screen.dart';
import 'package:amazon_lite/screens/order_screen.dart';
import 'package:amazon_lite/screens/product_detail_screen.dart';
import 'package:amazon_lite/screens/products_overview_screen.dart';
import 'package:amazon_lite/screens/user_product_screen.dart';
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
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amaxon',
          theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Lato'),
          home: auth.isAuthenticated ? ProductOverViewScreen() : AuthScreen(),
          routes: {
            ProductOverViewScreen.routeName: (ctx) => ProductOverViewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            AddEditProduct.routeName: (ctx) => AddEditProduct()
          },
        ),
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
