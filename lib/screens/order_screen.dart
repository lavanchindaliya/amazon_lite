// ignore_for_file: prefer_const_constructors

import 'package:amazon_lite/provider/orders.dart' as ord;
import 'package:amazon_lite/widgets/app_drawer.dart';
import 'package:amazon_lite/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderScreen';

  @override
  Widget build(BuildContext context) {
    //final orderDate = Provider.of<ord.Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your orders'),
        ),
        body: FutureBuilder(
          future: Provider.of<ord.Orders>(context, listen: false)
              .fetchAndSetOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              if (snapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                return Consumer<ord.Orders>(
                  builder: (context, orderData, _) {
                    return ListView.builder(
                      itemBuilder: (_, i) =>
                          OrderItem(order: orderData.orders[i]),
                      itemCount: orderData.orders.length,
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
