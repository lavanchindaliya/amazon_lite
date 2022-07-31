// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AddEditProduct extends StatefulWidget {
  static const routeName = '/addEdit-screen';

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _priceNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(label: Text('Title')),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceNode);
              },
            ),
            TextField(
              decoration: InputDecoration(label: Text('Price')),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceNode,
            )
          ],
        ),
      )),
    );
  }
}
