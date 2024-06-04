import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHistory extends StatelessWidget {
  const MyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var gamecontroller = Provider.of<GameController>(context, listen: false);

    return gamecontroller.investedHistory.isEmpty
        ? SizedBox(
            height: 100.h,
            child: const Center(
              child: Text("Not Found", style: GetTextTheme.fs_18_Bold),
            ),
          )
        : Column(
            children: gamecontroller.investedHistory.reversed
                .map((e) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: .005.sw),
                          height: 45.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  height: 35.h,
                                  width: 35.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Text(
                                    e.invest,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      e.tableno,
                                      style: GetTextTheme.fs_16_Bold,
                                    ),
                                    Text(
                                      DateFormat().format(
                                        DateTime.parse(e.time),
                                      ),
                                      style: GetTextTheme.fs_10_Bold,
                                    ),
                                  ],
                                ),
                              ),
                              e.isWin == null
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                    color: e.isWin!
                                                        ? AppColor.greenColor
                                                        : AppColor.redColor)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .005.sw,
                                                vertical: 2.h),
                                            child: Text(
                                              e.isWin! ? "Succeed" : "Failed ",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: e.isWin!
                                                      ? AppColor.greenColor
                                                      : AppColor.redColor),
                                            ),
                                          ),
                                          Text(
                                            e.isWin!
                                                ? "+$rupeSign${e.amount * ([
                                                      "G",
                                                      "R",
                                                      "V"
                                                    ].any((element) => element == e.invest) ? AppConfig.colorWin : ([
                                                        "B",
                                                        "S"
                                                      ].any((element) => element == e.invest)) ? AppConfig.sizeWin : AppConfig.numberWin)}"
                                                : "-$rupeSign${e.amount}",
                                            style: TextStyle(
                                                color: e.isWin!
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
                              horizontal: .005.sw, vertical: 5.w),
                          child: const Divider(),
                        ),
                      ],
                    ))
                .toList());
  }
}
