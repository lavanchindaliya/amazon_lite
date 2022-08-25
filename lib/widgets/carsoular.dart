import 'package:flutter/material.dart';

class Carsouler extends StatelessWidget {
  String imageUrl;
  Carsouler({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: Image(image: AssetImage(imageUrl), fit: BoxFit.cover),
    );
  }
}
