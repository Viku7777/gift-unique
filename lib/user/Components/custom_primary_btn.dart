import '../../export_widget.dart';

class CustomPrimaryBtnView extends StatelessWidget {
  Function onPressed;
  String btnName;
  Color? bgColor;
  Color? txtColor;

  CustomPrimaryBtnView(
      {required this.btnName,
      required this.onPressed,
      this.bgColor,
      this.txtColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(styleSheet.SHAPES.RADIUS_MAX),
                ),
                backgroundColor: bgColor ?? styleSheet.COLORS.ACTIVE_GREEN),
            onPressed: () => onPressed(),
            child: Text(
              btnName,
              style: styleSheet.TEXT_Rubik.FS_REGULAR_14
                  .copyWith(color: txtColor ?? styleSheet.COLORS.WHITE),
            ),
          ),
        ),
      ],
    );
  }
}
