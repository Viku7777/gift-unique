// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Utils/Controller/product_controller.dart';
import 'package:color_game/user/View/Dashboard/Widgets/new_product_cart.dart';
import 'package:color_game/user/View/Dashboard/Widgets/product_card.dart';
import 'package:color_game/user/View/Dashboard/new_product_details_view.dart';

class PopularProductListView extends StatelessWidget {
  PopularProductListView({super.key});
  var productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: productController,
      builder: (controller) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 30,
          childAspectRatio: 0.68,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          List<NewProductModel> allProducts = productController.allProducts;
          List productIndex = productController.indexOfProducts;
          var pr = allProducts.firstWhere((e) => e.uuid == productIndex[index]);
          return productController.isloading
              ? ProductCard(
                  product: productController.productList[index],
                )
              : GestureDetector(
                  onTap: () =>
                      Get.to(() => NewProductDetailsView(productModel: pr)),
                  child: NewProductCardView(product: pr));
        },
      ),
    );
  }
}
