import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/export_widget.dart';

class HomeOrderViewAdmin extends StatefulWidget {
  const HomeOrderViewAdmin({super.key});

  @override
  State<HomeOrderViewAdmin> createState() => _HomeOrderViewAdminState();
}

class _HomeOrderViewAdminState extends State<HomeOrderViewAdmin> {
  List<NewProductModel> _list = [];
  var controller = Get.find<AdminController>();

  @override
  void initState() {
    _list = controller.allProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Home Product"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await productIndexRef
                .doc("999")
                .set({"index": _list.map((e) => e.uuid).toList()});
            Get.back();
            Get.snackbar("Success", "Index Saved");
          },
          child: Icon(Icons.save),
        ),
        body: ReorderableListView(
            padding: EdgeInsets.all(20),
            onReorder: (int start, int current) {
              if (start < current) {
                int end = current - 1;
                NewProductModel startItem = _list[start];
                int i = 0;
                int local = start;
                do {
                  _list[local] = _list[++local];
                  i++;
                } while (i < end - start);
                _list[end] = startItem;
              }
              // dragging from bottom to top
              else if (start > current) {
                NewProductModel startItem = _list[start];
                for (int i = start; i > current; i--) {
                  _list[i] = _list[i - 1];
                }
                _list[current] = startItem;
              }
              setState(() {});
            },
            children: _list
                .map((e) => Padding(
                      key: Key(e.uuid),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AdminNewProductCard(product: e),
                    ))
                .toList()));
  }
}
