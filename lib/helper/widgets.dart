import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class AppHelperWidgets {
  static showSnackbar(BuildContext context, AnimatedSnackBarType type,
      String title, String message) {
    return AnimatedSnackBar.rectangle(
      animationCurve: Curves.linear,
      duration: const Duration(seconds: 2),
      title,
      message,
      type: type,
      brightness: Brightness.light,
    ).show(
      context,
    );
  }

  showWinAmountDialog(BuildContext context, int amount) {
    return Dialogs.materialDialog(
        // barrierColor: Colors.white,
        color: Colors.white,
        msg: 'you win $rupeSign$amount/-',
        msgStyle: GetTextTheme.fs_16_Medium,
        title: 'Congratulations',
        lottieBuilder: Lottie.asset(
          "assets/lottie.json",
          fit: BoxFit.contain,
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: () => Navigator.pop(context),
            text: 'Done',
            iconData: Icons.done,
            color: AppColor.primaryColor,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
