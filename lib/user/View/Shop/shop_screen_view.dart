// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/View/Dashboard/Widgets/customer_puchased.dart';
import 'package:color_game/user/View/Dashboard/Widgets/new_product_cart.dart';
import 'package:color_game/user/View/Dashboard/Widgets/popular_product_list.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/user/View/Dashboard/new_product_details_view.dart';

class ShopScreenView extends StatefulWidget {
  bool showAppbar;
  ShopScreenView({super.key, this.showAppbar = true});

  @override
  State<ShopScreenView> createState() => _ShopScreenViewState();
}

class _ShopScreenViewState extends State<ShopScreenView> {
  String? _selectedValue;
  var productController = Get.find<ProductController>();
  List<NewProductModel> sortProduct = [];

  @override
  void initState() {
    sortProduct = productController.allProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppbar ? customAppbar() : null,
      body: ListView(
        shrinkWrap: true,
        children: [
          styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                styleSheet.ICONS.FILTER_SVG,
                color: styleSheet.COLORS.BLACK_COLOR,
              ),
              styleSheet.SPACING.addWidth(styleSheet.SPACING.medium),
              DropdownButton<String>(
                elevation: 0,
                hint: Text("Sort Item"),
                underline: const SizedBox(),
                // isExpanded: true,
                value: _selectedValue,
                items: <String>[
                  'Price, Low to High',
                  'Price, High to Low',
                  'Date, old to new',
                  'Date, new to old'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  _selectedValue = newValue;
                  List<NewProductModel> myList = productController.allProducts;
                  if (newValue == "Price, Low to High") {
                    myList.sort((a, b) => a.price.compareTo(b.price));
                  } else if (newValue == "Price, High to Low") {
                    myList.sort((a, b) => b.price.compareTo(a.price));
                  } else if (newValue == "Date, old to new") {
                    myList.sort((a, b) => a.createAt!.compareTo(b.createAt!));
                  } else {
                    myList.sort((a, b) => b.createAt!.compareTo(a.createAt!));
                  }
                  sortProduct = myList;

                  setState(() {});
                },
              ),
            ],
          ).paddingOnly(left: styleSheet.SPACING.large),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
          GetBuilder(
            init: productController,
            builder: (controller) => GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 30,
                childAspectRatio: 0.68,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sortProduct.length,
              itemBuilder: (context, index) {
                var pr = sortProduct[index];
                return GestureDetector(
                    onTap: () =>
                        Get.to(() => NewProductDetailsView(productModel: pr)),
                    child: NewProductCardView(product: pr));
              },
            ),
          ),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Customer Purchase Products",
              style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
            ),
          ),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
          const CustomerPuchasedView(),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
          BottomWidgetView()
        ],
      ),
    );
  }
}
