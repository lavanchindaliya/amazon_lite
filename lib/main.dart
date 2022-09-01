// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amazon_lite/provider/auth.dart';
import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/authScreen.dart';
import 'package:amazon_lite/screens/cart_screen.dart';
import 'package:amazon_lite/screens/addproduct_screen.dart';
import 'package:amazon_lite/screens/homeScreen.dart';
import 'package:amazon_lite/screens/order_screen.dart';
import 'package:amazon_lite/screens/our_products.dart';
import 'package:amazon_lite/screens/product_detail_screen.dart';
import 'package:amazon_lite/screens/products_overview_screen.dart';
import 'package:amazon_lite/screens/splashScreen.dart';
import 'package:amazon_lite/screens/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(icon: Icon(Icons.pages)),
      BottomNavigationBarItem(icon: Icon(Icons.pages)),
      BottomNavigationBarItem(icon: Icon(Icons.pages)),
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, null),
          update: (context, value, previous) =>
              Products(value.token, value.userId),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, value, previous) =>
                Orders(value.token, value.userId),
            create: (context) => Orders(null, null)),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amaxon',
          theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Lato'),
          home: auth.isAuthenticated
              ? Home()
              :
              //ProductOverViewScreen()
              FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
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

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    ProductOverViewScreen(),
    OurProducts(),
    OrderScreen(),
    CartScreen()
  ];
  var _currentPageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageindex = index;
            });
          },
          selectedIndex: _currentPageindex,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "home"),
            NavigationDestination(
                icon: Icon(Icons.dashboard), label: "products"),
            NavigationDestination(icon: Icon(Icons.backpack), label: 'order'),
            NavigationDestination(icon: Icon(Icons.local_mall), label: 'cart')
          ]),
      body: screens[_currentPageindex],
    );
  }
}
