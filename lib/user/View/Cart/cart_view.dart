import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Components/Empty_View/cart_empty_view.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/View/Order/order_summary.dart';
import 'package:color_game/user/View/Shop/shop_screen_view.dart';
import '../../../export_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrderController(),
      builder: (controller) {
        return controller.userOrders.isEmpty
            ? CartEmptyView()
            : ListView(
                // padding: styleSheet.SPACING.PADDING_MEDIUM,
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Cart",
                        style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_16,
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Congratulations! You are qualified a ",
                      //       style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
                      //     ),
                      //     Text(
                      //       "FREE SHIPPING",
                      //       style: styleSheet.TEXT_Rubik.FS_MEDIUM_15,
                      //     ),
                      //   ],
                      // ),

                      styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                      const Divider(),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                      ListView.separated(
                          separatorBuilder: (context, i) => const Divider()
                              .paddingOnly(bottom: styleSheet.SPACING.medium),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.userOrders.length,
                          itemBuilder: (context, i) {
                            // OrderDetailsModel item = controller.userOrders[i];
                            OrderDetailsModel item = controller.userOrders[i];
                            NewProductModel product = productController
                                .allProducts
                                .firstWhere((e) => e.uuid == item.uuid);
                            return GestureDetector(
                              onTap: () {
                                Get.to(OrderSummaryView(
                                  price: item.variantPrice +
                                      productController.admindata.delivery,
                                  orderId: [item.orderId],
                                ));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              height: 110,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        styleSheet
                                                            .SPACING.medium),
                                              ),
                                              child: Image.network(
                                                product.images.first,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            styleSheet.SPACING.addWidth(
                                                styleSheet.SPACING.medium),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.title,
                                                    style: styleSheet.TEXT_Rubik
                                                        .FS_REGULAR_18,
                                                  ),
                                                  styleSheet.SPACING.addHeight(
                                                      styleSheet.SPACING.small),
                                                  Text(
                                                    "Select Size: ${item.variantName}",
                                                    style: styleSheet.TEXT_Rubik
                                                        .FS_REGULAR_12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller
                                                .removeOrder(item.orderId);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: styleSheet
                                                    .COLORS.GREY_LIGHT),
                                            child: Icon(
                                              Icons.delete,
                                              color:
                                                  styleSheet.COLORS.BLACK_COLOR,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  styleSheet.SPACING
                                      .addHeight(styleSheet.SPACING.medium),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Subtotal : ${item.variantPrice}"
                                                .toString(),
                                            style: styleSheet
                                                .TEXT_Rubik.FS_MEDIUM_16,
                                          ),
                                          Text(
                                            "Delivery charges : ${productController.admindata.delivery}"
                                                .toString(),
                                            style: styleSheet
                                                .TEXT_Rubik.FS_MEDIUM_16,
                                          ),
                                          Text(
                                            "total : ${item.variantPrice + productController.admindata.delivery}"
                                                .toString(),
                                            style: styleSheet
                                                .TEXT_Rubik.FS_MEDIUM_16,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  styleSheet.SPACING
                                      .addHeight(styleSheet.SPACING.medium),
                                ],
                              ),
                            );
                          }),
                      styleSheet.SPACING
                          .addHeight(styleSheet.SPACING.extraLarge),
                      Container(
                        padding: styleSheet.SPACING.PADDING_MEDIUM,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                          borderRadius: BorderRadius.circular(
                              styleSheet.SHAPES.RADIUS_MEDIUM),
                          color:
                              styleSheet.COLORS.ACTIVE_GREEN.withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Order",
                              style: styleSheet.TEXT_Rubik.FS_MEDIUM_18,
                            ),
                            styleSheet.SPACING
                                .addHeight(styleSheet.SPACING.medium),
                            Text("Taxes and shipping calculated at checkout",
                                style: styleSheet.TEXT_Rubik.FS_REGULAR_14),
                            styleSheet.SPACING
                                .addHeight(styleSheet.SPACING.medium),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("TOTAL:",
                                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_18),
                                Text(
                                    "Rs ${controller.userOrders.fold(0, (a, b) => a + (b.variantPrice + productController.admindata.delivery) as int)}",
                                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_18),
                              ],
                            ),
                            styleSheet.SPACING
                                .addHeight(styleSheet.SPACING.large),
                            CustomPrimaryBtnView(
                                    btnName: "PROCEED TO CHECKOUT",
                                    onPressed: () {
                                      Get.to(OrderSummaryView(
                                        price: controller.userOrders.fold(
                                            0,
                                            (a, b) =>
                                                a +
                                                (b.variantPrice +
                                                    productController
                                                        .admindata.delivery)),
                                        orderId: controller.userOrders
                                            .map((e) => e.orderId ?? "")
                                            .toList(),
                                      ));
                                    })
                                .paddingSymmetric(
                                    horizontal: styleSheet.SPACING.large),
                            styleSheet.SPACING
                                .addHeight(styleSheet.SPACING.small),
                            CustomPrimaryBtnView(
                                    bgColor: styleSheet.COLORS.WHITE,
                                    btnName: "CONTINUE SHOPPING",
                                    txtColor: styleSheet.COLORS.BLACK_COLOR,
                                    onPressed: () {
                                      Get.to(() => ShopScreenView());
                                    })
                                .paddingSymmetric(
                                    horizontal: styleSheet.SPACING.large),
                            styleSheet.SPACING
                                .addHeight(styleSheet.SPACING.small),
                            CustomPrimaryBtnView(
                                    bgColor: styleSheet.COLORS.WHITE,
                                    btnName: "Clear Cart",
                                    txtColor: styleSheet.COLORS.BLACK_COLOR,
                                    onPressed: () {
                                      controller.clearOrder();
                                    })
                                .paddingSymmetric(
                                    horizontal: styleSheet.SPACING.large),
                          ],
                        ),
                      ),
                      // styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

                      // Container(
                      //   padding: styleSheet.SPACING.PADDING_MEDIUM,
                      //   decoration: BoxDecoration(
                      //     border:
                      //         Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                      //     borderRadius: BorderRadius.circular(
                      //         styleSheet.SHAPES.RADIUS_MEDIUM),
                      //     color:
                      //         styleSheet.COLORS.ACTIVE_GREEN.withOpacity(0.1),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Add a Note",
                      //         style: styleSheet.TEXT_Rubik.FS_MEDIUM_18,
                      //       ),
                      //       Icon(
                      //         Icons.keyboard_arrow_right_rounded,
                      //         color: styleSheet.COLORS.BLACK_COLOR,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

                      // styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "Do you want to be among the first to know about sale time?",
                      //     style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_18,
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                    ],
                  ).paddingAll(styleSheet.SPACING.medium),
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                  BottomWidgetView()
                ],
              );
      },
    );
  }
}
