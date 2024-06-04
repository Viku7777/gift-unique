import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/backend/game/controller/investment_bottom_seat_controller.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

investmentBottomTable(BuildContext context, Color color, String invest) {
  var gamecontroller = Provider.of<GameController>(context, listen: false);
  return showModalBottomSheet(
    isDismissible: false,
    constraints: BoxConstraints(maxHeight: .45.sh),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    context: context,
    builder: (context) {
      return Consumer<BottomSeatController>(
        builder: (context, value, child) => Column(
          children: [
            Container(
              height: .15.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Win Go 1 Min",
                      style: GetTextTheme.fs_20_Bold
                          .copyWith(color: Colors.white)),
                  5.h.heightBox,
                  Container(
                    width: .7.sw,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "Select : $invest",
                      style: GetTextTheme.fs_20_Bold,
                    ),
                  )
                ],
              ),
            ),
            40.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Balance",
                    style: GetTextTheme.fs_18_Regular,
                  ),
                  Row(
                    children: ["10", "100", "1000", "10000"]
                        .map((e) => InkWell(
                              onTap: () {
                                value.updateKeyValue(int.parse(e));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 10.w),
                                  decoration: BoxDecoration(
                                      color: int.parse(e) ==
                                              value.currentSelectedBalance
                                          ? color
                                          : Colors.grey.shade300),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: int.parse(e) ==
                                                value.currentSelectedBalance
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            40.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quantity",
                    style: GetTextTheme.fs_18_Regular,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (value.currentSelectedBalance - 10 >= 9) {
                            value.updateSelectedBalance(-10);
                          }
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.all(.003.sw),
                          color: color,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      10.w.widthBox,
                      Container(
                        height: 30.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        child: Text(
                          value.currentSelectedBalance.toString(),
                          style: GetTextTheme.fs_18_Bold,
                        ),
                      ),
                      10.w.widthBox,
                      InkWell(
                        onTap: () {
                          if (10000 >= value.currentSelectedBalance + 10) {
                            value.updateSelectedBalance(10);
                          }
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.all(.003.sw),
                          color: color,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    value.updateKeyValue(10);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    color: const Color(0xff25243c),
                    padding: EdgeInsets.all(.005.sw),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: GetTextTheme.fs_16_Regular
                          .copyWith(color: const Color(0xff777796)),
                    ),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () =>
                          gamecontroller.placeBid(context, invest.split("")[0]),
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.all(.005.sw),
                        alignment: Alignment.center,
                        color: color,
                        child: Text(
                          "Total amount $rupeSign ${value.currentSelectedBalance}.00",
                          style: GetTextTheme.fs_16_Medium
                              .copyWith(color: Colors.white.withOpacity(.8)),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      );
    },
  );
}
