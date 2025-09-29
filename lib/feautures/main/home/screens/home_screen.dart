import 'package:ecommerce_app_using_flutter/config/app_assets.dart';
import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/controller/product_list_controller.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/home_widgets/filterwidget.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/home_widgets/home_searchcontainerwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.cartScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final List<String> imageList = [
      AppAssets.banner1,
      AppAssets.banner2,
      AppAssets.banner3,
      AppAssets.banner4,
    ];
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     "Trendzo",
      //     style: AppStyle.titleTextStyle.copyWith(color: AppColors.white),
      //   ),
      //   backgroundColor: AppColors.prime,
      // ),
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeSearchBarWidget(height: height, width: width),
            Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.pink, AppColors.prime1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                height: height * 0.08,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.prime1,
                      AppColors.white,
                      AppColors.prime1
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.autorenew, color: Colors.black),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("7 Days", style: AppStyle.bodyTextStyle),
                            Text("Replacement", style: AppStyle.bodyTextStyle),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.black),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Cash", style: AppStyle.bodyTextStyle),
                            Text("on Delivery", style: AppStyle.bodyTextStyle),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AppLayout.spaceH10,
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CarouselView(
                itemExtent: MediaQuery.of(context).size.width,
                children: imageList.map((imagePath) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ),
            AppLayout.spaceH10,
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Top Products for you",
                  style: AppStyle.bodyTextStyle,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            FilterWidget(),
            Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final products = productController.filteredProducts;
              if (products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.60,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.productDetails,
                            arguments: product.id);
                      },
                      child: Card(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: height * 0.25,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.bodyTextStyle
                                        .copyWith(fontSize: 12),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "₹${product.price.toString()}",
                                            style: AppStyle.bodyTextStyle
                                                .copyWith(fontSize: 14),
                                          )),
                                      AppLayout.spaceW4,
                                      Text(
                                        "₹200",
                                        style: AppStyle.bodyTextStyle.copyWith(
                                            color: AppColors.hintText,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      AppLayout.spaceW10,
                                      Text(
                                        "20% Off",
                                        style: AppStyle.bodyTextStyle
                                            .copyWith(color: AppColors.success),
                                      ),
                                    ],
                                  ),
                                  Text(product.rating.rate.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.prime,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.category),
          //   label: "Categories",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
