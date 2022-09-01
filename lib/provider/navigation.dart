import 'package:flutter/cupertino.dart';

class Navigations with ChangeNotifier {
  var index = 0;

  void goToHome() {
    index = 0;
    notifyListeners();
  }

  void gotoProducts() {
    index = 1;
    notifyListeners();
  }

  void gotoOrders() {
    index = 2;
    notifyListeners();
  }

  void gotoCart() {
    index = 3;
    print("function called $index");
    notifyListeners();
  }
}
