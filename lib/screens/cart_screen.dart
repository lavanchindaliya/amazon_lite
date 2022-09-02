// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:amazon_lite/provider/cart.dart';
import 'package:amazon_lite/provider/orders.dart';
import 'package:amazon_lite/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  TextStyle boldPart = TextStyle(
      fontFamily: "Manrope", fontWeight: FontWeight.w600, fontSize: 25);
  TextStyle lightPart = TextStyle(
      color: Colors.blueGrey,
      fontFamily: "Manrope",
      fontWeight: FontWeight.w300,
      fontSize: 25);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
          child: Column(
            children: [
              Row(children: [
                Text(
                  "Your ",
                  style: boldPart,
                ),
                Text(
                  'cart',
                  style: lightPart,
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                child: Card(
                    child: cart.total <= 0
                        ? Center(
                            child: Image.asset('assets/image/emptyCart.png'))
                        : ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (_, i) => BagItem(
                                id: cart.items.values.toList()[i].id,
                                price: cart.items.values.toList()[i].price,
                                quantity:
                                    cart.items.values.toList()[i].quantity,
                                title: cart.items.values.toList()[i].title,
                                imageUrl:
                                    cart.items.values.toList()[i].imageUrl),
                          )),
              ),
              Expanded(child: Text("")),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFECEFF1),
                          offset: Offset(0, -5),
                          blurRadius: 5)
                    ],
                    //color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(10)),
                      width: 50,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        Text(
                          "₹ ${cart.total.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        )
                      ],
                    ),
                    Expanded(child: Text("")),
                    OrderButton(cart: cart)
                  ],
                ),
              )
              // Card(
              //   margin: EdgeInsets.all(20),
              //   child: Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Total"),
              //         Spacer(),
              //         Chip(label: Text('\$${cart.total.toStringAsFixed(2)}')),
              //         OrderButton(cart: cart)
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: widget.cart.total <= 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOrder(
                        widget.cart.items.values.toList(), widget.cart.total);
                    widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('ok'))
                              ],
                              title: Text("Order Placed"),
                              content: Text("go to order screens"),
                            ));

                    //Navigator.of(context).pushNamed(OrderScreen.routeName);
                  },
            child: Container(
              decoration: BoxDecoration(
                  color:
                      widget.cart.total < 1 ? Color(0xFFD6D6D6) : Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              width: double.infinity,
              height: 60,
              child: Center(
                  child: Text('Checkout',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white))),
            ));
  }
}
