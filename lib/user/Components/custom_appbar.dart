import '../../export_widget.dart';

PreferredSizeWidget customAppbar() {
  return AppBar(
    foregroundColor: styleSheet.COLORS.BLACK_COLOR,
    elevation: 0,
    backgroundColor: styleSheet.COLORS.WHITE,
    title: Image.asset(
      AppConfig.appLogo,
      width: styleSheet.SPACING.widthsmall,
    ),
  );
}

PreferredSizeWidget createstackAppbar() {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Get.offAllNamed("/");
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
    foregroundColor: styleSheet.COLORS.BLACK_COLOR,
    elevation: 0,
    backgroundColor: styleSheet.COLORS.WHITE,
    title: Image.asset(
      AppConfig.appLogo,
      width: styleSheet.SPACING.widthsmall,
    ),
  );
}
