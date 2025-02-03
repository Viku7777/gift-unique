import 'package:color_game/admin/add_products.dart';
import 'package:color_game/admin/category_view.dart';
import 'package:color_game/admin/check_user.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/admin/home_order_view.dart';
import 'package:color_game/admin/order_view.dart';
import 'package:color_game/admin/product_view.dart';
import 'package:color_game/export_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // var adminController = AdminController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: GetBuilder<AdminController>(
        builder: (controller) => controller.loading
            ? Container(
                color: Colors.black38,
                alignment: Alignment.center,
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 50,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                      Row(
                        children: [
                          {
                            "title": "Total's Visit",
                            "count": controller.admindata.totalVisit,
                          },
                          {
                            "title": "Total's Order",
                            "count": controller.admindata.totalOrder,
                          }
                        ]
                            .map((e) => Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: e["title"] == "Total's Visit"
                                            ? 20
                                            : 0),
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        "${e["title"]} \n ${e["count"]}",
                                        style:
                                            styleSheet.TEXT_Rubik.FS_REGULAR_12,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      PrimaryTextFieldView(
                        hintText: "Enter your upi",
                        label: "UPI",
                        controller: controller.upi,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                      PrimaryTextFieldView(
                        hintText: "Contact Number",
                        label: "Enter Number",
                        controller: controller.number,
                        keyboardType: TextInputType.number,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                      PrimaryTextFieldView(
                        hintText: "Enter Delivery Charges",
                        label: "Enter Delivery",
                        controller: controller.deliveryCharges,
                        keyboardType: TextInputType.number,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      SizedBox(
                          width: double.maxFinite,
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.editDetails();
                              },
                              child: Text("Change"))),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AdminOrderView());
                                },
                                child: Text("Check Order")),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => WishListView());
                                },
                                child: Text("Wishlist")),
                          )),
                        ],
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => CategoryView());
                                },
                                child: Text("Categorys")),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AdminProductView());
                                },
                                child: Text("Products")),
                          )),
                        ],
                      ),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                      SizedBox(
                          width: double.maxFinite,
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => HomeOrderViewAdmin());
                              },
                              child: Text("Home Products"))),
                      styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
