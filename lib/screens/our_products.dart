import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
