import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/config/app_widget.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/cart/controller/cartcontroller.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_button.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Obx(() => Text(
              "My Cart ${cartController.cartItems.length} Item(s)",
              style: AppStyle.titleTextStyle,
            )),
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return noItemDataWidget(msg: "Cart is empty!");
              }

              return ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.2,
                              width: width * 0.30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                  height: height * 0.2,
                                  width: width * 0.35,
                                ),
                              ),
                            ),
                            AppLayout.spaceW10,
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                    Text("by Reciprocal",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    AppLayout.spaceH10,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "₹${(item.price * item.count).toStringAsFixed(2)}",
                                                  style:
                                                      AppStyle.bodyTextStyle),
                                              AppLayout.spaceW10,
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons
                                                              .remove_circle_outline,
                                                          color: Colors.grey),
                                                      onPressed: () =>
                                                          cartController
                                                              .decreaseQuantity(
                                                                  item),
                                                    ),
                                                    Text("${item.count}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14)),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons
                                                              .add_circle_outline,
                                                          color: Colors.grey),
                                                      onPressed: () =>
                                                          cartController
                                                              .increaseQuantity(
                                                                  item),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cartController.removeFromCart(item);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            if (cartController.cartItems.isEmpty) return SizedBox.shrink();
            double subtotal = cartController.totalAmount();
            double shipping = 0;
            double total = subtotal + shipping;

            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal"),
                      Text("₹${subtotal.toStringAsFixed(2)}"),
                    ],
                  ),
                  AppLayout.spaceH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping"),
                      Text(
                        "FREE",
                        style: AppStyle.bodyTextStyle
                            .copyWith(color: AppColors.success),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total"),
                      Text("₹${total.toStringAsFixed(2)}"),
                    ],
                  ),
                  AppLayout.spaceH10,
                  CustomButton(
                    onPressed: () {
                      showCustomSnackbar(
                          text: "order Placed", status: StatusTypes.success);
                    },
                    text: "Place Oder",
                    height: height * 0.06,
                    width: width,
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
