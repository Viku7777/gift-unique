// ignore_for_file: must_be_immutable

import 'package:color_game/user/View/Dashboard/Widgets/customer_puchased.dart';
import 'package:color_game/user/View/Dashboard/Widgets/popular_product_list.dart';
import 'package:shimmer/shimmer.dart';

import '../../../export_widget.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  var productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: productController,
      builder: (controller) => controller.isloading
          ? ListView(
              shrinkWrap: true,
              children: [
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                Image.asset("assets/image/Banner.png"),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Popular Products",
                          style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
                        ),
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Pick your unique Gift",
                          style: styleSheet.TEXT_Rubik.FS_REGULAR_14
                              .copyWith(color: styleSheet.COLORS.TXT_GREY),
                        ),
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      // POPULAR PRODUCT LIST VIEW
                      PopularProductListView(),
                    ],
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              children: [
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                Image.asset("assets/image/Banner.png"),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Popular Products",
                    style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
                  ),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pick your unique Gift",
                    style: styleSheet.TEXT_Rubik.FS_REGULAR_14
                        .copyWith(color: styleSheet.COLORS.TXT_GREY),
                  ),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

                // POPULAR PRODUCT LIST VIEW
                PopularProductListView(),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
                // Customer Purchase View
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Customer Purchase Products",
                    style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
                  ),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                const CustomerPuchasedView(),

                // About US SLIDER VIEW
                // ignore: prefer_const_constructors
                AboutUsSliderView(),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),

                // Bottom WIDGET VIEW
                BottomWidgetView(),
              ],
            ),
    );
  }
}
