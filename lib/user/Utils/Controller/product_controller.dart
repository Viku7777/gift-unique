import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/Utils/Model/product_model.dart';
import 'package:color_game/user/Utils/Model/review_model.dart';

class ProductController extends GetxController {
  // instance of product list
  bool isloading = false;
  List indexOfProducts = [];
  updateLoading(bool status) {
    isloading = status;
    update();
  }

  List<NewProductModel> allProducts = [];

  String upi = "";

  String contactNumber = "";
  List<CategoryModel> allCategorys = [];
  late AdminModel admindata;

  RxList<ProductModel> productList = RxList([]);

  // instance of review list
  RxList<ReviewModel> reviewList = RxList([]);

  Future loadProducts() async {
    // Load the JSON file from assets
    final String response =
        await rootBundle.loadString('assets/Config/product.json');

    // Decode the JSON string into a List of dynamic objects
    final List<dynamic> data = json.decode(response);

    // Map the List<dynamic> to List<Product> by using the fromJson factory
    List<ProductModel> products =
        data.map((item) => ProductModel.fromJson(item)).toList();

    productList(products);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    updateLoading(true);

    var data = await categoryRef.get();
    var data1 = await productsRef.get();
    var data2 = await adminRef.doc("999").get();
    var data3 = await productIndexRef.doc("999").get();
    admindata = AdminModel.fromMap(data2.data() as Map<String, dynamic>);
    contactNumber = admindata.number;
    upi = admindata.upi;
    if (data.docs.isNotEmpty) {
      allCategorys =
          data.docs.map((e) => CategoryModel.fromMap(e.data())).toList();
      update();
    }
    if (data1.docs.isNotEmpty) {
      allProducts = data1.docs
          .map((e) => NewProductModel.fromMap(e.data(), e.id))
          .toList();
      update();

      if (data3.exists) {
        indexOfProducts = data3.get("index");
      } else {}
    } else {
      log("------> not found <----");
    }

    updateLoading(false);
  }

// Function to load and parse JSON data
  Future loadReviews() async {
    // Load the JSON file from assets
    String jsonString =
        await rootBundle.loadString('assets/Config/review.json');

    // Parse the JSON string to a List
    List<dynamic> jsonList = json.decode(jsonString);

    // Map the JSON list to a list of ReviewModel objects
    List<ReviewModel> reviews =
        jsonList.map((json) => ReviewModel.fromJson(json)).toList();

    reviewList(reviews);
  }
}
