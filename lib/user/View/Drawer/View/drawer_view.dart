import 'package:color_game/user/View/Account/contact_view.dart';
import 'package:color_game/user/View/Order/track_order.dart';
import 'package:color_game/user/View/Shop/shop_screen_view.dart';
import 'package:color_game/export_widget.dart';

class MainDrawerView extends StatelessWidget {
  const MainDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
          Text("Menu", style: styleSheet.TEXT_Rubik.FS_MEDIUM_22),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.medium),
          ListTile(
            onTap: () => Get.to(ShopScreenView()),
            contentPadding: EdgeInsets.zero,
            title: Text("Shop", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
          ),
          const Divider(),
          ListTile(
            onTap: () => Get.to(TrackOrderView()),
            contentPadding: EdgeInsets.zero,
            title:
                Text("Track Order", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
          ),
          const Divider(),
          ListTile(
            onTap: () => Get.to(const ContactView()),
            contentPadding: EdgeInsets.zero,
            title: Text("Contact", style: styleSheet.TEXT_Rubik.FS_REGULAR_16),
          ),
        ],
      ).paddingOnly(left: styleSheet.SPACING.large),
    );
  }
}
