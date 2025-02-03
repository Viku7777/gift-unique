import 'package:color_game/export_widget.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/View/Bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class PaymentView extends StatefulWidget {
  final List<String> orderId;
  final num price;
  const PaymentView({super.key, required this.orderId, required this.price});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  var productController = Get.find<ProductController>();
  var orderController = Get.find<OrderController>();
  var controller = TextEditingController();
  @override
  void initState() {
    uploadProductDetails();
    super.initState();
  }

  uploadProductDetails() async {
    for (var e in widget.orderId) {
      await orderController.addTocartDetails(
        e,
      );
    }
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Order Payment",
                            style: styleSheet.TEXT_CONDENSED.FS_BOLD_22,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                        Text(
                          "Scan the QR code below to complete your payment securely.",
                          style: styleSheet.TEXT_Rubik.FS_MEDIUM_15
                              .copyWith(color: styleSheet.COLORS.TXT_GREY),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(
                            horizontal: styleSheet.SPACING.large),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                        Text(
                          "Pay: Rs ${widget.price}",
                          style: styleSheet.TEXT_Rubik.FS_MEDIUM_24,
                          textAlign: TextAlign.center,
                        ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                        QrImageView(
                          data:
                              "upi://pay?pa=${productController.admindata.upi}&am=${widget.price}&pn=Vikrant%20Jain&mc=0000&mode=02&purpose=100",
                          size: 300,
                        ).paddingSymmetric(
                            horizontal: styleSheet.SPACING.large),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                        Image.network(
                          "https://cdn-icons-gif.flaticon.com/7994/7994392.gif",
                          height: 100,
                        ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                        const LinearProgressIndicator(
                            // backgroundColor: styleSheet.COLORS.BTN_PRIMARY,
                            ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        Text(
                          "Waiting for your request..",
                          textAlign: TextAlign.center,
                          style: styleSheet.TEXT_Rubik.FS_MEDIUM_15
                              .copyWith(color: styleSheet.COLORS.GREY_LIGHT),
                        )
                      ],
                    ).paddingAll(styleSheet.SPACING.medium),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                    CustomPrimaryBtnView(
                            btnName: "Payment Done?",
                            onPressed: () {
                              dialog();
                            })
                        .paddingSymmetric(horizontal: styleSheet.SPACING.large),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                    BottomWidgetView()
                  ],
                ),
        ));
  }

  dialog() async {
    controller.clear();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure ?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "if your payment is done then only submit your utr number, if you're enter any wrong utr number then we cancel your order"),
              SizedBox(
                height: 20,
              ),
              PrimaryTextFieldView(
                label: "Enter UTR Number",
                hintText: "Please enter correct urt number",
                controller: controller,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cance;")),
            ElevatedButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    Get.back();
                    orderController.updateLoading(true);
                    for (var e in widget.orderId) {
                      await orderController.createOrder(e, controller.text);
                    }
                    orderController.updateLoading(false);
                    Get.offAll(() => BottomNavBarView());
                    Get.snackbar("Sucess",
                        "We just recived your order, once we verify your payment after then we process your order");
                  }
                },
                child: Text("Submit"))
          ],
        );
      },
    );
  }
}
