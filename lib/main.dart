import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/admin/dashboard.dart';
import 'package:color_game/firebase_options.dart';
import 'package:color_game/splash_screen.dart';
import 'package:color_game/user/Utils/Controller/cart_controller.dart';
import 'package:color_game/user/Utils/Controller/design_controller.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/Utils/Controller/product_controller.dart';
import 'package:color_game/user/Utils/Controller/wishlist_controller.dart';
import 'package:color_game/user/Utils/stylesheet/style_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

late StyleManager styleSheet;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  styleSheet = StyleManager();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      maximumSize: const Size(475.0, 812.0), // Maximum size
      builder: (context) => GetMaterialApp(
        initialBinding: InitialBindings(),
        title: 'Loves Gifts',
        initialRoute: "/",
        theme: ThemeData(
          fontFamily: GoogleFonts.rubik().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        routes: routes,
        // home: SignInAccountView
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(DesignController());
    Get.put(CartController());
    Get.put(OrderController());
    Get.put(WishlistController());
    Get.put(AdminController());
  }
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreenView(),
  '/admin': (context) => const AdminDashboard(),
};
