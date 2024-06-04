import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/backend/auth/controller.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:color_game/model/usermodel.dart';
import 'package:color_game/screen/auth/components.dart';
import 'package:color_game/screen/home/screen/splash_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _refercode = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _password.dispose();
    _name.dispose();
    _conPassword.dispose();
    _refercode.dispose();

    super.dispose();
  }

  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveScreens(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                .12.sh.heightBox,
                Text(AppConfig.appName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w600)),
                .05.sh.heightBox,
                TextInputFieldMade(
                    controller: _name,
                    myicon: Icons.person,
                    myLableText: "Name"),
                .025.sh.heightBox,
                TextInputFieldMade(
                  controller: _emailController,
                  myicon: Icons.email,
                  myLableText: "Email",
                ),
                .025.sh.heightBox,
                TextInputFieldMade(
                  controller: _password,
                  myicon: Icons.lock,
                  myLableText: "Password",
                  isVisible: true,
                ),
                .025.sh.heightBox,
                TextInputFieldMade(
                  controller: _conPassword,
                  myicon: Icons.lock,
                  myLableText: "Confirm Password",
                  isVisible: true,
                ),
                .025.sh.heightBox,
                TextInputFieldMade(
                  controller: _refercode,
                  myicon: Icons.person_add_alt_outlined,
                  myLableText: "Refer Code (Optional)",
                ),
                .025.sh.heightBox,
                InkWell(
                  onTap: () async {
                    if (_name.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _password.text.isEmpty) {
                      AppHelperWidgets.showSnackbar(
                          context,
                          AnimatedSnackBarType.warning,
                          "Error",
                          "Please Fill All The Required Filed's");
                    } else if (!EmailValidator.validate(
                        _emailController.text)) {
                      AppHelperWidgets.showSnackbar(
                          context,
                          AnimatedSnackBarType.warning,
                          "Error",
                          "Please Enter A Valid Email Adress");
                    } else if (_password.text != _conPassword.text) {
                      AppHelperWidgets.showSnackbar(
                          context,
                          AnimatedSnackBarType.warning,
                          "Error",
                          "Password and confirm password does not match");
                    } else {
                      if (authController.loading) {
                        AppHelperWidgets.showSnackbar(
                            context,
                            AnimatedSnackBarType.warning,
                            "Oops...",
                            "please wait for few seconds");
                      } else {
                        UserModel user = UserModel(
                            name: _name.text,
                            email: _emailController.text,
                            password: _password.text,
                            referby: _refercode.text,
                            referCode:
                                _emailController.text.hashCode.toString());
                        authController.signupController(user, context);
                      }
                      // await loginApi(
                      //     context, _emailController.text, _password.text);
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
                                "Sign Up",
                                style: GetTextTheme.fs_18_Medium.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              )),
                  ),
                ),
                15.h.heightBox,
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor)),
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text(
                        "Already Have Account?",
                        style: GetTextTheme.fs_18_Medium.copyWith(
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           child: Stack(children: [
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 // customSizebox(Get.height * 0.10),
    //                 Text("Get Color's",
    //                     style: GoogleFonts.poppins(
    //                         color: Colors.white,
    //                         fontSize: 38,
    //                         fontWeight: FontWeight.w600)),
    //                 const SizedBox(
    //                   height: 35,
    //                 ),
    //                 TextInputFieldMade(
    //                     controller: _name,
    //                     myicon: Icons.person,
    //                     myLableText: "Name"),
    //                 customSizebox(20),
    //                 TextInputFieldMade(
    //                   controller: _emailController,
    //                   myicon: Icons.email,
    //                   myLableText: "Email",
    //                 ),
    //                 customSizebox(20),
    //                 TextInputFieldMade(
    //                   controller: _password,
    //                   myicon: Icons.lock,
    //                   myLableText: "Password",
    //                   isVisible: true,
    //                 ),
    //                 customSizebox(20),
    //                 TextInputFieldMade(
    //                   controller: _conPassword,
    //                   myicon: Icons.lock,
    //                   myLableText: "Confirm Password",
    //                   isVisible: true,
    //                 ),
    //                 customSizebox(20),
    //                 TextInputFieldMade(
    //                   controller: _refercode,
    //                   myicon: Icons.person_add_alt_outlined,
    //                   myLableText: "Refer Code (Optional)",
    //                 ),
    //                 customSizebox(25),
    //                 InkWell(
    //                     onTap: () async {
    //                       if (_password.text.isEmpty ||
    //                           _conPassword.text.isEmpty ||
    //                           _name.text.isEmpty ||
    //                           _emailController.text.isEmpty) {
    //                         Get.snackbar(
    //                             "Error",
    //                             backgroundColor: Colors.white,
    //                             "Please Fill All The Required Filed's");
    //                       } else if (_password.text != _conPassword.text) {
    //                         Get.snackbar(
    //                             backgroundColor: Colors.white,
    //                             "Error",
    //                             "Please Enter Same Password");
    //                       } else if (!EmailValidator.validate(
    //                           _emailController.text)) {
    //                         Get.snackbar(
    //                             backgroundColor: Colors.white,
    //                             "Error",
    //                             "Please Enter A Valid Email Adress");
    //                       } else {
    //                         await signup(
    //                             UserModel(_name.text, _password.text,
    //                                 _emailController.text, _refercode.text, ""),
    //                             context);
    //                       }
    //                     },
    //                     child: Obx(
    //                       () => Container(
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(20),
    //                             border: Border.all(color: borderColor)),
    //                         width: Get.width,
    //                         height: 45,
    //                         child: Center(
    //                             child: loadingController.loding
    //                                 ? widgetShowLoading()
    //                                 : Text("SIGN UP",
    //                                     style: GoogleFonts.poppins(
    //                                         color: Colors.white,
    //                                         fontSize: 20,
    //                                         fontWeight: FontWeight.w500))),
    //                       ),
    //                     ))
    //               ],
    //             ),
    //             Positioned(
    //                 child: InkWell(
    //               onTap: () => Get.back(),
    //               child: Container(
    //                 height: 35,
    //                 width: 35,
    //                 alignment: Alignment.center,
    //                 decoration: const BoxDecoration(
    //                     color: Colors.white, shape: BoxShape.circle),
    //                 child: const Icon(
    //                   Icons.arrow_back,
    //                   size: 25,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ))
    //           ]),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
