import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/admin/orders_view/new_orders.dart';
import 'package:color_game/export_widget.dart';

class AdminOrderView extends StatefulWidget {
  const AdminOrderView({super.key});

  @override
  State<AdminOrderView> createState() => _AdminOrderViewState();
}

class _AdminOrderViewState extends State<AdminOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
                width: double.maxFinite,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewOrderViewAdmin());
                    },
                    child: Text("New Order"))),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            SizedBox(
                width: double.maxFinite,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewOrderViewAdmin(
                            type: OrderStatusType.paymentdone.name,
                          ));
                    },
                    child: Text("Ready For Ship"))),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            SizedBox(
                width: double.maxFinite,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewOrderViewAdmin(
                            type: OrderStatusType.orderOntheway.name,
                          ));
                    },
                    child: Text("On The Way Order"))),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            SizedBox(
                width: double.maxFinite,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewOrderViewAdmin(
                            type: OrderStatusType.outforDelivery.name,
                          ));
                    },
                    child: Text("Out For Delivery Order"))),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
            SizedBox(
                width: double.maxFinite,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => NewOrderViewAdmin(
                            type: OrderStatusType.delivered.name,
                          ));
                    },
                    child: Text("Delivery Order"))),
          ],
        ),
      ),
    );
  }
}


//  if (status == OrderStatusType.paymentpending.name) {
//       activeStep = 0;
//     } else if (status == OrderStatusType.paymentdone.name) {
//       activeStep = 1;
//     } else if (status == OrderStatusType.orderOntheway.name) {
//       activeStep = 2;
//     } else if (status == OrderStatusType.outforDelivery.name) {
//       activeStep = 2;
//     } else {
//       activeStep = 4;
//     }