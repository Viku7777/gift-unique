// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:color_game/main.dart';

class ShapeManager {
  ShapeManager._privateConstructor();
  static final ShapeManager _instance = ShapeManager._privateConstructor();

  factory ShapeManager() {
    return _instance;
  }

  double RADIUS_MIN = 10;
  double RADIUS_MEDIUM = 16;
  double RADIUS_MAX = 40;

  double SPACE_MIN = 5;
  double SPACE_SMALL = 10;
  double SPACE_MEDIUM = 15;
  double SPACE_LARGE = 20;
  double SPACE_EXTRA_LARGE = 30;

  BoxDecoration get DEFAULTBOX => BoxDecoration(
      color: styleSheet.COLORS.WHITE,
      boxShadow: [BoxShadow(color: styleSheet.COLORS.GREY_LIGHT)],
      border: Border.all(
          color: styleSheet.COLORS.BLACK_COLOR.withOpacity(0.2), width: 0.3),
      borderRadius: BorderRadius.circular(RADIUS_MEDIUM));

  BoxShadow get DEFAULT_SHADOW => BoxShadow(
      color: styleSheet.COLORS.BLACK_COLOR.withOpacity(0.1),
      blurRadius: 15,
      offset: const Offset(0, 3));
}
