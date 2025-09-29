import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/cart/controller/cartcontroller.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/controller/product_list_controller.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_button.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final product = productController.productList.firstWhere(
      (p) => p.id == widget.id,
    );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        padding: AppLayout.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.40,
              width: MediaQuery.sizeOf(context).width,
              child: Card(
                margin: EdgeInsets.zero,
                color: AppColors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: AppLayout.screenPadding,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            AppLayout.spaceH10,

            // Product Name
            Text(
              product.title,
              maxLines: 1,
              style: AppStyle.commonText18.copyWith(fontSize: 16),
            ),
            AppLayout.spaceH10,
            Row(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₹${product.price.toString()}",
                      style: AppStyle.bodyTextStyle.copyWith(fontSize: 14),
                    )),
                AppLayout.spaceW4,
                Text(
                  "₹200",
                  style: AppStyle.bodyTextStyle.copyWith(
                      color: AppColors.hintText,
                      decoration: TextDecoration.lineThrough),
                ),
                AppLayout.spaceW10,
                Text(
                  "20% Off",
                  style:
                      AppStyle.bodyTextStyle.copyWith(color: AppColors.success),
                ),
                AppLayout.spaceW40,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: AppColors.prime,
                    ),
                    AppLayout.spaceW40,
                    Text(
                      "Wishlist",
                      style: AppStyle.bodyTextStyle,
                    )
                  ],
                ),
                AppLayout.spaceW30,
                Column(
                  children: [
                    Icon(
                      Icons.share,
                      color: AppColors.prime,
                    ),
                    AppLayout.spaceW30,
                    Text(
                      "Share",
                      style: AppStyle.bodyTextStyle,
                    )
                  ],
                )
              ],
            ),

            AppLayout.spaceH10,
            Card(
              margin: EdgeInsets.zero,
              color: AppColors.white,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: AppLayout.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select size",
                      style: AppStyle.titleTextStyle,
                    ),
                    Divider(),
                    // AppLayout.spaceH5,
                    Text(
                      'size and prize of the product item may vary subject to the stock available',
                      style: AppStyle.bodyTextStyle,
                    ),
                    AppLayout.spaceH20,
                    Text(
                      'Size',
                      style: AppStyle.commonText14,
                    ),
                    AppLayout.spaceH5,
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              side: WidgetStateProperty.all(
                                  BorderSide(color: AppColors.prime)),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              elevation: WidgetStateProperty.all(0),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 12)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'S',
                              style: AppStyle.commonText12,
                            ),
                          ),
                        ),
                        AppLayout.spaceW5,
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              side: WidgetStateProperty.all(
                                  BorderSide(color: AppColors.prime)),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              elevation: WidgetStateProperty.all(0),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 12)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'M',
                              style: AppStyle.commonText12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AppLayout.spaceH10,

            Card(
              margin: EdgeInsets.zero,
              color: AppColors.white,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: AppLayout.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description of the product',
                      style: AppStyle.titleTextStyle,
                    ),
                    Divider(),
                    Text(product.description, style: AppStyle.bodyTextStyle),
                  ],
                ),
              ),
            ),
            AppLayout.spaceH20,
            Row(
              children: [
                Flexible(
                  child: CustomButton.icon(
                      bgColor: AppColors.secondary,
                      width: width * 0.45,
                      height: height * 0.06,
                      text: "Add to cart",
                      onPressed: () {
                        cartController.addToCart(product);
                        showCustomSnackbar(context,
                            text:
                                "The Product is Added in to the cart SuccessFully",
                            status: StatusTypes.success);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: AppColors.white,
                      )),
                ),
                AppLayout.spaceW10,
                Flexible(
                  child: CustomButton.icon(
                      width: width * 0.45,
                      height: height * 0.06,
                      text: "Buy Now",
                      onPressed: () {
                        showCustomSnackbar(context,
                            text: "Happy Shopping",
                            status: StatusTypes.success);
                      },
                      icon: Icon(
                        Icons.arrow_right_sharp,
                        size: 30,
                        color: AppColors.white,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
