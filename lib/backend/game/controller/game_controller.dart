// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls, use_build_context_synchronously
import 'dart:async';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:color_game/backend/notification/notification_services.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:color_game/backend/game/controller/investment_bottom_seat_controller.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:color_game/model/investment_model.dart';
import 'package:color_game/model/result_model.dart';
import 'package:velocity_x/velocity_x.dart';

ResultHistoryModel? newHistoryModel;
String referByFcm = "";

class GameController extends ChangeNotifier {
  int second = 60;
  int tableNo = 0;
  List<InvestmentModel> investedHistory = [];
  List<ResultHistoryModel> resultHistory = [];
  Timer? timer;
  bool loading = false;
  uploadloading() {
    loading = !loading;
    notifyListeners();
  }

  updateSecond(int currentsecond, BuildContext context) {
    second = currentsecond == 60 ? 0 : currentsecond;
    if (currentsecond == 60 || tableNo == 0) {
      updateTableNo();
      if (newHistoryModel != null) {
        resultHistory.add(newHistoryModel!);
        notifyListeners();
        findResult(newHistoryModel!, context);
      }
    }
    notifyListeners();
  }

  updateTableNo() {
    String table =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}";
    tableNo = int.parse(table);
    AppConfig.currnetTableNo = table;

    notifyListeners();
  }

  placeBid(BuildContext context, String invest) async {
    var bottomSeatController =
        Provider.of<BottomSeatController>(context, listen: false);
    var usercontroller = Provider.of<UserController>(context, listen: false);
    if (second <= 8) {
      Navigator.pop(context);
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.warning,
          "Error", "Please Wait for few Seconds...");
    } else if (usercontroller.depositBalance <
        bottomSeatController.currentSelectedBalance) {
      Navigator.pop(context);
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.warning,
          "Error", "Please recharge your wallet");
    } else {
      try {
        uploadloading();
        usercontroller
            .updateWalletBalance(-bottomSeatController.currentSelectedBalance);
        await FirebaseDatabase.instance
            .ref("gameinvestment")
            .child(tableNo.toString())
            .update({
          invest:
              ServerValue.increment(bottomSeatController.currentSelectedBalance)
        }).then((value) async {
          investedHistory.add(InvestmentModel(
              invest: invest,
              time: DateTime.now().toIso8601String(),
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              amount: bottomSeatController.currentSelectedBalance,
              tableno: tableNo.toString()));
          uploadloading();
          AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.success,
              "Congratulations", "Bet Succeed");
          Navigator.pop(context);
        });
      } catch (e) {
        uploadloading();
        AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.error,
            "Error", "Something Went Wrong !!!");
        Navigator.pop(context);
      }
    }
  }

  findResult(ResultHistoryModel result, BuildContext context) async {
    var usercontroller = Provider.of<UserController>(context, listen: false);
    List<InvestmentModel> investedList = investedHistory
        .where((element) => result.tableno == element.tableno)
        .toList();
    int totalWin = 0;

    if (investedList.isNotEmpty) {
      investedList.forEach((element) {
        int index = investedList.indexWhere((e) => e.id == element.id);

        if (element.invest.startsWith(result.bigsmallResult) ||
            element.invest.startsWith(result.colorResult) ||
            element.invest.startsWith(result.numberResult)) {
          totalWin = totalWin +
              element.amount *
                  (["R", "G", "V"].any((e) => element.invest.startsWith(e))
                      ? AppConfig.colorWin
                      : ["S", "B"].any((e) => element.invest.startsWith(e))
                          ? AppConfig.sizeWin
                          : AppConfig.numberWin);
          investedList[index].isWin = true;
        } else {
          investedList[index].isWin = false;
        }
      });
      if (totalWin != 0) {
        totalWin = totalWin - (totalWin * AppConfig.commission) ~/ 100;
        usercontroller.updateWalletBalance(totalWin);
        AppHelperWidgets().showWinAmountDialog(context, totalWin);
      } else {
        int totalInvestedAmount = 0;
        investedList.forEach((element) {
          totalInvestedAmount = totalInvestedAmount + element.amount;
        });
        int shareCommisionwithReferBY =
            (totalInvestedAmount * AppConfig.referCommision) ~/ 100;
        // share commision with refer friend
        if (!AppConfig.referByUID.startsWith("not_") &&
            AppConfig.referByUID.isNotEmpty &&
            shareCommisionwithReferBY >= 5) {
          await FirebaseRepository().updateData(
              fcloud.collection("users").doc(AppConfig.referByUID), {
            "depositBalance": FieldValue.increment(shareCommisionwithReferBY)
          });

          if (referByFcm.isEmpty && referByFcm != "notfound") {
            DocumentSnapshot user = await FirebaseRepository()
                .getDocumentData("users", AppConfig.referByUID);
            referByFcm = user.get("fcmToken") ?? "notfound";
          }

          referByFcm.isNotEmptyAndNotNull && referByFcm != "notfound"
              ? NotificationServices.sendFCM(
                  "Loss Commission of ${Provider.of<UserController>(context, listen: false).currentuser!.name}",
                  "Congratulations you have got $rupeSign$shareCommisionwithReferBY/-",
                  referByFcm)
              : null;
        }
      }
    } else {}
  }

  startTimer(BuildContext context) async {
    var bottomSeatController =
        Provider.of<BottomSeatController>(context, listen: false);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateSecond(60 - DateTime.now().second, context);
      if (second == 5) {
        bottomSeatController.findcurrentTableResult();
      }
    });
  }
}

class Invested {
  String name;
  int amount;
  Invested({
    required this.name,
    required this.amount,
  });
}
