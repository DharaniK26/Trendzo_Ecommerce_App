import 'package:ecommerce_app_using_flutter/feautures/core/auth/login_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/core/auth/register_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/cart/cart_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/home_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/product_details_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/search_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String register = '/';
  static const String login = '/login_screen';
  static const String homeScreen = '/home_screen';
  static const String productDetails = '/product_details_screen';
  static const String cartScreen = '/cart_screen';
  static const String searchScreen = '/search_screen';
  static const String wishListScreen = '/wishlist_screen';
}

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsScreen(id: Get.arguments as int),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: AppRoutes.searchScreen,
      page: () => const SearchScreen(),
    ),
    GetPage(name: AppRoutes.wishListScreen, page: () => const WishListScreen()),
  ];
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("no page found"),
          ],
        ),
      ),
    );
  }
}
