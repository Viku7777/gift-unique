// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class SFUtility {
  SFUtility._privateConstructor();

  static final _instance = SFUtility._privateConstructor();

  factory SFUtility() {
    return _instance;
  }

  // METHOD TO GET VIEW HEIGHT
  double VIEWPORT_HEIGHT(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // METHOD TO GET VIEW WIDTH
  double VIEWPORT_WIDTH(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // METHOD TO STACK NAVIGATION
  dynamic pushTo(BuildContext context, Widget routeName) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => routeName));

  // METHOD TO NAVIGATE WITH REMOVE ROUTE METHOD
  dynamic pushAndRemove(BuildContext context, Widget routeName) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => routeName), (context) => false);

  // METHOD TO NAVIGATE WITH REPLACE ROUTE METHOD
  dynamic replaceRoute(BuildContext context, Widget newRoute) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => newRoute));

  // METHOD TO GET BACK TO PREVIOUS VIEW.
  dynamic back(BuildContext context) => Navigator.of(context).pop();
}
