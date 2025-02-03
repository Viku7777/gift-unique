import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  TextEditingController categoryController = TextEditingController();
  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (categoryController.text.isEmpty) {
            Get.snackbar("Error", "Please enter a category name");
          } else {
            adminController.uploadNewCategory(categoryController.text);
            Get.back();
          }
        },
        child: Icon(Icons.cloud_upload_outlined),
      ),
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10).copyWith(top: 40),
        child: PrimaryTextFieldView(
          hintText: "Enter category name",
          label: "Category",
          controller: categoryController,
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
      ),
    );
  }
}
