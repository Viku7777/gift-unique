import 'package:color_game/user/View/Shop/shop_screen_view.dart';

import '../../../export_widget.dart';

class WishlistEmptyView extends StatelessWidget {
  bool isShowBottom;
  WishlistEmptyView({this.isShowBottom = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            // SvgPicture.asset(
            //   styleSheet.ICONS.FAVORITE_SVG,
            //   height: styleSheet.SPACING.extraLarge,
            //   width: styleSheet.SPACING.extraLarge,
            // ),
            Icon(
              Icons.favorite_border,
              size: styleSheet.SPACING.extraLarge,
            ),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            Text("Your wishlist is empty",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_18),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            Text(
              "Add items to your wishlist now so you don't forget to add to cart later.",
              style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            CustomPrimaryBtnView(
                btnName: "CONTINUE SHOPPING",
                onPressed: () {
                  Get.to(() => ShopScreenView());
                }),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
          ],
        ).paddingAll(styleSheet.SPACING.large),
        if (isShowBottom) BottomWidgetView()
      ],
    );
  }
}
