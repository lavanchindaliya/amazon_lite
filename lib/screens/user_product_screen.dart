import 'package:amazon_lite/provider/products.dart';
import 'package:amazon_lite/screens/addproduct_screen.dart';
import 'package:amazon_lite/widgets/app_drawer.dart';
import 'package:amazon_lite/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProduct-screen';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).fetchAndSet();
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Prodcuts'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddEditProduct.routeName, arguments: "null");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) => UserItem(
                id: prodData.items[i].id,
                url: prodData.items[i].imageUrl,
                title: prodData.items[i].title),
            itemCount: prodData.items.length,
          ),
        ),
      ),
    );
  }
}
