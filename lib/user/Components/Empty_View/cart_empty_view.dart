import 'package:color_game/user/View/Shop/shop_screen_view.dart';

import '../../../export_widget.dart';

class CartEmptyView extends StatelessWidget {
  bool isShowBottom;
  CartEmptyView({this.isShowBottom = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            Icon(
              Icons.shopping_bag,
              size: styleSheet.SPACING.extraLarge,
            ),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            Text("Your cart is empty",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_16),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            Text(
              "Looks like you haven't added any products to your cart yet.",
              style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
              textAlign: TextAlign.center,
            ),
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
