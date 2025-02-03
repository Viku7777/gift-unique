// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/export_widget.dart';

class TrackingScreenView extends StatefulWidget {
  OrderDetailsModel item;
  String image;
  String title;
  TrackingScreenView(
      {required this.item,
      super.key,
      required this.image,
      required this.title});

  @override
  State<TrackingScreenView> createState() => _TrackingScreenViewState();
}

class _TrackingScreenViewState extends State<TrackingScreenView> {
  var activeStep = 2;
  String status = "";

  @override
  void initState() {
    status = widget.item.status ?? "";
    log(status);
    if (status == OrderStatusType.paymentpending.name ||
        status == "payment_failed") {
      activeStep = 0;
    } else if (status == OrderStatusType.paymentdone.name) {
      activeStep = 1;
    } else if (status == OrderStatusType.orderOntheway.name) {
      activeStep = 2;
    } else if (status == OrderStatusType.outforDelivery.name) {
      activeStep = 2;
    } else {
      activeStep = 4;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.item.status ?? "");
    return Scaffold(
      appBar: customAppbar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyStepper(
                enableStepTapping: false,
                activeStep: activeStep,
                lineStyle: LineStyle(
                    lineThickness: 6,
                    lineLength: 50,
                    lineSpace: 0,
                    lineType: LineType.normal,
                    defaultLineColor: styleSheet.COLORS.GREY_LIGHT,
                    finishedLineColor: styleSheet.COLORS.BTN_PRIMARY),
                activeStepTextColor: Colors.black87,
                // finishedStepTextColor: Colors.black87,
                internalPadding: 0,
                showLoadingAnimation: false,
                stepRadius: 30,
                padding: EdgeInsets.zero,
                showStepBorder: false,
                steps: [
                  EasyStep(
                    customStep: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeStep >= 0
                              ? styleSheet.COLORS.BTN_PRIMARY
                              : styleSheet.COLORS.WHITE),
                      child:
                          SvgPicture.asset(styleSheet.ICONS.ORDER_PLACED_SVG),
                    ),
                    title: 'Order Placed',
                  ),
                  EasyStep(
                    customStep: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeStep >= 1
                              ? styleSheet.COLORS.BTN_PRIMARY
                              : styleSheet.COLORS.WHITE),
                      child: SvgPicture.asset(
                        styleSheet.ICONS.ORDER_CONFIRMED_SVG,
                        color: activeStep >= 1
                            ? styleSheet.COLORS.WHITE
                            : styleSheet.COLORS.BLACK_COLOR,
                      ),
                    ),
                    title: 'Order Confirmed',
                  ),
                  EasyStep(
                    customStep: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeStep >= 2
                              ? styleSheet.COLORS.BTN_PRIMARY
                              : styleSheet.COLORS.WHITE),
                      child: SvgPicture.asset(styleSheet.ICONS.ON_DELIVERY_SVG,
                          color: activeStep >= 2
                              ? styleSheet.COLORS.WHITE
                              : styleSheet.COLORS.BLACK_COLOR),
                    ),
                    title: 'On Delivery',
                  ),
                  EasyStep(
                    customStep: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeStep >= 3
                              ? styleSheet.COLORS.BTN_PRIMARY
                              : styleSheet.COLORS.WHITE),
                      child: SvgPicture.asset(
                          styleSheet.ICONS.ORDER_DELIVERED_SVG,
                          color: activeStep >= 3
                              ? styleSheet.COLORS.WHITE
                              : styleSheet.COLORS.BLACK_COLOR),
                    ),
                    title: 'Order Delivered',
                  ),
                ],
                onStepReached: (index) => setState(() => activeStep = index),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "ORDER DETAILS",
                style: styleSheet.TEXT_CONDENSED.FS_BOLD_22,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [styleSheet.SHAPES.DEFAULT_SHADOW],
                    color: styleSheet.COLORS.WHITE,
                    borderRadius:
                        BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius: BorderRadius.circular(
                                      styleSheet.SPACING.medium),
                                ),
                                child: Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              styleSheet.SPACING
                                  .addWidth(styleSheet.SPACING.medium),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: styleSheet.TEXT_Rubik.FS_REGULAR_18,
                                  ),
                                  styleSheet.SPACING
                                      .addHeight(styleSheet.SPACING.small),
                                  Text(
                                    "Select Size: ${widget.item.variantName}",
                                    style: styleSheet.TEXT_Rubik.FS_REGULAR_12,
                                  ),
                                  styleSheet.SPACING
                                      .addHeight(styleSheet.SPACING.small),
                                  Text(
                                    "Rs. ${widget.item.finalPrice}".toString(),
                                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                                  ),
                                ],
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
                                  color: styleSheet.COLORS.GREY_LIGHT),
                              child: Icon(
                                Icons.track_changes,
                                color: styleSheet.COLORS.BLACK_COLOR,
                              ),
                            ),
                          ).paddingOnly(right: styleSheet.SPACING.small),
                        )
                      ],
                    ),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                    Container(
                      padding: EdgeInsets.all(styleSheet.SPACING.medium),
                      decoration: BoxDecoration(
                          boxShadow: [styleSheet.SHAPES.DEFAULT_SHADOW],
                          color: styleSheet.COLORS.WHITE,
                          borderRadius: BorderRadius.circular(
                              styleSheet.SHAPES.RADIUS_MEDIUM)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipping Details",
                            style: styleSheet.TEXT_Rubik.FS_MEDIUM_15,
                          ),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          const Divider(),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          CustomRowWidget(
                              txt1: "Name", txt2: widget.item.name ?? ""),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          CustomRowWidget(
                              txt1: "Number",
                              txt2: "+91 ${widget.item.number}"),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          CustomRowWidget(
                              txt1: "Address", txt2: widget.item.address ?? ""),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          if (widget.item.message != null &&
                              widget.item.message!.isNotEmpty)
                            Column(
                              children: [
                                CustomRowWidget(
                                    txt1: "Message",
                                    txt2: widget.item.message!),
                                styleSheet.SPACING
                                    .addHeight(styleSheet.SPACING.small),
                              ],
                            ),
                          CustomRowWidget(
                              txt1: "Payment UTR", txt2: widget.item.utr ?? ""),
                          styleSheet.SPACING
                              .addHeight(styleSheet.SPACING.small),
                          CustomRowWidget(
                              txt1: "Order Status",
                              txt2: status == "paymentpending"
                                  ? "Check Payment"
                                  : status == "paymentdone"
                                      ? "Preparing your order"
                                      : status == "orderOntheway"
                                          ? "On The Way"
                                          : status == "outforDelivery"
                                              ? "Out For Delivery"
                                              : status == "payment_failed"
                                                  ? "Payment Failed"
                                                  : "Order Delivered"),
                          if (status == "orderOntheway" ||
                              status == "outforDelivery")
                            Column(
                              children: [
                                styleSheet.SPACING
                                    .addHeight(styleSheet.SPACING.small),
                                CustomRowWidget(
                                    txt1: "Order Location",
                                    txt2: widget.item.location ?? ""),
                              ],
                            ),
                          if (status == "outforDelivery")
                            Column(
                              children: [
                                Column(
                                  children: [
                                    styleSheet.SPACING
                                        .addHeight(styleSheet.SPACING.small),
                                    CustomRowWidget(
                                        txt1: "Delivery Agent Number",
                                        txt2: widget.item.deliveryBoyNumber ??
                                            ""),
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ).paddingAll(styleSheet.SPACING.medium),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
          BottomWidgetView()
        ],
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  String txt1;
  String txt2;
  CustomRowWidget({required this.txt1, required this.txt2, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$txt1  : ",
          style: styleSheet.TEXT_Rubik.FS_MEDIUM_15
              .copyWith(color: styleSheet.COLORS.TXT_BLACK_WITH_OPACITY),
        ),
        Text(txt2)
      ],
    );
  }
}
