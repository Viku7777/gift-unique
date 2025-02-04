import 'dart:developer';

import 'package:color_game/admin/controller/admin_controller.dart';
import 'package:color_game/admin/dashboard.dart';
import 'package:color_game/export_widget.dart';
import 'package:color_game/firebase_options.dart';
import 'package:color_game/user/Utils/Controller/cart_controller.dart';
import 'package:color_game/user/Utils/Controller/order_controller.dart';
import 'package:color_game/user/Utils/Controller/wishlist_controller.dart';
import 'package:color_game/user/Utils/stylesheet/style_manager.dart';
import 'package:color_game/user/View/Bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:color_game/user/View/Dashboard/new_product_details_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'dart:html' as html;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart' as pathremove;

late StyleManager styleSheet;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  styleSheet = StyleManager();
  String currentUrl = html.window.location.href;
  log("path is ==> $currentUrl");
  pathremove.setUrlStrategy(pathremove.PathUrlStrategy());
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
        // initialRoute: "/",
        theme: ThemeData(
          fontFamily: GoogleFonts.rubik().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _generateRoute,

        // routes: routes,
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

// Map<String, Widget Function(BuildContext)> routes = {
//   '/': (context) => const SplashScreenView(),
//   '/admin': (context) => const AdminDashboard(),
// };

Route<dynamic> _generateRoute(RouteSettings settings) {
  log(settings.name ?? "");
  if (settings.name!.startsWith("/product")) {
    return MaterialPageRoute(
        //  ComeThroughLinkView(uuid: settings.name!.split("/")[2]));
        builder: (_) => GetBuilder<ProductController>(
              builder: (controller) {
                return controller.isloading
                    ? Scaffold(
                        appBar: AppBar(),
                        body: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Color.fromARGB(255, 82, 187, 86),
                          ),
                        ))
                    : NewProductDetailsView(
                        clearstack: true,
                        productModel: controller.allProducts.firstWhere(
                            (e) => e.uuid == settings.name!.split("/")[2]));
              },
            ));
  } else {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BottomNavBarView());
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminDashboard());

      default:
        return MaterialPageRoute(builder: (_) => BottomNavBarView());
    }
  }
}

getInitState() {
  Get.find<ProductController>().loadProducts();
  Get.find<ProductController>().loadReviews();

  Future.delayed(const Duration(seconds: 1), () {
    Get.offAll(() => BottomNavBarView());
  });
}
