// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/product.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/cart_screen.dart';
import 'package:amazon_lite/widgets/Product_item.dart';
import 'package:amazon_lite/widgets/app_drawer.dart';
import 'package:amazon_lite/widgets/badge.dart';
import 'package:amazon_lite/widgets/carsoular.dart';
import 'package:amazon_lite/widgets/products_grid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorates, All }

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  TextStyle boldPart = TextStyle(
      fontFamily: "Manrope", fontWeight: FontWeight.w600, fontSize: 20);
  TextStyle lightPart = TextStyle(
      color: Colors.blueGrey,
      fontFamily: "Manrope",
      fontWeight: FontWeight.w300,
      fontSize: 20);

  var _isLoading = false;
  var _showOnlyFav = false;
  List<Carsouler> carouselList = [
    Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_one.jpg"),
    Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_two.jpg"),
    Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_three.jpg"),
    Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_four.jpg")
  ];
  @override
  void initState() {
    _isLoading = true;
    Provider.of<Products>(context, listen: false).fetchAndSet().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
        child: Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                  value: cart.itemQuantity.toString(),
                  color: Colors.amber,
                  child: ch!,
                ),
            child: Container(
                child: Icon(
              Icons.shopping_bag,
              size: 40,
              color: Colors.white,
            ))),
      ),

      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Image(
            image: AssetImage("assets/image/logo.jpg"), height: 80, width: 120),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white))
        ],
      ),

      // AppBar(
      //   backgroundColor: Colors.teal[200],
      //   title: Text(
      //     'amazon',
      //     style: TextStyle(color: Colors.black54),
      //   ),
      //   actions: [
      //     PopupMenuButton(
      //         onSelected: (FilterOptions selectedValue) {
      //           setState(() {
      //             if (selectedValue == FilterOptions.Favorates) {
      //               _showOnlyFav = true;
      //             } else {
      //               _showOnlyFav = false;
      //               //
      //             }
      //           });
      //         },
      //         icon: Icon(Icons.more_vert),
      //         itemBuilder: (_) => [
      //               PopupMenuItem(
      //                 child: Text('only favorates'),
      //                 value: FilterOptions.Favorates,
      //               ),
      //               PopupMenuItem(
      //                 child: Text('show all'),
      //                 value: FilterOptions.All,
      //               ),
      //             ]),
      //     Consumer<Cart>(
      //       builder: (_, cart, ch) => Badge(
      //         value: cart.itemQuantity.toString(),
      //         color: Colors.amber,
      //         child: ch!,
      //       ),
      //       child: IconButton(
      //           onPressed: () {
      //             Navigator.of(context).pushNamed(CartScreen.routeName);
      //           },
      //           icon: Icon(Icons.shopping_bag)),
      //     )
      //   ],
      // ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.black,
                      height: 10,
                    ),
                    Container(
                      color: Colors.black,
                      child: CarouselSlider(
                          items: carouselList,
                          options:
                              CarouselOptions(autoPlay: true, height: 200)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // RichText(
                          //     text: TextSpan(children: [
                          //   TextSpan(text: "New ", style: boldPart),
                          //   TextSpan(text: "Arrivals", style: lightPart)
                          // ])),
                          Row(children: [
                            Text(
                              "New ",
                              style: boldPart,
                            ),
                            Text(
                              'Arrivals',
                              style: lightPart,
                            ),
                          ]),
                          Text("see more ->",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blueGrey,
                                  fontStyle: FontStyle.italic))
                        ],
                      ),
                    ),
                    Container(
                        // color: Colors.red,
                        height: 234,
                        width: 600,
                        child: ProductGrid(_showOnlyFav))
                  ],
                ),
              ),
            ),
    );
  }
}
