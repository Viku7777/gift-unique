import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:color_game/export_widget.dart';

class CustomCardView extends StatelessWidget {
  String image;
  String title;

  CustomCardView({required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: styleSheet.SPACING.PADDING_MEDIUM,
      decoration: BoxDecoration(
          border: Border.all(color: styleSheet.COLORS.ACTIVE_GREEN),
          color: styleSheet.COLORS.ACTIVE_GREEN.withOpacity(0.2),
          borderRadius: BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 35,
            width: 35,
          ),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
          Text(title.toUpperCase())
        ],
      ),
    );
  }
}
