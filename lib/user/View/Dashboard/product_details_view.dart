// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:color_game/user/Components/photo_view.dart';
import 'package:color_game/user/Utils/Controller/cart_controller.dart';
import 'package:color_game/user/Utils/Model/product_model.dart';
import 'package:color_game/user/View/Dashboard/Widgets/custom_card.dart';
import 'package:color_game/user/View/Dashboard/Widgets/customer_puchased.dart';

import '../../../export_widget.dart';

class ProductDetailsView extends StatelessWidget {
  ProductModel productModel;
  ProductDetailsView({required this.productModel, super.key});

  var designController = Get.find<DesignController>();
  var product = Get.find<ProductController>();
  var cart = Get.find<CartController>();

  final RxInt _productImageIndex = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 350,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: styleSheet.COLORS.WHITE,
                          borderRadius: BorderRadius.circular(
                              styleSheet.SHAPES.RADIUS_MEDIUM)),
                      child: Image.network(
                        productModel
                            .images[_productImageIndex.value], // Replace with
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              styleSheet.SHAPES.RADIUS_MIN),
                          color: styleSheet.COLORS.ERROR,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => Get.to(PhotoScreenView(
                              imgURL: productModel
                                  .images[_productImageIndex.value])),
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: styleSheet.SPACING.PADDING_SMALL,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Icon(
                              Icons.zoom_in_map_outlined,
                              size: 28,
                              color: styleSheet.COLORS.TXT_BLACK,
                            ),
                          ),
                        ))
                  ],
                ),
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              // Thumbnail images
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(productModel.images.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _productImageIndex(index);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(right: styleSheet.SPACING.small),
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _productImageIndex.value == index
                                      ? styleSheet.COLORS.BLACK_COLOR
                                      : styleSheet.COLORS.WHITE,
                                  width: 2),
                              borderRadius: BorderRadius.circular(
                                  styleSheet.SHAPES.RADIUS_MIN)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                styleSheet.SHAPES.RADIUS_MIN),
                            child: Image.network(
                              productModel
                                  .images[index], // Replace with thumbnail

                              // fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              const Divider(),
              // Product Title

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Text(
                productModel.title,
                // 'Wooden Slice Engraved photo frame',
                style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_24,
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Row(
                children: [
                  RatingStars(
                    starColor: styleSheet.COLORS.YELLOW,
                    valueLabelVisibility: false,
                    maxValueVisibility: false,
                    value: 5,
                    starSize: 15,
                  ),
                  const Text(" (8)"),
                ],
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              // Price Section
              Row(
                children: [
                  Text(
                    'Rs. ${productModel.price}',
                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_24,
                  ),
                  styleSheet.SPACING.addWidth(styleSheet.SPACING.small),
                  Text(
                    'Rs. ${productModel.lineThroughPrice}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

              // COD & Shipping Text
              Text(
                'Cash On Delivery (COD) + Free Shipping',
                style: styleSheet.TEXT_Rubik.FS_REGULAR_16,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              // SIZES

              const Text("SELECT SIZE 5-6 Inches"),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(productModel.size.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            designController.initialSize(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: styleSheet.SPACING.medium),
                            alignment: Alignment.center,
                            padding: styleSheet.SPACING.horizontalPadding,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: styleSheet.COLORS.GREY_LIGHT),
                              color: designController.initialSize.value == index
                                  ? styleSheet.COLORS.BLACK_COLOR
                                  : styleSheet.COLORS.WHITE,
                              borderRadius: BorderRadius.circular(
                                  styleSheet.SHAPES.RADIUS_MIN),
                            ),
                            child: Text(
                              productModel.size[index],
                              style: TextStyle(
                                  color: designController.initialSize.value ==
                                          index
                                      ? styleSheet.COLORS.WHITE
                                      : styleSheet.COLORS.BLACK_COLOR),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                );
              }),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              const Text("Write Message Here"),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

              SecondaryTextFieldView(
                hintText: "Any message you want to print on it..",
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              const Text("Upload Here"),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

              Container(
                width: Get.width,
                padding: styleSheet.SPACING.PADDING_MEDIUM,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM),
                  border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: styleSheet.SPACING.PADDING_SMALL,
                      decoration: BoxDecoration(
                        color: styleSheet.COLORS.ACTIVE_GREEN,
                        borderRadius:
                            BorderRadius.circular(styleSheet.SHAPES.RADIUS_MIN),
                        border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                      ),
                      child: Text(
                        "Choose file",
                        style: TextStyle(color: styleSheet.COLORS.WHITE),
                      ),
                    ),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                    const Text("or drop file to upload"),
                  ],
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              CustomPrimaryBtnView(
                      btnName: "ADD TO CART - COD AVAILABLE",
                      onPressed: () {
                        // cart.productList.add(productModel);
                      })
                  .paddingSymmetric(horizontal: styleSheet.SPACING.large),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              Container(
                padding: styleSheet.SPACING.PADDING_SMALL,
                decoration: BoxDecoration(
                    border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                    borderRadius:
                        BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM)),
                child: Text(
                  "Order with in the next 22 Ht 52 Min to receive your gift between Dec 24 - Dec 25",
                  style: styleSheet.TEXT_Rubik.FS_MEDIUM_15
                      .copyWith(color: styleSheet.COLORS.ACTIVE_GREEN),
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              Row(
                children: [
                  Expanded(
                    child: CustomCardView(
                        image: styleSheet.ICONS.SHIPPING_CAR_SVG,
                        title: "free shipping"),
                  ),
                  styleSheet.SPACING.addWidth(styleSheet.SPACING.medium),
                  Expanded(
                    child: CustomCardView(
                        image: styleSheet.ICONS.RETURN_SVG,
                        title: "Free returns"),
                  ),
                ],
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              Row(
                children: [
                  Expanded(
                    child: CustomCardView(
                        image: styleSheet.ICONS.SUPPORT_SVG,
                        title: "Support 24/7"),
                  ),
                  styleSheet.SPACING.addWidth(styleSheet.SPACING.medium),
                  Expanded(
                    child: CustomCardView(
                        image: styleSheet.ICONS.SECURED_PAYMENT_SVG,
                        title: "Secured payments"),
                  ),
                ],
              ),

              // Desccription Section Start From here

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              const Divider(),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              const ExpansionTile(
                title: Text("Description"),
                children: [
                  Text(
                      """Expressing love through words is beautiful, but sometimes actions speak louder. This Natural Wooden Slice Photo Frame provides a unique and lasting way to say "I love you." Crafted from real wood. Personalize it with a cherished photo and message, making it a thoughtful and timeless bedside addition.

Material: Made from high-quality, natural wood for a rustic, authentic feel.

Sizes Available: Choose from 5×5, 6×6, 7×7, and 8×8 inches to best fit your space and preference.

Personalized and Thoughtful: Engrave a meaningful photo and message for a unique and memorable gift.
""")
                ],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              Align(
                alignment: Alignment.center,
                child: Text(
                  "5.0",
                  style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                  textAlign: TextAlign.center,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Based on 8 reviews",
                  style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
                  textAlign: TextAlign.center,
                ),
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: styleSheet.COLORS.BLACK_COLOR),
                        onPressed: () {},
                        child: const Text("Write a review")),
                  ),
                ],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
              const Divider(),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: product.reviewList.value.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, i) {
                    var data = product.reviewList.value[i];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            data.image!,
                            height: 110,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title!,
                                style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                              ),
                              styleSheet.SPACING
                                  .addHeight(styleSheet.SPACING.small),
                              RatingStars(
                                starColor: styleSheet.COLORS.YELLOW,
                                valueLabelVisibility: false,
                                maxValueVisibility: false,
                                value: data.rating!,
                                starSize: 15,
                              ),
                              styleSheet.SPACING
                                  .addHeight(styleSheet.SPACING.medium),
                              Text(data.description.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: styleSheet.TEXT_Rubik.FS_REGULAR_14)
                            ],
                          ).paddingAll(styleSheet.SPACING.medium)
                        ],
                      ),
                    );
                  }),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Text(
                    "    Guaranteed Sage Checkout    ",
                    style: styleSheet.TEXT_Rubik.FS_MEDIUM_18,
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "You may also like",
                  style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_24,
                  textAlign: TextAlign.center,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.7,
                ),
                itemCount: product.productList.length,
                itemBuilder: (context, index) {
                  var pr = product.productList[index];
                  return GestureDetector(
                    onTap: () => Get.to(ProductDetailsView(
                      productModel: pr,
                    )),
                    child: ProductCard(
                      product: pr,
                    ),
                  );
                },
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Customers also purchased",
                  style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_24,
                  textAlign: TextAlign.center,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              const CustomerPuchasedView(),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            ],
          ).paddingAll(styleSheet.SPACING.medium),
          BottomWidgetView()
        ],
      ),
    );
  }
}
