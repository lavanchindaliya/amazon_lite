// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:amazon_lite/provider/product.dart';
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
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: '',
      title: '',
      description: '',
      price: 0,
      imageUrl: '',
      isFavorate: false);

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceNode.dispose();
    _descriptionNode.dispose();
    //_imageUrlController.dispose();
    _imageUrlNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState!.save();
    print(_editedProduct.id);
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  _saveForm();
                },
                icon: Icon(
                  Icons.save,
                )),
          )
        ],
        title: Text('Edit Products'),
      ),
      body: Form(
          key: _form,
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
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: value!,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorate: _editedProduct.isFavorate);
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
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value!),
                        description: _editedProduct.description,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorate: _editedProduct.isFavorate);
                  },
                ),
                TextFormField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(label: Text('Description')),
                  focusNode: _descriptionNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value!,
                        id: _editedProduct.id,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorate: _editedProduct.isFavorate);
                  },
                ),
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
                          : Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Image URL"),
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: value!,
                              id: _editedProduct.id,
                              imageUrl: _editedProduct.imageUrl,
                              isFavorate: _editedProduct.isFavorate);
                        },
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
