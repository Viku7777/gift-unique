import 'package:color_game/backend/auth/controller.dart';
import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/backend/game/controller/investment_bottom_seat_controller.dart';
import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:color_game/backend/notification/notification_services.dart';
import 'package:color_game/firebase_options.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/screen/home/screen/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  await NotificationServices.init();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(AppConfig.screenWidth, AppConfig.screenHeight),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthController(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserController(),
          ),
          ChangeNotifierProvider(
            create: (context) => GameController(),
          ),
          ChangeNotifierProvider(
            create: (context) => BottomSeatController(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vip Win',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}
