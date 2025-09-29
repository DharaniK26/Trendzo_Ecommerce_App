import 'package:ecommerce_app_using_flutter/feautures/core/auth/login_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/core/auth/register_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/cart/cart_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/home_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/product_details_screen.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/screens/search_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String register = '/';
  static const String login = 'login_screen';
  static const String homeScreen = '/home_screen';
  static const String productDetails = '/product_details_screen';
  static const String cartScreen = '/cart_screen';
  static const String searchScreen = '/search_screen';
}

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments;
  switch (routeSettings.name) {
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case AppRoutes.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case AppRoutes.productDetails:
      final id = args as int;
      return MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(id: id),
      );
    case AppRoutes.cartScreen:
      return MaterialPageRoute(builder: (_) => const CartScreen());
    case AppRoutes.searchScreen:
      return MaterialPageRoute(builder: (_) => const SearchScreen());

    default:
      return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }
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
