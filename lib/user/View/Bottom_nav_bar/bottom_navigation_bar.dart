// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/user/View/Shop/shop_screen_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import '../../../export_widget.dart';

class BottomNavBarView extends StatefulWidget {
  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _selectedIndex = 0; // Keeps track of the currently selected index

  // List of screens to display
  final List<Widget> _screens = [
    DashboardView(),
    ShopScreenView(
      showAppbar: false,
    ),
    // SignInAccountView(),
    WishlistView(),
    CartView(),
  ];

  // Function to update selected screen
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    updateVisit();
    super.initState();
  }

  updateVisit() async {
    await adminRef.doc("999").update({
      "totalVisit": FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: styleSheet.COLORS.WHITE,
      appBar: customAppbar(),
      drawer: const Drawer(
        child: MainDrawerView(),
      ),
      body: _screens[_selectedIndex], // Display selected screen
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: styleSheet.TEXT_Rubik.FS_REGULAR_12
            .copyWith(color: styleSheet.COLORS.ACTIVE_BLUE),
        unselectedLabelStyle: styleSheet.TEXT_Rubik.FS_REGULAR_12,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme:
            IconThemeData(color: styleSheet.COLORS.BLACK_COLOR),
        selectedIconTheme: IconThemeData(color: styleSheet.COLORS.BLACK_COLOR),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            // icon: Icon(CupertinoIcons.home),
            icon: SvgPicture.asset(
              styleSheet.ICONS.HOME_SVG,
              color: styleSheet.COLORS.BLACK_COLOR,
              height: 20,
              width: 20,
            ).paddingOnly(bottom: styleSheet.SPACING.minsmall),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.dashboard,
              size: 22,
            ).paddingOnly(bottom: styleSheet.SPACING.minsmall),
            label: 'Shop',
          ),
          // BottomNavigationBarItem(
          //   // icon: Icon(Icons.person),
          //   icon: SvgPicture.asset(
          //     styleSheet.ICONS.ACCOUNT_SVG,
          //     color: styleSheet.COLORS.BLACK_COLOR,
          //     height: 20,
          //     width: 20,
          //   ).paddingOnly(bottom: styleSheet.SPACING.minsmall),
          //   label: 'Account',
          // ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.favorite_border),
            icon: SvgPicture.asset(
              styleSheet.ICONS.WISHLIST_SVG,
              color: styleSheet.COLORS.BLACK_COLOR,
              height: 20,
              width: 20,
            ).paddingOnly(bottom: styleSheet.SPACING.minsmall),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_cart_outlined),
            icon: SvgPicture.asset(
              styleSheet.ICONS.CART_SVG,
              color: styleSheet.COLORS.BLACK_COLOR,
              height: 20,
              width: 20,
            ).paddingOnly(bottom: styleSheet.SPACING.minsmall),
            label: 'Cart',
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            html.window.open(
                "https://api.whatsapp.com/send?phone=91${Get.find<ProductController>().admindata.number}&text=Hello%20Sir%2FMaam%20%F0%9F%91%8B%2C%0AI%20need%20help",
                '_blank');
          },
          child: SvgPicture.asset(
            styleSheet.ICONS.WHATSAPP_SVG,
          )),
    );
  }
}
