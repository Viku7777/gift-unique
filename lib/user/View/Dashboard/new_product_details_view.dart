// ignore_for_file: invalid_use_of_protected_member, must_be_immutable, override_on_non_overriding_member

import 'dart:developer' as dev;
import 'dart:io';
import 'dart:html' as html;
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Components/photo_view.dart';
import 'package:color_game/user/Utils/Controller/cart_controller.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/View/Dashboard/Widgets/custom_card.dart';
import 'package:color_game/user/View/Dashboard/Widgets/customer_puchased.dart';
import 'package:color_game/user/View/Dashboard/Widgets/new_product_cart.dart';
import 'package:color_game/user/View/Order/order_summary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../export_widget.dart';

class NewProductDetailsView extends StatefulWidget {
  NewProductModel productModel;
  bool clearstack;
  NewProductDetailsView(
      {required this.productModel, super.key, this.clearstack = false});

  @override
  State<NewProductDetailsView> createState() => _NewProductDetailsViewState();
}

class _NewProductDetailsViewState extends State<NewProductDetailsView> {
  var designController = Get.find<DesignController>();

  var product = Get.find<ProductController>();
  Uint8List? _imageData;
  var cart = Get.find<CartController>();
  var orderController = Get.find<OrderController>();

  var dateTime = DateTime.now();

  final RxInt _productImageIndex = RxInt(0);
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    designController.initialSize.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.clearstack ? createstackAppbar() : customAppbar(),
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
                      child: CachedNetworkImage(
                        imageUrl: widget.productModel
                            .images[_productImageIndex.value], // Replace with
                        fit: BoxFit.fitHeight,
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
                              imgURL: widget.productModel
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
                    ...List.generate(widget.productModel.images.length,
                        (index) {
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
                              widget.productModel
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
              Row(
                children: [
                  Text(
                    widget.productModel.title,
                    // 'Wooden Slice Engraved photo frame',
                    style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_24,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        String currentUrl = html.window.location.host;

                        Clipboard.setData(ClipboardData(
                            text:
                                "https://$currentUrl/#/product/${widget.productModel.uuid}"));
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,
                      ))
                ],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Row(
                children: [
                  RatingStars(
                    starColor: styleSheet.COLORS.YELLOW,
                    valueLabelVisibility: false,
                    maxValueVisibility: false,
                    value: widget.productModel.rating.toDouble(),
                    starSize: 15,
                  ),
                  Text(" (${widget.productModel.totalrating})"),
                ],
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              // Price Section
              if (widget.productModel.variant.isEmpty)
                Row(
                  children: [
                    Text(
                      'Rs. ${widget.productModel.price}',
                      style: styleSheet.TEXT_Rubik.FS_MEDIUM_24,
                    ),
                    styleSheet.SPACING.addWidth(styleSheet.SPACING.small),
                    Text(
                      'Rs. ${widget.productModel.oldPrice}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              else
                Obx(
                  () => Row(
                    children: [
                      Text(
                        'Rs. ${widget.productModel.variant[designController.initialSize.value].finalprice}',
                        style: styleSheet.TEXT_Rubik.FS_MEDIUM_24,
                      ),
                      styleSheet.SPACING.addWidth(styleSheet.SPACING.small),
                      Text(
                        'Rs. ${widget.productModel.variant[designController.initialSize.value].price}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

              // COD & Shipping Text
              Text(
                'Free Shipping',
                style: styleSheet.TEXT_Rubik.FS_REGULAR_16,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              // SIZES

              if (widget.productModel.variant.length > 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SELECT VARIANT"),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                    Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(widget.productModel.variant.length,
                                (index) {
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
                                    color: designController.initialSize.value ==
                                            index
                                        ? styleSheet.COLORS.BLACK_COLOR
                                        : styleSheet.COLORS.WHITE,
                                    borderRadius: BorderRadius.circular(
                                        styleSheet.SHAPES.RADIUS_MIN),
                                  ),
                                  child: Text(
                                    widget.productModel.variant[index].title,
                                    style: TextStyle(
                                        color: designController
                                                    .initialSize.value ==
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
                  ],
                ),

              if (widget.productModel.isImageRequired != false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Write Message Here"),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                    SecondaryTextFieldView(
                      controller: messageController,
                      hintText: "Any message you want to print on it..",
                    ),
                    styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                    if (widget.productModel.isImageRequired == true) ...[
                      Text("Upload Here"),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                      if (_imageData == null) ...[
                        Container(
                          width: Get.width,
                          padding: styleSheet.SPACING.PADDING_MEDIUM,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                styleSheet.SHAPES.RADIUS_MEDIUM),
                            border:
                                Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: styleSheet.SPACING.PADDING_SMALL,
                                decoration: BoxDecoration(
                                  color: styleSheet.COLORS.ACTIVE_GREEN,
                                  borderRadius: BorderRadius.circular(
                                      styleSheet.SHAPES.RADIUS_MIN),
                                  border: Border.all(
                                      color: styleSheet.COLORS.GREY_LIGHT),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    XFile? img = await ImagePicker.platform
                                        .getImageFromSource(
                                            source: ImageSource.gallery);
                                    if (img == null) {
                                      Get.snackbar(
                                          "Error", "Image not Selected");
                                    } else {
                                      final bytes = await img.readAsBytes();
                                      _imageData = bytes;
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    "Choose file",
                                    style: TextStyle(
                                        color: styleSheet.COLORS.WHITE),
                                  ),
                                ),
                              ),
                              styleSheet.SPACING
                                  .addHeight(styleSheet.SPACING.small),
                              const Text("or drop file to upload"),
                            ],
                          ),
                        ),
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.medium)
                      ] else
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(bottom: 20),
                          padding: styleSheet.SPACING.PADDING_MEDIUM,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(
                              _imageData!,
                            )),
                            borderRadius: BorderRadius.circular(
                                styleSheet.SHAPES.RADIUS_MEDIUM),
                            border:
                                Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                          ),
                          child: IconButton(
                              onPressed: () {
                                _imageData = null;
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                        )
                    ]
                  ],
                ),

              Row(
                children: [
                  Expanded(
                    child: CustomPrimaryBtnView(
                        btnName: "ADD TO CART",
                        onPressed: () {
                          if (widget.productModel.isImageRequired != false &&
                              messageController.text.isEmpty) {
                            Get.snackbar("Error", "Please add a message");
                          } else if (widget.productModel.isImageRequired ==
                                  true &&
                              _imageData == null) {
                            Get.snackbar("Error", "Please select any image");
                          } else {
                            OrderDetailsModel order = OrderDetailsModel(
                                orderId: uniqueUUID,
                                uuid: widget.productModel.uuid,
                                message: messageController.text,
                                variantName: widget.productModel.variant.isEmpty
                                    ? "Default"
                                    : widget
                                        .productModel
                                        .variant[
                                            designController.initialSize.value]
                                        .title,
                                variantPrice: widget
                                        .productModel.variant.isEmpty
                                    ? widget.productModel.price
                                    : widget
                                        .productModel
                                        .variant[
                                            designController.initialSize.value]
                                        .finalprice);
                            orderController.addOrder(order);
                            Get.snackbar("Sucess", "Item added to cart");
                          }
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomPrimaryBtnView(
                        btnName: "Buy Now",
                        onPressed: () {
                          if (widget.productModel.isImageRequired != false &&
                              messageController.text.isEmpty) {
                            Get.snackbar("Error", "Please add a message");
                          } else if (widget.productModel.isImageRequired ==
                                  true &&
                              _imageData == null) {
                            Get.snackbar("Error", "Please select any image");
                          } else {
                            OrderDetailsModel order = OrderDetailsModel(
                                uuid: widget.productModel.uuid,
                                message: messageController.text,
                                orderId: Uuid().v4(),
                                variantName: widget.productModel.variant.isEmpty
                                    ? "Default"
                                    : widget
                                        .productModel
                                        .variant[
                                            designController.initialSize.value]
                                        .title,
                                variantPrice: widget
                                        .productModel.variant.isEmpty
                                    ? widget.productModel.price
                                    : widget
                                        .productModel
                                        .variant[
                                            designController.initialSize.value]
                                        .finalprice);
                            orderController.addOrder(order);

                            Get.to(() => OrderSummaryView(
                                  price: order.variantPrice +
                                      product.admindata.delivery,
                                  orderId: [order.orderId!],
                                ));
                          }
                        }),
                  )
                ],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              Container(
                padding: styleSheet.SPACING.PADDING_SMALL,
                decoration: BoxDecoration(
                    border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
                    borderRadius:
                        BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM)),
                child: Text(
                  "Order with in the next ${24 - dateTime.hour} Hr ${dateTime.minute - 60} Min to receive your gift between ${dateTime.day + 2}/${dateTime.month}/${dateTime.year} -${dateTime.day + 3}/${dateTime.month}/${dateTime.year}",
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
              ExpansionTile(
                title: Text("Description"),
                children: [Text(widget.productModel.description)],
              ),

              styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),

              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.productModel.rating.toString(),
                  style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                  textAlign: TextAlign.center,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Based on ${widget.productModel.totalrating} reviews",
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

              // GridView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: product.reviewList.value.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         childAspectRatio: 0.58,
              //         crossAxisSpacing: 15,
              //         mainAxisSpacing: 10),
              //     itemBuilder: (context, i) {
              //       var data = product.reviewList.value[i];
              //       return Container(
              //         decoration: BoxDecoration(
              //           border: Border.all(color: styleSheet.COLORS.GREY_LIGHT),
              //         ),
              //         child: Column(
              //           children: [
              //             Image.network(
              //               data.image!,
              //               height: 110,
              //               width: Get.width,
              //               fit: BoxFit.cover,
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   data.title!,
              //                   style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
              //                 ),
              //                 styleSheet.SPACING
              //                     .addHeight(styleSheet.SPACING.small),
              //                 RatingStars(
              //                   starColor: styleSheet.COLORS.YELLOW,
              //                   valueLabelVisibility: false,
              //                   maxValueVisibility: false,
              //                   value: data.rating!,
              //                   starSize: 15,
              //                 ),
              //                 styleSheet.SPACING
              //                     .addHeight(styleSheet.SPACING.medium),
              //                 Text(data.description.toString(),
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 4,
              //                     style: styleSheet.TEXT_Rubik.FS_REGULAR_14)
              //               ],
              //             ).paddingAll(styleSheet.SPACING.medium)
              //           ],
              //         ),
              //       );
              //     }),

              // styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              // Row(
              //   children: [
              //     const Expanded(child: Divider()),
              //     Text(
              //       "    Guaranteed Sage Checkout    ",
              //       style: styleSheet.TEXT_Rubik.FS_MEDIUM_18,
              //     ),
              //     const Expanded(child: Divider()),
              //   ],
              // ),
              // styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "You may also like",
                  style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_24,
                  textAlign: TextAlign.center,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

              Builder(builder: (context) {
                List<NewProductModel> youmayLikeProducts = product.allProducts
                    .where(
                        (e) => e.categoryID == widget.productModel.categoryID)
                    .toList();

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: youmayLikeProducts.isEmpty
                      ? 5
                      : youmayLikeProducts.length > 5
                          ? 5
                          : youmayLikeProducts.length,
                  itemBuilder: (context, index) {
                    var pr = youmayLikeProducts.isNotEmpty
                        ? youmayLikeProducts[index]
                        : product.allProducts[
                            Random().nextInt(product.allProducts.length - 1)];
                    return InkWell(
                      onTap: () =>
                          Get.to(() => NewProductDetailsView(productModel: pr)),
                      child: NewProductCardView(
                        product: pr,
                      ),
                    );
                  },
                );
              }),

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
