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
