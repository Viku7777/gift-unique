// ignore_for_file: use_build_context_synchronously

import 'package:color_game/backend/notification/notification_services.dart';
import 'package:color_game/backend/offline_data/offline_data.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/screen/auth/login.dart';
import 'package:color_game/screen/home/screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(AppConfig.appName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 38.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  getData() {
    Future.delayed(const Duration(seconds: 1), () async {
      await NotificationServices.fmsg.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);

      String? savedUser =
          await OfflineData().getOfflineData(AppConfig().offlineUserDatakey);
      if (savedUser.isEmptyOrNull) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LogInScreen(),
            ),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  HomeView(isSavedUser: true, uid: savedUser!),
            ),
            (route) => false);
      }
    });
  }
}

// ignore_for_file: must_be_immutable

class ResponsiveScreens extends StatelessWidget {
  final Widget child;
  Color bgclr;
  ResponsiveScreens(
      {super.key, required this.child, this.bgclr = Colors.black});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgclr,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth > 600
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Container(
                      width: 380,
                      height: size.height * 0.9,
                      // padding: const EdgeInsets.symmetric(
                      //   horizontal: 10,
                      // ),
                      decoration: BoxDecoration(
                          color: bgclr,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: child))
              : child;
        }),
      ),
    );
  }
}
