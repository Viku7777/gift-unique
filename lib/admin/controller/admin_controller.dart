// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:uuid/uuid.dart';

import 'package:color_game/export_widget.dart';

var categoryRef = FirebaseFirestore.instance.collection("categorys");
var adminRef = FirebaseFirestore.instance.collection("admin");
var productsRef = FirebaseFirestore.instance.collection("products");
var orderRef = FirebaseFirestore.instance.collection("orders");
var wishList = FirebaseFirestore.instance.collection("wishList");
var productIndexRef = FirebaseFirestore.instance.collection("index");

enum OrderStatusType {
  paymentpending,
  paymentdone,
  orderOntheway, // location compalsury
  outforDelivery, // delivery boy number compalusry
  delivered
}

class AdminController extends GetxController {
  List<NewProductModel> allProducts = [];
  List<CategoryModel> allCategorys = [];
  List<OrderDetailsModel> wishlistItem = [];
  List<OrderDetailsModel> allOrdersView = [];
  TextEditingController number = TextEditingController();
  TextEditingController upi = TextEditingController();
  TextEditingController deliveryCharges = TextEditingController();
  late AdminModel admindata;
  bool loading = true;
  updateloading(value) {
    loading = value;
    update();
  }

  Future<void> getOrdersDetails(String type) async {
    try {
      log(type);
      await Future.delayed(Duration.zero);
      updateloading(true);
      var data = await orderRef.where("status", isEqualTo: type).get();
      // var data = await orderRef.get();

      allOrdersView =
          data.docs.map((e) => OrderDetailsModel.fromMap(e.data())).toList();
      for (var element in allOrdersView) {
        log("===> ${element.toJson()} <===");
      }
      updateloading(false);
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", e.toString());
      updateloading(false);
    }
  }

  Future<void> getWishlistProducts() async {
    try {
      await Future.delayed(Duration.zero);
      updateloading(true);
      var data = await wishList.get();
      wishlistItem =
          data.docs.map((e) => OrderDetailsModel.fromMap(e.data())).toList();
      updateloading(false);
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", e.toString());
      updateloading(false);
    }
  }

  Future<void> cancelOrder(OrderDetailsModel item) async {
    allOrdersView.remove(item);
    update();
    await orderRef.doc(item.orderId).update({"status": "payment_failed"});
  }

  Future<void> confirmOrder(OrderDetailsModel item) async {
    allOrdersView.remove(item);
    update();
    await orderRef
        .doc(item.orderId)
        .update({"status": OrderStatusType.paymentdone.name});
    await adminRef.doc("999").update({
      "totalOrder": FieldValue.increment(1),
    });
  }

  Future<void> shipOrder(OrderDetailsModel item, String location) async {
    allOrdersView.remove(item);
    update();
    await orderRef.doc(item.orderId).update({
      "status": OrderStatusType.orderOntheway.name,
      "location": location,
    });
  }

  Future<void> deleteWishlist(
    OrderDetailsModel item,
  ) async {
    wishlistItem.remove(item);
    update();
    await wishList.doc(item.orderId).delete();
    // await orderRef.doc(item.orderId).update({
    //   "status": OrderStatusType.orderOntheway.name,
    //   "location": location,
    // });
  }

  Future<void> outForDeliveryOrder(
      OrderDetailsModel item, String number) async {
    allOrdersView.remove(item);
    update();
    await orderRef.doc(item.orderId).update({
      "status": OrderStatusType.outforDelivery.name,
      "deliveryBoyNumber": number,
    });
  }

  Future<void> deliverdOrder(
    OrderDetailsModel item,
  ) async {
    allOrdersView.remove(item);
    update();
    await orderRef.doc(item.orderId).update({
      "status": OrderStatusType.delivered.name,
    });
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    var data = await categoryRef.get();
    var data1 = await productsRef.get();
    var data2 = await adminRef.doc("999").get();
    admindata = AdminModel.fromMap(data2.data() as Map<String, dynamic>);
    number.text = admindata.number;
    upi.text = admindata.upi;
    deliveryCharges.text = admindata.delivery.toString();
    if (data.docs.isNotEmpty) {
      allCategorys =
          data.docs.map((e) => CategoryModel.fromMap(e.data())).toList();
      update();
    }
    if (data1.docs.isNotEmpty) {
      allProducts = data1.docs
          .map((e) => NewProductModel.fromMap(e.data(), e.id))
          .toList();
      log("-----> ${allProducts.length} <-----");
      update();
    } else {
      log("------> not found <----");
    }

    updateloading(false);
  }

  Future<void> uploadNewCategory(String cat) async {
    CategoryModel category = CategoryModel(name: cat, uuid: Uuid().v4());
    await categoryRef.doc(category.uuid).set(category.toMap());
    allCategorys.add(category);
    update();

    //upload on firebase
  }

  Future<void> deleteCategory(String uuid) async {
    allCategorys.removeWhere((e) => e.uuid == uuid);
    await categoryRef.doc(uuid).delete();
    update();
    //delete from firebase
  }

  Future<void> uploadNewProduct(NewProductModel model,
      {bool isUpdate = false}) async {
    updateloading(true);
    if (isUpdate) {
      await productsRef.doc(model.uuid).update(model.toMap());
      int index = allProducts.indexWhere((e) => e.uuid == model.uuid);
      allProducts[index] = model;
    } else {
      await productsRef.doc(model.uuid).set(model.toMap());
      allProducts.add(model);
    }
    update();
    updateloading(false);
  }

  Future<void> deleteProduct(String uuid) async {}
  Future<void> editProduct(NewProductModel model) async {}
  Future<void> editDetails() async {
    updateloading(true);
    await adminRef.doc("999").update({
      "upi": upi.text,
      "number": number.text,
      "delivery": num.parse(deliveryCharges.text)
    });
    updateloading(false);
  }
}

class NewProductModel {
  final String title;
  final String description;
  final String uuid;

  final String? createAt;
  final num price;
  final num oldPrice;
  final num rating;
  final num totalrating;
  final String categoryID;
  final bool isImageRequired;
  final bool? isSale;
  final List<Variants> variant;
  final List<dynamic> images;

  NewProductModel(
      this.title,
      this.description,
      this.price,
      this.oldPrice,
      this.rating,
      this.createAt,
      this.uuid,
      this.totalrating,
      this.categoryID,
      this.isImageRequired,
      this.variant,
      this.images,
      {this.isSale});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      "uuid": uuid,
      "isSale": isSale ?? true,
      "createAt": createAt ?? DateTime.now().toIso8601String(),
      'totalrating': totalrating,
      'categoryID': categoryID,
      'isImageRequired': isImageRequired,
      'variant': variant.map((x) {
        return x.toMap();
      }).toList(growable: false),
      'images': images,
    };
  }

  NewProductModel.fromMap(Map<String, dynamic> json, this.uuid)
      : title = json["title"],
        categoryID = json["categoryID"],
        price = json["price"],
        oldPrice = json["oldPrice"],
        description = json["description"],
        rating = json["rating"],
        isSale = json["isSale"] ?? true,
        isImageRequired = json["isImageRequired"],
        totalrating = json["totalrating"],
        createAt = json["createAt"],
        variant = List<Variants>.from(
          ((json['variant'] ?? const <Variants>[]) as List).map<Variants>((x) {
            return Variants.fromMap(
                (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
          }),
        ),
        images = List<dynamic>.from(
          ((json['images'] ?? const <dynamic>[]) as List<dynamic>),
        );
}

class Variants {
  final String title;
  final num price;
  final num finalprice;

  const Variants(
    this.title,
    this.price,
    this.finalprice,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'finalprice': finalprice,
    };
  }

  factory Variants.fromMap(Map<String, dynamic> map) {
    return Variants(
      (map["title"] ?? '') as String,
      (map["price"] ?? 0) as num,
      (map["finalprice"] ?? 0) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Variants.fromJson(String source) =>
      Variants.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CategoryModel {
  final String uuid;
  final String name;
  const CategoryModel({
    required this.uuid,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      uuid: (map["uuid"] ?? '') as String,
      name: (map["name"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AdminModel {
  final String adminEmail;
  final String adminPass;
  final String number;
  final String upi;
  final num totalOrder;
  final num totalVisit;
  final num delivery;
  const AdminModel({
    required this.adminEmail,
    required this.adminPass,
    required this.number,
    required this.upi,
    required this.totalOrder,
    required this.totalVisit,
    required this.delivery,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'admin_email': adminEmail,
      'admin_pass': adminPass,
      'number': number,
      'upi': upi,
      'totalOrder': totalOrder,
      'totalVisit': totalVisit,
      "delivery": delivery,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      adminEmail: (map["admin_email"] ?? '') as String,
      adminPass: (map["admin_pass"] ?? '') as String,
      delivery: (map["delivery"] ?? 0) as num,
      number: (map["number"] ?? '') as String,
      upi: (map["upi"] ?? '') as String,
      totalOrder: (map["totalOrder"] ?? 0) as num,
      totalVisit: (map["totalVisit"] ?? 0) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
