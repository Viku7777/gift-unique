// ignore_for_file: must_be_immutable
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Utils/Controller/wishlist_controller.dart';

import '../../../../export_widget.dart';

class NewProductCardView extends StatelessWidget {
  NewProductModel product;
  // String title;
  // String imageUrl;
  // String price;
  NewProductCardView(
      {required this.product,
      //   required this.imageUrl,
      // required this.price,
      // required this.title,
      super.key});

  var wishlistcontroller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: styleSheet.COLORS.WHITE,
            boxShadow: [styleSheet.SHAPES.DEFAULT_SHADOW],
            borderRadius:
                BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(styleSheet.SHAPES.RADIUS_MIN)),
                  child: Image.network(
                    product.images.first,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: styleSheet.SPACING.PADDING_LITTLE_SMALL,
                child: Column(
                  children: [
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                    Text(
                      product.title,
                      style: styleSheet.TEXT_Rubik.FS_REGULAR_18,
                      textAlign: TextAlign.center,
                    ),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs ${product.price}  ",
                          style: styleSheet.TEXT_Rubik.FS_REGULAR_18,
                        ),
                        Text(
                          "Rs ${product.oldPrice}",
                          style: styleSheet.TEXT_Rubik.FS_REGULAR_12
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            product.isSale == true
                ? Container(
                    margin: const EdgeInsets.only(left: 10, top: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(styleSheet.SHAPES.RADIUS_MIN),
                        color: styleSheet.COLORS.ERROR),
                    child: Text(
                      "Sale",
                      style: styleSheet.TEXT_Rubik.FS_REGULAR_12
                          .copyWith(color: styleSheet.COLORS.WHITE),
                    ),
                  )
                : SizedBox(),
            Column(
              children: [
                GetBuilder<WishlistController>(
                  builder: (controller) => IconButton(
                    onPressed: () {
                      controller.addOrder(product.uuid);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color:
                          controller.productList.any((e) => e == product.uuid)
                              ? Colors.red
                              : styleSheet.COLORS.GREY_LIGHT,
                    ),
                  ),
                ),
                styleSheet.SPACING.addHeight(10),
              ],
            ).paddingAll(styleSheet.SPACING.small)
          ],
        )
      ],
    );
  }
}

class AdminNewProductCard extends StatelessWidget {
  NewProductModel product;
  // String title;
  // String imageUrl;
  // String price;
  AdminNewProductCard(
      {required this.product,
      //   required this.imageUrl,
      // required this.price,
      // required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: styleSheet.COLORS.WHITE,
        boxShadow: [styleSheet.SHAPES.DEFAULT_SHADOW],
        borderRadius: BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(styleSheet.SHAPES.RADIUS_MIN)),
            child: Image.network(
              product.images.first,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: styleSheet.SPACING.PADDING_LITTLE_SMALL,
            child: Column(
              children: [
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                Text(
                  product.title,
                  style: styleSheet.TEXT_Rubik.FS_REGULAR_18,
                  textAlign: TextAlign.center,
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rs ${product.price}  ",
                      style: styleSheet.TEXT_Rubik.FS_REGULAR_18,
                    ),
                    Text(
                      "Rs ${product.oldPrice}",
                      style: styleSheet.TEXT_Rubik.FS_REGULAR_12
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
