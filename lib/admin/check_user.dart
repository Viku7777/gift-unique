import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  var controller = Get.find<AdminController>();
  @override
  void initState() {
    controller.getWishlistProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wishlist View"),
        ),
        body: GetBuilder<AdminController>(
          builder: (controller) {
            if (controller.loading) {
              return Container(
                color: Colors.black38,
                alignment: Alignment.center,
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 50,
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.wishlistItem.length,
                itemBuilder: (context, index) {
                  List<OrderDetailsModel> data0 =
                      controller.wishlistItem.reversed.toList();
                  OrderDetailsModel item = data0[index];
                  return Column(
                    children: [
                      ExpansionTile(
                          childrenPadding: EdgeInsetsDirectional.all(10),
                          title: Text(controller.allProducts
                              .firstWhere((e) => e.uuid == item.uuid)
                              .title),
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Varient")),
                                Expanded(flex: 2, child: Text(item.variantName))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Address")),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${item.address},${item.landmark},"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Amount")),
                                Expanded(
                                    flex: 2,
                                    child: Text("${item.variantPrice}/-"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Date ")),
                                Expanded(
                                    flex: 2,
                                    child: Text(DateFormat("DD-MM-y").format(
                                        DateTime.parse(item.dateofAdd!))))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Contact ")),
                                Expanded(
                                    flex: 2,
                                    child: Text(item.number.toString()))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      controller.deleteWishlist(item);
                                    },
                                    child: Text("Delete"))
                              ],
                            )
                          ])
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
