import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:color_game/backend/auth/controller.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:color_game/screen/auth/components.dart';
import 'package:color_game/screen/auth/forgot.dart';
import 'package:color_game/screen/auth/signup.dart';
import 'package:color_game/screen/home/screen/splash_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isload = false;

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
                .25.sh.heightBox,
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
                .035.sh.heightBox,
                TextInputFieldMade(
                  controller: _password,
                  myicon: Icons.lock,
                  myLableText: "Password",
                  isVisible: true,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ));
                    },
                    child: Text("Forgot Password",
                        style: GetTextTheme.fs_12_Medium
                            .copyWith(color: Colors.white)),
                  ),
                ),
                .015.sh.heightBox,
                InkWell(
                  onTap: () async {
                    if (authController.loading) {
                      AppHelperWidgets.showSnackbar(
                          context,
                          AnimatedSnackBarType.warning,
                          "Oops...",
                          "please wait for few seconds");
                    } else {
                      if (_emailController.text.isEmpty ||
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
                      } else {
                        authController.loginController(
                            _emailController.text, _password.text, context);
                      }
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
                                "Login",
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderColor)),
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text(
                        "Don't Have Account?",
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
  }
}
