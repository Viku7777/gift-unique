import 'package:flutter/material.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/main.dart';

// ignore: must_be_immutable
class CustomTextfieldView extends StatefulWidget {
  String hintText;
  Function()? onTap;
  TextEditingController? controller;
  CustomTextfieldView(
      {this.hintText = "", this.onTap, this.controller, super.key});

  @override
  State<CustomTextfieldView> createState() => _CustomTextfieldViewState();
}

class _CustomTextfieldViewState extends State<CustomTextfieldView> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller ?? controller,
      decoration: InputDecoration(
        hintStyle: styleSheet.TEXT_Rubik.FS_REGULAR_14,
        hintText: widget.hintText,
        suffixIcon: Container(
          height: 55,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(styleSheet.SHAPES.RADIUS_MAX),
              color: styleSheet.COLORS.BLACK_COLOR),
          child: InkWell(
            onTap: widget.onTap ??
                () {
                  if (controller.text.isNotEmpty) {
                    Get.showSnackbar(GetSnackBar(
                      message: "Send!",
                      backgroundColor: Colors.green,
                    ));
                    controller.clear();
                  }
                },
            child: Icon(
              Icons.send,
              color: styleSheet.COLORS.WHITE,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MAX,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MAX,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MAX,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
      ),
    );
  }
}

class PrimaryTextFieldView extends StatelessWidget {
  String hintText;
  String label;
  TextInputType? keyboardType;
  bool isSearch;
  TextEditingController? controller;

  PrimaryTextFieldView(
      {this.hintText = "",
      this.label = "",
      this.controller,
      this.keyboardType,
      super.key,
      this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintStyle: styleSheet.TEXT_Rubik.FS_REGULAR_12,
            hintText: hintText,
            suffixIcon: Icon(
              isSearch ? Icons.search : Icons.check_circle,
              color: styleSheet.COLORS.BLACK_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class SecondaryTextFieldView extends StatelessWidget {
  String hintText;
  TextEditingController? controller;

  SecondaryTextFieldView({this.hintText = "", this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintStyle: styleSheet.TEXT_Rubik.FS_REGULAR_12,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MIN,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MIN,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            styleSheet.SHAPES.RADIUS_MIN,
          ),
          borderSide: BorderSide(color: styleSheet.COLORS.GREY_LIGHT),
        ),
      ),
    );
  }
}
