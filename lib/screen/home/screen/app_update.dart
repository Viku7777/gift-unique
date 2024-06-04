// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AppUpdateView extends StatefulWidget {
  const AppUpdateView({super.key});

  @override
  State<AppUpdateView> createState() => _AppUpdateViewState();
}

class _AppUpdateViewState extends State<AppUpdateView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "New Update Found",
            style: GetTextTheme.fs_16_Medium,
          ),
          10.h.heightBox,
          ElevatedButton(
            onPressed: _launchUrl,
            style: ElevatedButton.styleFrom(
                fixedSize: Size(.8.sw, 45.h),
                backgroundColor: AppColor.primaryColor),
            child: Text("Update",
                style: GetTextTheme.fs_18_Bold.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
        Uri.parse(
          AppConfig.applink,
        ),
        mode: LaunchMode.externalApplication)) {
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.error,
          "Error", "Something Went Wrong!!");
    }
  }
}
