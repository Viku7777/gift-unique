import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewOrderViewAdmin extends StatefulWidget {
  final String type;
  const NewOrderViewAdmin({super.key, this.type = "paymentpending"});

  @override
  State<NewOrderViewAdmin> createState() => _NewOrderViewAdminState();
}

class _NewOrderViewAdminState extends State<NewOrderViewAdmin> {
  var controller = Get.find<AdminController>();
  var textController = TextEditingController();
  var deliveryBoyController = TextEditingController();
  @override
  void initState() {
    controller.getOrdersDetails(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text((widget.type == OrderStatusType.paymentpending.name)
              ? "New Orders"
              : "Wishlist View"),
        ),
        body: GetBuilder<AdminController>(
          builder: (controller) {
            if (controller.loading) {
              return Container(
                color: Colors.black38,
                alignment: Alignment.center,
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 50,
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.allOrdersView.length,
                itemBuilder: (context, index) {
                  List<OrderDetailsModel> data0 =
                      controller.allOrdersView.reversed.toList();
                  OrderDetailsModel item = data0[index];
                  return Column(
                    children: [
                      ExpansionTile(
                          childrenPadding: EdgeInsetsDirectional.all(10),
                          title: Text(controller.allProducts
                              .firstWhere((e) => e.uuid == item.uuid)
                              .title),
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Varient")),
                                Expanded(flex: 2, child: Text(item.variantName))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Address")),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${item.address},${item.landmark},"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Amount")),
                                Expanded(
                                    flex: 2,
                                    child: Text("${item.variantPrice}/-"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Date ")),
                                Expanded(
                                    flex: 2,
                                    child: Text(DateFormat("DD-MM-y").format(
                                        DateTime.parse(item.dateofAdd!))))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Contact ")),
                                Expanded(
                                    flex: 2,
                                    child: Text(item.number.toString()))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (widget.type ==
                                OrderStatusType.paymentpending.name) ...[
                              Row(
                                children: [
                                  Expanded(child: Text("UTR ")),
                                  Expanded(
                                      flex: 2, child: Text(item.utr.toString()))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                            Row(
                              children: [
                                Expanded(child: Text("Location ")),
                                Expanded(
                                    flex: 2, child: Text(item.location ?? "--"))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.type ==
                                OrderStatusType.paymentpending.name)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.cancelOrder(item);
                                      },
                                      child: Text("Cancel")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.confirmOrder(item);
                                      },
                                      child: Text("Done"))
                                ],
                              )
                            else if (widget.type ==
                                    OrderStatusType.paymentdone.name ||
                                widget.type ==
                                    OrderStatusType.orderOntheway.name) ...[
                              TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                    hintText: "Location",
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (textController.text.isNotEmpty) {
                                          controller.shipOrder(
                                              item, textController.text);
                                          textController.clear();
                                        }
                                      },
                                      child: Text(widget.type ==
                                              OrderStatusType.orderOntheway.name
                                          ? "Update Order"
                                          : "Ship Order"))
                                ],
                              ),
                              if (widget.type ==
                                  OrderStatusType.orderOntheway.name) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: deliveryBoyController,
                                  decoration: InputDecoration(
                                      hintText: "Delivery Boy Number",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if (deliveryBoyController
                                                  .text.length ==
                                              10) {
                                            controller.outForDeliveryOrder(item,
                                                deliveryBoyController.text);
                                            deliveryBoyController.clear();
                                          }
                                        },
                                        child: Text("Out For Delivery"))
                                  ],
                                )
                              ]
                            ] else if (widget.type ==
                                OrderStatusType.outforDelivery.name)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.deliverdOrder(item);
                                      },
                                      child: Text("Order Delivered"))
                                ],
                              )
                            else
                              SizedBox()
                          ])
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
