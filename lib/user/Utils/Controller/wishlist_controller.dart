import 'package:color_game/export_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/product_model.dart';

class WishlistController extends GetxController {
  // instance of product list for cart
  List<String> productList = [];

  addOrder(String productID) async {
    bool available = false;
    for (var element in productList) {
      if (element == productID) {
        available = true;
      }
    }
    if (available) {
      productList.removeWhere((e) => e == productID);
    } else {
      productList.add(productID);
    }
    update();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("wishList", productList);
  }

  @override
  void onInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartprodcuts = prefs.getStringList("wishList");
    if (cartprodcuts != null && cartprodcuts.isNotEmpty) {
      productList = cartprodcuts;
      update();
    }
    super.onInit();
  }
}
