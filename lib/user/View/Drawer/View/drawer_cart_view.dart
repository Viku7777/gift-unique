// ignore_for_file: must_be_immutable

import 'package:color_game/user/Components/Empty_View/cart_empty_view.dart';
import 'package:color_game/user/Utils/Controller/cart_controller.dart';
import 'package:color_game/user/Utils/stylesheet/style_manager.dart';
import 'package:color_game/export_widget.dart';

class DrawerViewForCart extends StatelessWidget {
  DrawerViewForCart({super.key});

  var cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close)),
          ],
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        cartController.productList.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: styleSheet.SPACING.medium),
                      separatorBuilder: (context, index) => styleSheet.SPACING
                          .addHeight(styleSheet.SPACING.small),
                      shrinkWrap: true,
                      itemCount: cartController.productList.length,
                      itemBuilder: (context, i) {
                        var item = cartController.productList[i];
                        return Container(
                          padding: styleSheet.SPACING.PADDING_SMALL,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  styleSheet.SHAPES.RADIUS_MEDIUM),
                              boxShadow: [styleSheet.SHAPES.DEFAULT_SHADOW],
                              color: styleSheet.COLORS.WHITE),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          styleSheet.SHAPES.RADIUS_MEDIUM),
                                    ),
                                    child: Image.network(item.images.first),
                                  ),
                                  styleSheet.SPACING
                                      .addWidth(styleSheet.SPACING.small),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs ${item.price}",
                                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_18,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove)),
                                      const Text("1"),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
                  Container(
                    padding: EdgeInsets.only(right: styleSheet.SPACING.medium),
                    decoration: BoxDecoration(
                      color: styleSheet.COLORS.GREY_LIGHT.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "SUBTOTAL : Rs 1,299.00",
                            style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                          ),
                        ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        PrimaryTextFieldView(
                          hintText: "Order Special Instructions",
                        ).paddingSymmetric(
                            horizontal: styleSheet.SPACING.large),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        CustomPrimaryBtnView(
                            bgColor: styleSheet.COLORS.GREY_LIGHT,
                            btnName:
                                "VIEW MY CART (${cartController.productList.length})",
                            onPressed: () {}),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        CustomPrimaryBtnView(
                            btnName: "PROCEED TO CHECKOUT", onPressed: () {}),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                        TextButton.icon(
                          onPressed: () {},
                          label: const Text("Clear cart"),
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : CartEmptyView(
                isShowBottom: false,
              )
      ],
    );
  }
}
