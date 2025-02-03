// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/user/View/Order/tracking_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var loggedInNumber = TextEditingController();

class TrackOrderView extends StatefulWidget {
  const TrackOrderView({super.key});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  var product = Get.find<ProductController>();

  @override
  void initState() {
    if (loggedInNumber.text.isNotEmpty) {
      Get.find<OrderController>().getOrders(number: loggedInNumber.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(),
        body: GetBuilder<OrderController>(
          builder: (controller) => controller.loading
              ? Container(
                  color: Colors.black38,
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                    Text(
                      "Your Order",
                      style: styleSheet.TEXT_CONDENSED.FS_BOLD_22,
                    ).paddingOnly(left: styleSheet.SPACING.medium),
                    (controller.userSubmitOrder.isEmpty ||
                            loggedInNumber.text.isEmpty)
                        ? SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                styleSheet.SPACING
                                    .addHeight(styleSheet.SPACING.large),
                                CustomTextfieldView(
                                  controller: loggedInNumber,
                                  onTap: () {
                                    if (loggedInNumber.text.isNotEmpty) {
                                      Get.find<OrderController>().getOrders(
                                          number: loggedInNumber.text);
                                    }
                                  },
                                  hintText: "Enter your Number Number",
                                ).paddingSymmetric(
                                    horizontal: styleSheet.SPACING.large),
                                styleSheet.SPACING
                                    .addHeight(styleSheet.SPACING.large),
                              ],
                            ))
                        : ListView.separated(
                            padding: styleSheet.SPACING.PADDING_MEDIUM,
                            separatorBuilder: (context, i) => const Divider()
                                .paddingOnly(bottom: styleSheet.SPACING.medium),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.userSubmitOrder.length,
                            itemBuilder: (context, i) {
                              List<OrderDetailsModel> userSubmitOrder =
                                  controller.userSubmitOrder;

                              userSubmitOrder =
                                  userSubmitOrder.reversed.toList();
                              OrderDetailsModel orderDetails =
                                  userSubmitOrder[i];
                              NewProductModel item = product.allProducts
                                  .firstWhere(
                                      (e) => e.uuid == orderDetails.uuid);
                              return GestureDetector(
                                onTap: () => Get.to(TrackingScreenView(
                                  item: orderDetails,
                                  image: item.images.first,
                                  title: item.title,
                                )),
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
                                                  item.images.first,
                                                  fit: BoxFit.cover,
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
                                                      item.title,
                                                      style: styleSheet
                                                          .TEXT_Rubik
                                                          .FS_REGULAR_18,
                                                    ),
                                                    styleSheet.SPACING
                                                        .addHeight(styleSheet
                                                            .SPACING.small),
                                                    Text(
                                                      "Select Size: ${orderDetails.variantName}",
                                                      style: styleSheet
                                                          .TEXT_Rubik
                                                          .FS_REGULAR_12,
                                                    ),
                                                    styleSheet.SPACING
                                                        .addHeight(styleSheet
                                                            .SPACING.small),
                                                    Text(
                                                      "Rs. ${orderDetails.finalPrice}"
                                                          .toString(),
                                                      style: styleSheet
                                                          .TEXT_Rubik
                                                          .FS_MEDIUM_16,
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
                                            onTap: () {},
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: styleSheet
                                                      .COLORS.GREY_LIGHT),
                                              child: Icon(
                                                Icons.track_changes,
                                                color: styleSheet
                                                    .COLORS.BLACK_COLOR,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    styleSheet.SPACING
                                        .addHeight(styleSheet.SPACING.medium),
                                  ],
                                ),
                              );
                            }),
                    BottomWidgetView()
                  ],
                ),
        ));
  }
}
