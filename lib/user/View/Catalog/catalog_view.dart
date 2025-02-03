import 'package:color_game/user/View/Account/contact_view.dart';
import 'package:color_game/user/View/Shop/shop_screen_view.dart';
import 'package:color_game/export_widget.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            // styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Our Catalog",
                  style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_20,
                ),
                styleSheet.SPACING.addWidth(styleSheet.SPACING.small),
                Text(
                  "Hide Previews",
                  style: styleSheet.TEXT_CONDENSED.FS_REGULAR_16,
                ),
              ],
            ),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
            PrimaryTextFieldView(
              isSearch: true,
              hintText: "Fitler by Category",
            ),
            styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
            ListTile(
              onTap: () {
                Get.back();
              },
              contentPadding: EdgeInsets.zero,
              title: Text("Home", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
            ),
            const Divider(),
            ListTile(
              onTap: () => Get.to(ShopScreenView()),
              contentPadding: EdgeInsets.zero,
              title: Text("Shop", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
            ),
            const Divider(),
            ListTile(
              onTap: () => Get.to(const ContactView()),
              contentPadding: EdgeInsets.zero,
              title:
                  Text("Contact", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
            ),
          ],
        ).paddingAll(styleSheet.SPACING.large),
      ],
    );
  }
}
