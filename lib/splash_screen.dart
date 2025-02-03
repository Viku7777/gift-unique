import 'package:color_game/user/Utils/Controller/product_controller.dart';
import 'package:color_game/user/View/Bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    getInitState();
    super.initState();
  }

  getInitState() {
    Get.find<ProductController>().loadProducts();
    Get.find<ProductController>().loadReviews();

    Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(() => BottomNavBarView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/image/Splash screen.svg",
        fit: BoxFit.fitWidth,
      ),
    ));
  }
}
