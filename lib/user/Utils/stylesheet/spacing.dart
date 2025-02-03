// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class SFSpacing {
  SFSpacing._privateConstructor();

  static final SFSpacing _instance = SFSpacing._privateConstructor();

  factory SFSpacing() {
    return _instance;
  }

  // addSpacing in vertical

  addHeight(double h) => SizedBox(height: h);
  addWidth(double w) => SizedBox(width: w);

  // Define commonly used padding and spacing values here
  final double minsmall = 5;
  final double small = 10;
  final double medium = 16.0;
  final double large = 32.0;
  final double extraLarge = 64.0;

  // You can also define EdgeInsets for convenience

  EdgeInsetsGeometry PADDING_LITTLE_SMALL = const EdgeInsets.all(8);
  EdgeInsetsGeometry PADDING_SMALL = const EdgeInsets.all(10);
  EdgeInsetsGeometry PADDING_MEDIUM = const EdgeInsets.all(20);
  EdgeInsetsGeometry PADDING_LARGE = const EdgeInsets.all(30);
  final EdgeInsets horizontalPadding =
      const EdgeInsets.symmetric(horizontal: 16.0);
  final EdgeInsets verticalPadding = const EdgeInsets.symmetric(vertical: 16.0);

  // Width for widgets

  final double widthsmall = 150;
}
