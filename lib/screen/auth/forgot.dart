import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/backend/auth/controller.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:color_game/screen/auth/components.dart';
import 'package:color_game/screen/home/screen/splash_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  bool isload = false;

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveScreens(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  15.h.heightBox,
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.symmetric(
                          vertical: 20.h,
                        ),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  .20.sh.heightBox,
                  Text(AppConfig.appName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w600)),
                  .05.sh.heightBox,
                  TextInputFieldMade(
                      controller: _emailController,
                      myicon: Icons.email,
                      myLableText: "Email"),
                  .05.sh.heightBox,
                  InkWell(
                    onTap: () {
                      if (!EmailValidator.validate(_emailController.text)) {
                        AppHelperWidgets.showSnackbar(
                            context,
                            AnimatedSnackBarType.warning,
                            "Error",
                            "Please Enter A Valid Email Adress");
                      } else {
                        authController.forgotPassword(
                            _emailController.text, context);
                      }
                    },
                    child: Consumer<AuthController>(
                      builder: (context, value, child) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: borderColor)),
                          width: double.infinity,
                          height: 45.h,
                          alignment: Alignment.center,
                          child: value.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Forgot Password",
                                  style: GetTextTheme.fs_18_Medium.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: backgroundColor,
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         customSizebox(Get.height * 0.05),
    //         InkWell(
    //           onTap: () => Get.back(),
    //           child: Container(
    //             height: 35,
    //             width: 35,
    //             alignment: Alignment.center,
    //             decoration: const BoxDecoration(
    //                 color: Colors.white, shape: BoxShape.circle),
    //             child: const Icon(
    //               Icons.arrow_back,
    //               size: 25,
    //               color: Colors.black,
    //             ),
    //           ),
    //         ),
    //         customSizebox(Get.height * 0.20),
    //         Align(
    //           alignment: Alignment.center,
    //           child: Text("Get Color's",
    //               style: GoogleFonts.poppins(
    //                   color: Colors.white,
    //                   fontSize: 38,
    //                   fontWeight: FontWeight.w600)),
    //         ),
    //         const SizedBox(
    //           height: 35,
    //         ),
    //         TextInputFieldMade(
    //             controller: _emailController,
    //             myicon: Icons.email,
    //             myLableText: "Email"),
    //         customSizebox(Get.height * 0.05),

    //         StatefulBuilder(builder: (context, pro) {
    //           return isload
    //               ? const CircularProgressIndicator(
    //                   color: Colors.white,
    //                 )
    //               : InkWell(
    //                   onTap: () async {
    //                     if (_emailController.text.isEmpty) {
    //                       Get.snackbar(
    //                           backgroundColor: Colors.white,
    //                           "Error",
    //                           "Please Enter Any Email ");
    //                     } else if (!EmailValidator.validate(
    //                         _emailController.text)) {
    //                       Get.snackbar(
    //                           backgroundColor: Colors.white,
    //                           "Error",
    //                           "Please Enter any Valid Email");
    //                     } else {
    //                       await forgot(context, _emailController.text);
    //                     }
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(20),
    //                         border: Border.all(color: borderColor)),
    //                     width: Get.width,
    //                     height: 45,
    //                     child: Obx(
    //                       () => Center(
    //                         child: loadingController.loding
    //                             ? widgetShowLoading()
    //                             : Text("Forgot Password",
    //                                 style: GoogleFonts.poppins(
    //                                     color: Colors.white,
    //                                     fontSize: 20,
    //                                     fontWeight: FontWeight.w500)),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //         }),
    //       ],
    //     ),
    //   ),
    // );
  }
}
