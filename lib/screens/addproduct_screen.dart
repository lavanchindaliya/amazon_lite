// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:amazon_lite/provider/product.dart';
import 'package:amazon_lite/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final _isvalidate = _form.currentState!.validate();
    if (!_isvalidate) return;
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
    Navigator.of(context).pop();
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
                  validator: (value) {
                    if (value!.isEmpty) return 'Please add title';
                    return null;
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
                  validator: (value) {
                    if (value!.isEmpty) return 'Please Enter the Price';
                    if (double.tryParse(value) == null)
                      return 'Please Enter a valid number';
                    if (double.parse(value) <= 0)
                      return 'Enter number greater than 0';
                    return null;
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
                  validator: (value) {
                    if (value!.isEmpty) return 'Please Enter the description';
                    if (value.length < 10)
                      return 'Enter atleast 10 characters mr lazy';
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
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please Enter The Image Url';
                          if (!value.startsWith('htttp') &&
                              !value.startsWith('https'))
                            return 'Please Enter a valid Url';
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('jpeg'))
                            return 'Please Enter a valid Url';
                          return null;
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
