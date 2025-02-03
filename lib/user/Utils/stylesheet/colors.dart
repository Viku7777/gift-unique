// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class SFColors {
  SFColors._privateConstructor();

  static final SFColors _instance = SFColors._privateConstructor();

  factory SFColors() {
    return _instance;
  }

// Primary Color
  final Color BLACK_COLOR = const Color(0XFF000000);
  final Color TRANSPERNT = Colors.transparent;

  // Button Colors
  final Color BTN_PRIMARY = const Color(0xff6C4DEF);
  final Color SECONDARY = const Color(0xfff1f9ee);

  // Text Colors
  final Color TXT_BLACK = const Color(0xff212121);
  final Color TXT_BLACK_WITH_OPACITY = const Color(0xff000000);
  final Color TXT_GREY = const Color(0xff828282);
  final Color GREY_LIGHT = const Color.fromARGB(255, 221, 221, 221);

  // Border Colors
  final Color BORDER_GREY = const Color(0xffDADEDF);
  final Color BORDER_LIGHT_GREY = const Color(0xffB3B3B3);
  final Color BORDER_WHITE_LIGHT = const Color(0xffD9D9D9);

  // lINKS AND TEXT bUTTONS
  final Color BLUE = const Color(0xff615EFC);
  final Color ACTIVE_BLUE = const Color(0xff6C4DEF);
  final Color ACTIVE_GREEN = const Color.fromARGB(255, 82, 187, 86);
  final Color DARK_GREEN = const Color.fromARGB(255, 34, 85, 36);

  // bg colors
  final Color BG_PURPLE = const Color(0xffE2DBFC);
  final Color BG_BLUE = const Color(0xff6C4DEF);

  // Misc Colors
  final Color WHITE = Colors.white;
  final Color ERROR = const Color(0xffEA1D1D);

  // Icon Color
  final Color YELLOW = const Color(0xffFFBD00);

  // background screen color
  final Color Background = const Color(0xffEDEDED);
}
