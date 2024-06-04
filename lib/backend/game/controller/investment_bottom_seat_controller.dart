import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/model/result_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BottomSeatController extends ChangeNotifier {
  int currentSelectedBalance = 10;
  updateSelectedBalance(int balance) {
    currentSelectedBalance += balance;
    notifyListeners();
  }

  updateKeyValue(int balance) {
    currentSelectedBalance = balance;
    notifyListeners();
  }

  int getHashcode(int tableno) {
    return int.parse((tableno.toString().hashCode +
            DateTime.now().minute.toString().hashCode)
        .toString()
        .split("")
        .last);
  }

  findcurrentTableResult() async {
    // var gamecontroller = Provider.of<GameController>(context, listen: false);
    String table =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}";
    int tableNo = int.parse(table);
    int hashNumber = getHashcode(tableNo);
    String historyNumberResult = "0";
    String historyColorResult = "0";
    String historySizeResult = "0";
    var data = await FirebaseDatabase.instance
        .ref("gameinvestment")
        .child(tableNo.toString())
        .get();

    List<Invested> number = List.generate(
        10,
        (e) => data.hasChild(e.toString())
            ? Invested(
                name: e.toString(),
                amount: data.child(e.toString()).value as int)
            : Invested(name: e.toString(), amount: 0));

    List<Invested> numberList =
        number.where((element) => element.amount == 0).toList();

    if (numberList.isEmpty) {
      number.sort((a, b) => b.amount - a.amount);
      historyNumberResult = number.last.name;
    } else {
      if (numberList.length > hashNumber) {
        historyNumberResult = numberList[hashNumber].name;
      } else {
        int newNo = hashNumber % numberList.length;
        historyNumberResult = numberList[newNo].name;
      }
    }

    // find color result
    List<Invested> color = ["G", "V", "R"]
        .map((e) => data.hasChild(e)
            ? Invested(name: e, amount: data.child(e).value as int)
            : Invested(name: e, amount: 0))
        .toList();
    List<Invested> newColorList =
        color.where((element) => element.amount == 0).toList();

    if (newColorList.isEmpty) {
      color.sort((a, b) => b.amount - a.amount);
      historyColorResult = color.last.name;
    } else {
      if (newColorList.length > hashNumber) {
        historyColorResult = newColorList[hashNumber].name;
      } else {
        int newNo = hashNumber % newColorList.length;
        historyColorResult = newColorList[newNo].name;
      }
    }

    //size result
    List<Invested> size = ["B", "S"]
        .map((e) => data.hasChild(e)
            ? Invested(name: e, amount: data.child(e).value as int)
            : Invested(name: e, amount: 0))
        .toList();

    List<Invested> sizeList =
        size.where((element) => element.amount == 0).toList();

    if (sizeList.isEmpty) {
      size.sort((a, b) => b.amount - a.amount);
      historySizeResult = size.last.name;
    } else {
      if (sizeList.length > hashNumber) {
        historySizeResult = sizeList[hashNumber].name;
      } else {
        int newNo = hashNumber % sizeList.length;
        historySizeResult = sizeList[newNo].name;
      }
    }

    newHistoryModel = ResultHistoryModel(
        tableno: tableNo.toString(),
        numberResult: historyNumberResult,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        bigsmallResult: historySizeResult,
        colorResult: historyColorResult);
  }
}
