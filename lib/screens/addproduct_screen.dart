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
  final _imageUrlController = TextEditingController();
  final _imageUrlNode = FocusNode();

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlController.dispose();
    _imageUrlNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlNode.hasFocus) {
      setState(() {});
    }
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8, right: 10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: _imageUrlController.text.isEmpty
                      ? Text('Enter image Url')
                      : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(_imageUrlController.text)),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text("Image URL"),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
