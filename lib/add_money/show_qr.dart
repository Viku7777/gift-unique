// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/add_money/add_money.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/backend/notification/notification_services.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowQRView extends StatefulWidget {
  String upi;
  double amount;
  static String routes = "/show_Qr";

  ShowQRView({super.key, required this.upi, required this.amount});

  @override
  State<ShowQRView> createState() => _ShowQRViewState();
}

class _ShowQRViewState extends State<ShowQRView> {
  var transactionController = TextEditingController();
  var upiController = TextEditingController();
  String upi = "wait";
  bool isLoading = false;
  double amount = 0;

  @override
  void initState() {
    upi = widget.upi;
    upiController.text = upi;
    amount = widget.amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upiDetails = UPIDetails(
        transactionNote: "xXx",
        upiID: upi,
        payeeName: "Aviator Game",
        amount: amount);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
          title: const Text("Pay Here"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  .05.sh.heightBox,
                  Container(
                    padding: const EdgeInsets.all(2),
                    color: Colors.white,
                    child: UPIPaymentQRCode(
                      upiDetails: upiDetails,
                      size: 200,
                      loader: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                          color: Colors.black,
                          dataModuleShape: QrDataModuleShape.square),
                      embeddedImageSize: const Size(60, 60),
                    ),
                  ),
                  .05.sh.heightBox,
                  Container(
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "$rupeSign${amount.toString()}/-",
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  .015.sh.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: customTextFiled(upiController, "UPI",
                        keyboardType: TextInputType.name, readOnly: true),
                  ),
                  .015.sh.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: customTextFiled(
                      transactionController,
                      "Enter UTR",
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  .05.sh.heightBox,
                  ElevatedButton(
                      onPressed: () {
                        if (transactionController.text.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Are you sure?"),
                                content: const Text(
                                    "Your entered correct payment UTR No."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                  ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);

                                        bool checkUTR = await checkDuplicateUtr(
                                            transactionController.text);
                                        if (checkUTR) {
                                          transactionController.clear();

                                          AppHelperWidgets.showSnackbar(
                                              context,
                                              AnimatedSnackBarType.warning,
                                              "Error",
                                              "Duplicate Transaction");
                                        } else {
                                          AppHelperWidgets.showSnackbar(
                                              context,
                                              AnimatedSnackBarType.success,
                                              "Congratulations",
                                              "We received your recharge request, please wait for 2 hour");
                                          Navigator.pop(context);
                                          await fcloud
                                              .collection("request")
                                              .doc(transactionController.text)
                                              .set({
                                            "uid": AppConfig.useruid,
                                            "time": DateTime.now()
                                                .toIso8601String(),
                                            "upi": upi,
                                            "amount": amount.toInt(),
                                            "status": "P",
                                            "isAddmoney": true,
                                            "tid": transactionController.text,
                                          });
                                          // await Future.delayed(
                                          //     const Duration(
                                          //         milliseconds: 1000), () {
                                          //   NotificationServices.shownotification(
                                          //       "Success",
                                          //       "We received your recharge request, please wait for 2 hour");
                                          // });
                                        }
                                      },
                                      child: const Text("Yes"))
                                ],
                              );
                            },
                          );
                        } else {
                          AppHelperWidgets.showSnackbar(
                              context,
                              AnimatedSnackBarType.warning,
                              "Error",
                              "If your payment is done, then please enter UTR or Transaction id");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(.8.sw, 45.h),
                          backgroundColor: AppColor.primaryColor),
                      child: Text(
                        "Payment Done",
                        style: GetTextTheme.fs_18_Bold
                            .copyWith(color: Colors.white),
                      )),
                  10.h.heightBox,
                  // ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //         fixedSize: Size(.8.sw, 45.h),
                  //         backgroundColor: AppColor.primaryColor),
                  //     child: Text(
                  //       "Google pay or Phonepe",
                  //       style:
                  //           GetTextTheme.fs_18_Bold.copyWith(color: Colors.white),
                  //     ))
                ],
              ),
            ),
            isLoading
                ? Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }

  Future<bool> checkDuplicateUtr(String utr) async {
    DocumentSnapshot data =
        await FirebaseRepository().getDocumentData("request", utr);
    return data.exists;
  }
}
