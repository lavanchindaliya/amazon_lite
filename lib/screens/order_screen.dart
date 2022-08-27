// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:amazon_lite/provider/orders.dart' as ord;
import 'package:amazon_lite/widgets/app_drawer.dart';
import 'package:amazon_lite/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderScreen';
  static const TextStyle boldPart = TextStyle(
      fontFamily: "Manrope", fontWeight: FontWeight.w600, fontSize: 25);
  static const TextStyle lightPart = TextStyle(
      color: Colors.blueGrey,
      fontFamily: "Manrope",
      fontWeight: FontWeight.w300,
      fontSize: 25);

  @override
  Widget build(BuildContext context) {
    //final orderDate = Provider.of<ord.Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        body: SafeArea(
          child: FutureBuilder(
            future: Provider.of<ord.Orders>(context, listen: false)
                .fetchAndSetOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                if (snapshot.error != null) {
                  return Column(
                    children: [
                      Row(children: const [
                        Text(
                          "Your ",
                          style: boldPart,
                        ),
                        Text(
                          "order's",
                          style: lightPart,
                        ),
                      ]),
                      Center(
                        child: Text('An error occured'),
                      ),
                    ],
                  );
                } else {
                  return Consumer<ord.Orders>(
                    builder: (context, orderData, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(children: const [
                              Text(
                                "Your ",
                                style: boldPart,
                              ),
                              Text(
                                "order's",
                                style: lightPart,
                              ),
                            ]),
                            Container(
                              height: 580,
                              child: ListView.builder(
                                itemBuilder: (_, i) =>
                                    OrderItem(order: orderData.orders[i]),
                                itemCount: orderData.orders.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ));
  }
}
