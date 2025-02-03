// ignore_for_file: must_be_immutable

import '../../../../export_widget.dart';

class SingupWidgetView extends StatelessWidget {
  Function() ontap;
  SingupWidgetView({required this.ontap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Register to Our Store",
            style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
          ),
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Register to our store an start shopping your products",
            style: styleSheet.TEXT_Rubik.FS_REGULAR_14
                .copyWith(color: styleSheet.COLORS.TXT_GREY),
          ),
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
        PrimaryTextFieldView(
          hintText: "Enter Your Fist Name",
          label: "First name",
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        PrimaryTextFieldView(
          hintText: "Enter Your Last Name",
          label: "Last name",
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        PrimaryTextFieldView(
          hintText: "Enter Your Email Here",
          label: "Email",
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        PrimaryTextFieldView(
          hintText: "********",
          label: "Password",
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        CustomPrimaryBtnView(btnName: "CREATE ACCOUNT IN", onPressed: () {})
            .paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            CustomTxtBtnView(txt: "Login here", onTap: () => ontap()),
          ],
        ),
      ],
    );
  }
}
