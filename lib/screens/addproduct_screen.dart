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

  var _isInit = true;
  var _inItValues = {'title': '', 'description': '', 'price': ''};
  var _isloading = false;

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != "null") {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        _inItValues['title'] = _editedProduct.title;
        _inItValues['description'] = _editedProduct.description;
        _inItValues['price'] = _editedProduct.price.toString();
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

  Future<void> _saveForm() async {
    final _isvalidate = _form.currentState!.validate();
    if (!_isvalidate) return;
    _form.currentState!.save();
    setState(() {
      _isloading = true;
    });
    if (_editedProduct.id != "") {
      await Provider.of<Products>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occured'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('ok'))
                  ],
                ));
      }
      // finally {
      //   setState(() {
      //     _isloading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isloading = false;
    });
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
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _inItValues['title'],
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
                        initialValue: _inItValues['price'],
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
                        initialValue: _inItValues['description'],
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
                          if (value!.isEmpty)
                            return 'Please Enter the description';
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
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter image Url')
                                : Image(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(_imageUrlController.text),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              //initialValue: _imageUrlController.text,
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
                                    description: _editedProduct.description,
                                    id: _editedProduct.id,
                                    imageUrl: value!,
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
