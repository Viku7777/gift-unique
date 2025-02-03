// ignore_for_file: must_be_immutable
import 'package:color_game/admin/controller/admin_controller.dart';

import '../../../../export_widget.dart';

class LoginWidgetView extends StatefulWidget {
  Function() ontap;
  LoginWidgetView({required this.ontap, super.key});

  @override
  State<LoginWidgetView> createState() => _LoginWidgetViewState();
}

class _LoginWidgetViewState extends State<LoginWidgetView> {
  var adminController = Get.put(AdminController());
  var phone = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Sign In as admin",
            style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
          ),
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Login helps speed up the checkout process",
            style: styleSheet.TEXT_Rubik.FS_REGULAR_14
                .copyWith(color: styleSheet.COLORS.TXT_GREY),
          ),
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
        PrimaryTextFieldView(
          hintText: "********",
          label: "Phone",
          controller: phone,
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        PrimaryTextFieldView(
          hintText: "********",
          label: "Password",
          controller: password,
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        CustomPrimaryBtnView(
            btnName: "SIGN IN",
            onPressed: () {
              if (phone.text.isEmpty || password.text.isEmpty) {
                Get.snackbar("Error", "Please enter both details");
              } else {}
            }).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
      ],
    );
  }
}
