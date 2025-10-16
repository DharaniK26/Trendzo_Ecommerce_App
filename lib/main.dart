import 'package:ecommerce_app_using_flutter/config/app_constants.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_sharedpref.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/cart/controller/cartcontroller.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/controller/wishlist_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppSharedpref.initialize();
  bool ifLoggedIn = AppSharedpref.getBool(AppSharedkeys.userId);
  Get.put(CartController());
  Get.put(WishlistController());
  runApp(MyApp(ifLoggedIn: ifLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool ifLoggedIn;
  const MyApp({super.key, required this.ifLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: ifLoggedIn ? AppRoutes.homeScreen : AppRoutes.login,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const ErrorRoute(),
      ),
    );
  }
}
