// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditProduct extends StatefulWidget {
  static const routeName = '/addEdit-screen';

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();

  @override
  void dispose() {
    _priceNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }

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
            TextFormField(
              decoration: InputDecoration(label: Text('Title')),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: Text('Price')),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionNode);
              },
            ),
            TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(label: Text('Description')),
                focusNode: _descriptionNode),
          ],
        ),
      )),
    );
  }
}
