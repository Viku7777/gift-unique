// ignore_for_file: must_be_immutable

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/add_money/show_qr.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddMoneyView extends StatefulWidget {
  bool isWithdraw;
  static String routes = "/add_money";

  AddMoneyView({super.key, this.isWithdraw = false});

  @override
  State<AddMoneyView> createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<AddMoneyView> {
  late bool isLoading;
  String upiID = "Waiting";
  var addMoney = TextEditingController();
  var upi = TextEditingController();
  @override
  void initState() {
    isLoading = widget.isWithdraw ? false : true;
    addMoney.text = "200";
    widget.isWithdraw
        ? null
        : fcloud.collection("appconfigure").doc("details").get().then((value) {
            upiID = value.get("upi");
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        title: Text(widget.isWithdraw ? "Withdraw" : "Add Money"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    .05.sh.heightBox,
                    customTextFiled(
                      addMoney,
                      "Enter amount",
                      keyboardType: TextInputType.number,
                      onChanged: (p0) {
                        setState(() {});
                      },
                    ),
                    .05.sh.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        addMoneyBtn(
                          "200",
                          () {
                            addMoney.text = "200";
                            setState(() {});
                          },
                        ),
                        addMoneyBtn("500", () {
                          addMoney.text = "500";
                          setState(() {});
                        })
                      ],
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        addMoneyBtn("1000", () {
                          addMoney.text = "1000";
                          setState(() {});
                        }),
                        addMoneyBtn("2000", () {
                          addMoney.text = "2000";
                          setState(() {});
                        })
                      ],
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        addMoneyBtn("3000", () {
                          addMoney.text = "3000";
                          setState(() {});
                        }),
                        addMoneyBtn("4000", () {
                          addMoney.text = "4000";
                          setState(() {});
                        })
                      ],
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        addMoneyBtn("5000", () {
                          addMoney.text = "5000";
                          setState(() {});
                        }),
                        addMoneyBtn("10000", () {
                          addMoney.text = "10000";
                          setState(() {});
                        })
                      ],
                    ),
                    .2.sh.heightBox,
                    Text("$rupeSign ${addMoney.text}/-",
                        style: GetTextTheme.fs_20_Bold.copyWith(fontSize: 30)),
                    .05.sh.heightBox,
                    ElevatedButton(
                        onPressed: () {
                          if (widget.isWithdraw) {
                            if (int.parse(addMoney.text) < 200) {
                              AppHelperWidgets.showSnackbar(
                                  context,
                                  AnimatedSnackBarType.warning,
                                  "Error",
                                  "Minimum Withdraw 200/-");
                            } else if (Provider.of<UserController>(context,
                                        listen: false)
                                    .depositBalance <
                                int.parse(addMoney.text)) {
                              AppHelperWidgets.showSnackbar(
                                  context,
                                  AnimatedSnackBarType.warning,
                                  "Error",
                                  "Your Current Balance is Low..");
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Please Enter Your Upi"),
                                    content: customTextFiled(
                                      upi,
                                      "Enter Upi",
                                      keyboardType: TextInputType.text,
                                      onChanged: (p0) {
                                        setState(() {});
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No")),
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (upi.text.isNotEmptyAndNotNull) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              AppHelperWidgets.showSnackbar(
                                                  context,
                                                  AnimatedSnackBarType.success,
                                                  "Success",
                                                  "We received your request, please wait for 2 hour");
                                              Provider.of<UserController>(
                                                      context,
                                                      listen: false)
                                                  .updateWalletBalance(
                                                      -int.parse(
                                                          addMoney.text));

                                              await fcloud
                                                  .collection("request")
                                                  .doc()
                                                  .set({
                                                "uid": AppConfig.useruid,
                                                "time": DateTime.now()
                                                    .toIso8601String(),
                                                "upi": upi.text,
                                                "amount":
                                                    int.parse(addMoney.text),
                                                "status": "P",
                                                "isAddmoney": false,
                                                "tid": "Please Wait",
                                              });
                                            }
                                          },
                                          child: const Text("Withdraw"))
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            if (int.parse(addMoney.text) < 100) {
                              AppHelperWidgets.showSnackbar(
                                  context,
                                  AnimatedSnackBarType.warning,
                                  "Error",
                                  "Minimum Deposit 100/-");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowQRView(
                                        amount: double.parse(addMoney.text),
                                        upi: upiID),
                                  ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(.8.sw, 45.h),
                            backgroundColor: AppColor.primaryColor),
                        child: Text(
                          widget.isWithdraw ? "Withdraw" : "Add Money",
                          style: GetTextTheme.fs_18_Bold
                              .copyWith(color: Colors.white),
                        )),
                    .05.sh.heightBox,
                  ],
                ),
              ),
            ),
    );
  }

  addMoneyBtn(String amount, VoidCallback onclick) => ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          fixedSize: const Size(90, 20)),
      child: Text(
        amount,
        style: const TextStyle(color: Colors.white),
      ));
}

customTextFiled(TextEditingController controller, String title,
        {FocusNode? focusNode,
        TextInputType? keyboardType,
        double textsize = 16,
        double height = 55,
        bool readOnly = false,
        Function(String)? onSubmitted,
        Function(String)? onChanged,
        bool contentPadding = true}) =>
    Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade400)),
      child: TextField(
        readOnly: readOnly,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        cursorColor: AppColor.primaryColor,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: textsize, letterSpacing: .5, color: Colors.black),
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              contentPadding ? const EdgeInsets.only(left: 10) : null,
          border: InputBorder.none,
        ),
      ),
    );
