import 'package:flutter/material.dart';
import 'package:color_game/admin/add_products.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/user/View/Dashboard/product_details_view.dart';

class AdminProductView extends StatefulWidget {
  const AdminProductView({super.key});

  @override
  State<AdminProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<AdminProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product View"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProductsView());
        },
        child: Icon(Icons.add),
      ),
      body: GetBuilder<AdminController>(
        builder: (controller) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 30,
              childAspectRatio: 0.68,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.allProducts.length,
            itemBuilder: (context, index) {
              var pr = controller.allProducts[index];
              return GestureDetector(
                  onTap: () {
                    Get.to(() => AddProductsView(
                          product: pr,
                        ));
                  },
                  child: AdminNewProductCard(product: pr));
            },
          );
        },
      ),
    );
  }
}
