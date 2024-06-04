import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GameHistoryView extends StatelessWidget {
  const GameHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, value, child) => value.resultHistory.isEmpty
          ? SizedBox(
              height: 100.h,
              child: const Center(
                child: Text("Not Found", style: GetTextTheme.fs_18_Bold),
              ),
            )
          : Column(
              children: [
                Container(
                    height: 60.h,
                    margin: EdgeInsets.symmetric(horizontal: .005.sw),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r))),
                    child: Row(
                      children: ["Period", "Number", "Big Small", "Color"]
                          .map(
                            (e) => Expanded(
                                flex: e.startsWith("P")
                                    ? 5
                                    : e.startsWith("B")
                                        ? 3
                                        : 2,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                )),
                          )
                          .toList(),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: .005.sw),
                  padding: EdgeInsets.symmetric(horizontal: .003.sw),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.grey.shade500),
                          right: BorderSide(color: Colors.grey.shade500))),
                  child: Column(
                    children: value.resultHistory.reversed
                        .map((e) => Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          e.tableno,
                                          style: GetTextTheme.fs_16_Bold,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          e.numberResult,
                                          style: GetTextTheme.fs_14_Bold,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          e.bigsmallResult.startsWith("S")
                                              ? "Small"
                                              : "Big",
                                          style: GetTextTheme.fs_14_Bold,
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 15.h,
                                          width: 25.h,
                                          decoration: BoxDecoration(
                                              color: e.colorResult == "G"
                                                  ? AppColor.greenColor
                                                  : e.colorResult == "V"
                                                      ? AppColor.violetColor
                                                      : AppColor.primaryColor,
                                              shape: BoxShape.circle),
                                        )),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
    );
  }
}

// List<Map<String, dynamic>> gameHistory = [
//   {
//     "tableno": "20240412192423",
//     "number": "1",
//     "Bigsmall": "Big",
//     "Color": "G",
//   },
//   {
//     "tableno": "20240412192423",
//     "number": "1",
//     "Bigsmall": "Small",
//     "Color": "G",
//   },
//   {
//     "tableno": "20240412192423",
//     "number": "1",
//     "Bigsmall": "Big",
//     "Color": "G",
//   },
//   {
//     "tableno": "20240412192423",
//     "number": "1",
//     "Bigsmall": "Small",
//     "Color": "G",
//   },
//   {
//     "tableno": "20240412192423",
//     "number": "1",
//     "Bigsmall": "Small",
//     "Color": "G",
//   }
// ];
