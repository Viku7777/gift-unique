import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/add_money/add_money.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/screen/wallet/withdraw_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  bool isLoading = true;
  List<HistoryModel> history = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Deposit"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                  children: history
                      .map((e) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                height: 45.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            e.tid,
                                            style: GetTextTheme.fs_16_Bold,
                                          ),
                                          Text(
                                            DateFormat().format(
                                              DateTime.parse(e.time),
                                            ),
                                            style: GetTextTheme.fs_12_Bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                    color: e.status == "D"
                                                        ? AppColor.greenColor
                                                        : AppColor.redColor)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .005.sw,
                                                vertical: 2.h),
                                            child: Text(
                                              e.status == "D"
                                                  ? "Done"
                                                  : e.status == "P"
                                                      ? "Process"
                                                      : "Failed ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: e.status == "D"
                                                      ? AppColor.greenColor
                                                      : AppColor.redColor),
                                            ),
                                          ),
                                          Text(
                                            "$rupeSign${e.amount}/-",
                                            style: TextStyle(
                                                decoration: e.status == "C"
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                                decorationColor:
                                                    AppColor.primaryColor,
                                                color: e.status == "D"
                                                    ? AppColor.greenColor
                                                    : AppColor.redColor),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.w),
                                child: const Divider(),
                              ),
                            ],
                          ))
                      .toList()),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMoneyView(),
                ));
          },
          child: const Icon(
            Icons.currency_rupee,
            color: Colors.white,
          )),
    );
  }

  getData() async {
    QuerySnapshot snapshot = await fcloud
        .collection("request")
        .where("uid", isEqualTo: AppConfig.useruid)
        .where("isAddmoney", isEqualTo: true)
        .get();
    history = snapshot.docs
        .map((e) => HistoryModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    history.sort((b, a) => a.time.compareTo(b.time));
    if (mounted) {
      isLoading = false;
      setState(() {});
    }
  }
}
