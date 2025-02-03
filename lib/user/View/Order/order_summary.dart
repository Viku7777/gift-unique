import 'dart:developer';

import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/View/Order/payment_view.dart';
import 'package:color_game/export_widget.dart';

class OrderSummaryView extends StatefulWidget {
  final List<String> orderId;
  final num price;
  const OrderSummaryView(
      {super.key, required this.orderId, required this.price});

  @override
  State<OrderSummaryView> createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends State<OrderSummaryView> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController landmark = TextEditingController();
  var orderController = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: ListView(
        children: [
          styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Text(
                "Order Address",
                style: styleSheet.TEXT_CONDENSED.FS_BOLD_22,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Text(
                "Enter you delivery address here!!",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_16
                    .copyWith(color: styleSheet.COLORS.TXT_GREY),
                textAlign: TextAlign.center,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              PrimaryTextFieldView(
                label: "Enter name",
                hintText: "Enter your name",
                controller: name,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              PrimaryTextFieldView(
                label: "Enter Number",
                hintText: "Enter your phone number",
                keyboardType: TextInputType.number,
                controller: number,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              PrimaryTextFieldView(
                label: "Enter address",
                hintText: "Enter your address",
                controller: address,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              PrimaryTextFieldView(
                label: "Enter landmark",
                hintText: "Enter your landmark",
                controller: landmark,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              CustomPrimaryBtnView(
                  btnName: "CONTINUE WITH ADDRESS",
                  onPressed: () {
                    if (name.text.isEmpty) {
                      Get.snackbar("Error", "Please enter a valid name");
                    } else if (number.text.length != 10) {
                      Get.snackbar(
                          "Error", "Please enter a valid phone number");
                    } else if (address.text.length < 15) {
                      Get.snackbar(
                          "Error", "Please enter a valid full address");
                    } else if (landmark.text.length < 5) {
                      Get.snackbar("Error", "Please enter a valid landmark");
                    } else {
                      // ignore: avoid_function_literals_in_foreach_calls
                      orderController.userOrders.forEach((e) {
                        e.name = name.text;
                        e.number = number.text;
                        e.address = address.text;
                        e.landmark = landmark.text;
                        e.finalPrice = widget.price;
                        e.status = "paymentpending";
                      });

                      Get.to(PaymentView(
                        orderId: widget.orderId,
                        price: widget.price,
                      ));
                    }
                  }),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            ],
          ).paddingSymmetric(horizontal: styleSheet.SPACING.medium),

          styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

          // BOTTOM WIDGET VIEW

          BottomWidgetView()
        ],
      ),
    );
  }
}
