import '../../export_widget.dart';

class PhotoScreenView extends StatelessWidget {
  String imgURL;
  PhotoScreenView({required this.imgURL, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: styleSheet.COLORS.BLACK_COLOR.withOpacity(0.2),
              child: PhotoView(imageProvider: NetworkImage(imgURL)),
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: styleSheet.COLORS.WHITE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
