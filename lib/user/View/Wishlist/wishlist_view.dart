// ignore_for_file: must_be_immutable

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Components/Empty_View/wishlist_empty_view.dart';
import 'package:color_game/user/Utils/Controller/wishlist_controller.dart';
import 'package:color_game/user/View/Dashboard/Widgets/new_product_cart.dart';
import 'package:color_game/user/View/Dashboard/new_product_details_view.dart';

import '../../../export_widget.dart';

class WishlistView extends StatelessWidget {
  WishlistView({super.key});

  var wishlistController = Get.find<WishlistController>();
  var productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: wishlistController,
      builder: (controller) {
        return wishlistController.productList.isEmpty
            ? WishlistEmptyView()
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.68,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: wishlistController.productList.length,
                itemBuilder: (context, index) {
                  var pr = productController.allProducts.firstWhere(
                      (e) => e.uuid == wishlistController.productList[index]);
                  return productController.isloading
                      ? ProductCard(
                          product: productController.productList[index],
                        )
                      : GestureDetector(
                          onTap: () => Get.to(
                              () => NewProductDetailsView(productModel: pr)),
                          child: NewProductCardView(product: pr));
                },
              );
      },
    );
  }
}
