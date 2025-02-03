import 'package:flutter/material.dart';
import 'package:color_game/admin/add_category_view.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddCategoryView());
          },
          child: Icon(Icons.add),
        ),
        body: GetBuilder<AdminController>(
          builder: (controller) {
            return controller.allCategorys.isEmpty
                ? Center(
                    child: Text("No Category Found !!!"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.allCategorys.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(controller.allCategorys[index].name),
                        trailing: IconButton(
                            onPressed: () {
                              controller.deleteCategory(
                                  controller.allCategorys[index].uuid);
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  );
          },
        ));
  }
}
