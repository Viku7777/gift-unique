// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  List<OrderDetailsModel> userOrders = [];
  List<OrderDetailsModel> userSubmitOrder = [];
  List<OrderDetailsModel> userpendingOrder = [];
  bool loading = false;
  updateLoading(bool status) {
    loading = status;
    update();
  }

  addOrder(OrderDetailsModel order) async {
    for (var element in userOrders) {
      if (element.uuid == order.uuid) {
        userOrders.removeWhere((e) => e.uuid == order.uuid);
      }
    }
    userOrders.add(order);
    update();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "Products", userOrders.map((e) => jsonEncode(e.toMap())).toList());
  }

  removeOrder(String orderId) async {
    log(orderId);

    userOrders.removeWhere((e) => e.orderId == orderId);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "Products", userOrders.map((e) => jsonEncode(e.toMap())).toList());
    update();
  }

  clearOrder() async {
    userOrders.clear();
    update();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("Products");

    update();
  }

  createOrder(String orderID, String utr) async {
    OrderDetailsModel order =
        userOrders.firstWhere((e) => e.orderId == orderID);
    order.utr = utr;
    order.status = "paymentpending";
    await orderRef.doc(orderID).set(order.toMap());
    removeOrder(orderID);
  }

  addTocartDetails(
    String orderID,
  ) async {
    OrderDetailsModel order =
        userOrders.firstWhere((e) => e.orderId == orderID);
    order.status = "ADDTOCART";
    await wishList.doc(orderID).set(order.toMap());
  }

  getOrders({String? number}) async {
    updateLoading(true);
    userSubmitOrder.clear();
    late QuerySnapshot orders;

    if (number != null) {
      orders = await orderRef.where("number", isEqualTo: number).get();
    } else {
      orders = await orderRef.get();
    }

    userSubmitOrder = orders.docs
        .map((e) => OrderDetailsModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    if (number != null && userSubmitOrder.isEmpty) {
      Get.snackbar("Error", "No order found");
      // orders = await orderRef.where("number", isEqualTo: number).get();
    } else {
      // orders = await orderRef.get();
    }

    updateLoading(false);
  }

  @override
  void onInit() async {
    log("here 1");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartprodcuts = prefs.getStringList("Products");
    if (cartprodcuts != null && cartprodcuts.isNotEmpty) {
      log("here 2");

      userOrders =
          cartprodcuts.map((e) => OrderDetailsModel.fromJson(e)).toList();
      update();
    }
    super.onInit();
  }
}

class OrderDetailsModel {
  final String uuid;
  final String? message;
  final String variantName;
  final num variantPrice;
  final String? dateofAdd;
  final String orderId;
  String? name;
  String? number;
  String? address;
  String? landmark;
  String? status;
  String? location;
  String? deliveryBoyNumber;
  num? finalPrice;
  String? utr;

  OrderDetailsModel({
    required this.uuid,
    required this.variantName,
    required this.variantPrice,
    this.dateofAdd,
    this.utr,
    this.message,
    required this.orderId,
    this.name,
    this.number,
    this.address,
    this.landmark,
    this.status,
    this.location,
    this.deliveryBoyNumber,
    this.finalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'variantName': variantName,
      'variantPrice': variantPrice,
      'dateofAdd': dateofAdd ?? DateTime.now().toIso8601String(),
      'utr': utr,
      'name': name,
      'number': number,
      'address': address,
      'landmark': landmark,
      "message": message,
      "orderID": orderId,
      'status': status,
      'location': location,
      'deliveryBoyNumber': deliveryBoyNumber,
      'finalPrice': finalPrice,
    };
  }

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      uuid: (map["uuid"] ?? '') as String,
      message: (map["message"] ?? '') as String,
      status: (map["status"] ?? '') as String,
      orderId: (map["orderID"] ?? '') as String,
      variantName: (map["variantName"] ?? '') as String,
      variantPrice: (map["variantPrice"] ?? 0) as num,
      dateofAdd: (map["dateofAdd"] ?? '') as String,
      utr: map['utr'] != null ? map["utr"] ?? "" : "",
      name: map['name'] != null ? map["name"] ?? '' : "",
      number: map['number'] != null ? map["number"] ?? '' : "",
      address: map['address'] != null ? map["address"] ?? '' : "",
      landmark: map['landmark'] != null ? map["landmark"] ?? '' : "",
      location: map['location'] != null ? map["location"] ?? '' : "",
      deliveryBoyNumber: map['deliveryBoyNumber'] != ""
          ? map["deliveryBoyNumber"] ?? ''
          : null,
      finalPrice: map['finalPrice'] != null ? map["finalPrice"] ?? 0 as num : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

String uniqueUUID = Uuid().v4();
