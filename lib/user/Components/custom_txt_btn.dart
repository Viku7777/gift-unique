import 'package:flutter/material.dart';
import 'package:color_game/main.dart';

class CustomTxtBtnView extends StatelessWidget {
  String txt;
  Function onTap;
  CustomTxtBtnView({required this.txt, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onTap(),
        child: Text(
          txt,
          style: styleSheet.TEXT_Rubik.FS_REGULAR_16
              .copyWith(color: styleSheet.COLORS.BLACK_COLOR),
        ));
  }
}
