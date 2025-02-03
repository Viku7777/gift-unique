import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController {
  // instance of product list for cart
  RxList<NewProductModel> productList = RxList([]);
}
