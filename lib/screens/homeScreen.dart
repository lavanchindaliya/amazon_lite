// ignore_for_file: file_names

import 'package:amazon_lite/widgets/carsoular.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Carsouler> carouselList = [
      Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_one.jpg"),
      Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_two.jpg"),
      Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_three.jpg"),
      Carsouler(imageUrl: "assets/image/calsoular_images/carsoular_four.jpg")
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Image(
            image: AssetImage("assets/image/logo.jpg"), height: 80, width: 120),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white))
        ],
      ),
      body: SafeArea(
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
                    options: CarouselOptions(autoPlay: true, height: 200)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("New arrivals"), Text("see more")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
