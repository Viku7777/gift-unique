import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppServices {
  /* ****************** Height and Width Factors ****************** */

  // get width of the screen
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // get height of the screen
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // used to add space between two vertical objects
  static addHeight(double space) => SizedBox(height: space.h);

  // used to add space between two horizontal objects
  static addWidth(double space) => SizedBox(width: space.w);

/* ********************* Navigators ********************* */
  // navigate to the previous screen or previous state
  static popView(BuildContext context) => Navigator.of(context).pop();

  /// Navigate to a new route
  static pushTo(BuildContext context, Widget screen) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => screen));

  ///  Navigate to a new route and remove all previous screens
  static pushAndRemove(BuildContext context, Widget screen) =>
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (route) => false,
      );

  /// Returns the `Rupees` symbol used in the application
  static const String currencySymbol = "\u20B9";

  /// Returns the primary border decoration for the text field

  static InputBorder get getInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.15)),
      borderRadius: BorderRadius.circular(5));
}
