import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class AddProductsView extends StatefulWidget {
  final NewProductModel? product;
  const AddProductsView({super.key, this.product});

  @override
  State<AddProductsView> createState() => _AddProductsViewState();
}

class _AddProductsViewState extends State<AddProductsView> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController countRatingController = TextEditingController();
  List<dynamic> updateImageFile = [];
  List<Variants> allvariants = [];
  String? category;
  TextEditingController varianttitle = TextEditingController();
  TextEditingController vfinalPrice = TextEditingController();
  TextEditingController vprice = TextEditingController();
  TextEditingController imageurl = TextEditingController();
  bool isImageRequired = false;

  var adminController = Get.find<AdminController>();

  @override
  void initState() {
    if (widget.product != null) {
      NewProductModel product = widget.product!;
      titlecontroller.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      oldPriceController.text = product.oldPrice.toString();
      ratingController.text = product.rating.toString();
      countRatingController.text = product.totalrating.toString();
      isImageRequired = product.isImageRequired;
      updateImageFile = product.images;
      titlecontroller.text = product.title;
      category = adminController.allCategorys
          .firstWhere((e) => e.uuid == product.categoryID,
              orElse: () => CategoryModel(uuid: "", name: ""))
          .name;
      if (product.variant.isNotEmpty) {
        allvariants = product.variant;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: widget.product != null
            ? [
                IconButton(
                    onPressed: () {
                      adminController.deleteProduct(widget.product!.uuid);
                    },
                    icon: Icon(Icons.delete))
              ]
            : null,
      ),
      body: GetBuilder<AdminController>(
        builder: (controller) => controller.allCategorys.isEmpty
            ? Center(
                child: Text("Please first create any category !!!"),
              )
            : Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(10).copyWith(top: 20),
                    children: [
                      PrimaryTextFieldView(
                        hintText: "Enter product title",
                        label: "Title",
                        controller: titlecontroller,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextFieldView(
                        hintText: "Enter product description",
                        label: "Description",
                        controller: descriptionController,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextFieldView(
                        hintText: "Enter product price",
                        label: "Price",
                        keyboardType: TextInputType.number,
                        controller: priceController,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextFieldView(
                        hintText: "Enter old price",
                        label: "Old Price",
                        controller: oldPriceController,
                        keyboardType: TextInputType.number,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextFieldView(
                        hintText: "Enter product rating",
                        label: "Rating",
                        controller: ratingController,
                        keyboardType: TextInputType.number,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextFieldView(
                        hintText: "Rating count person",
                        label: "Count Of Person",
                        keyboardType: TextInputType.number,
                        controller: countRatingController,
                      ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: DropdownButtonFormField(
                            hint: Text("Select Category"),
                            value: category,
                            items: controller.allCategorys
                                .map((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(e.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              category = value;
                              setState(() {});
                            },
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: SwitchListTile(
                            value: isImageRequired,
                            onChanged: (v) {
                              isImageRequired = v;
                              setState(() {});
                            },
                            title: Text("Image Req"),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Variant"),
                            IconButton(
                                onPressed: () {
                                  addVariants();
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: allvariants.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(allvariants[index].title),
                              subtitle: Text(
                                  "Total Price : ${allvariants[index].price}/- Current Price : ${allvariants[index].finalprice}/-"),
                              trailing: IconButton(
                                  onPressed: () {
                                    allvariants.removeWhere((e) =>
                                        e.title == allvariants[index].title);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Upload Images"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 50),
                          itemCount: updateImageFile.length + 1,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                image: updateImageFile.isNotEmpty &&
                                        updateImageFile.length != index
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            updateImageFile[index]),
                                        fit: BoxFit.cover)
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black)),
                            child: IconButton(
                                onPressed: () {
                                  if (updateImageFile.length == index) {
                                    addImageUrl();
                                  } else {
                                    updateImageFile.removeWhere(
                                        (e) => e == updateImageFile[index]);
                                    setState(() {});
                                  }
                                },
                                icon: Icon(updateImageFile.length == index
                                    ? Icons.add
                                    : Icons.delete)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: () {
                              if (titlecontroller.text.isEmpty ||
                                  descriptionController.text.isEmpty ||
                                  priceController.text.isEmpty ||
                                  oldPriceController.text.isEmpty ||
                                  ratingController.text.isEmpty ||
                                  countRatingController.text.isEmpty ||
                                  category == null ||
                                  updateImageFile.isEmpty) {
                                Get.snackbar("Error",
                                    "Please enter all the details which is required");
                              } else {
                                uploadProducts(widget.product == null
                                    ? Uuid().v4()
                                    : widget.product!.uuid);
                              }
                            },
                            child: Text("Add Product")),
                      )
                    ],
                  ),
                  controller.loading
                      ? Container(
                          color: Colors.black38,
                          alignment: Alignment.center,
                          child: LoadingAnimationWidget.inkDrop(
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }

  addVariants() {
    varianttitle.clear();
    vfinalPrice.clear();
    vprice.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Variant"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextFieldView(
                hintText: "Variant Name",
                label: "Enter Variant",
                controller: varianttitle,
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryTextFieldView(
                hintText: "Variant Final Price",
                label: "Cost Of Sell",
                keyboardType: TextInputType.number,
                controller: vfinalPrice,
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryTextFieldView(
                hintText: "Variant Price",
                label: "Variant Old Price",
                keyboardType: TextInputType.number,
                controller: vprice,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () {
                  if (varianttitle.text.isEmpty ||
                      vfinalPrice.text.isEmpty ||
                      vprice.text.isEmpty) {
                    Get.snackbar("Error", "Please enter all values");
                  } else {
                    allvariants.add(Variants(varianttitle.text,
                        num.parse(vprice.text), num.parse(vfinalPrice.text)));
                    Get.back();
                    setState(() {});
                  }
                },
                child: Text("Add"))
          ],
        );
      },
    );
  }

  addImageUrl() {
    imageurl.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Image Url"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextFieldView(
                hintText: "Image Url",
                label: "url",
                controller: imageurl,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () {
                  if (imageurl.text.isNotEmpty) {
                    updateImageFile.add(imageurl.text);
                    Get.back();
                    setState(() {});
                  }
                },
                child: Text("Upload"))
          ],
        );
      },
    );
  }

  uploadProducts(String uuid) async {
    NewProductModel product = NewProductModel(
        titlecontroller.text,
        descriptionController.text,
        num.parse(priceController.text),
        num.parse(oldPriceController.text),
        num.parse(ratingController.text),
        DateTime.now().toIso8601String(),
        uuid,
        num.parse(countRatingController.text),
        adminController.allCategorys
            .firstWhere((e) => e.name == category!)
            .uuid,
        isImageRequired,
        allvariants,
        updateImageFile);
    adminController
        .uploadNewProduct(product, isUpdate: widget.product != null)
        .then((e) => Get.back());
  }
}
