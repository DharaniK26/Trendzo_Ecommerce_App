import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/controller/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ProductController productController = Get.find<ProductController>();

  // local search query
  final RxString searchQuery = ''.obs;

  // TextField controller to get the current input value
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text("Search Products"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: AppLayout.screenPadding,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "Search here",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.prime)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (searchController.text.trim().isEmpty) {
                            searchQuery.value = '';
                          } else {
                            searchQuery.value = searchController.text.trim();
                          }
                        },
                        icon: Icon(Icons.search))),
                // onChanged: (value) {
                //   searchQuery.value = value;
                // },
              ),
            ),
            AppLayout.spaceH10,
            Obx(() {
              if (searchQuery.value.isEmpty) {
                return const SizedBox.shrink();
              }

              final products = productController.productList.where((product) {
                return product.title
                    .toLowerCase()
                    .contains(searchQuery.value.toLowerCase());
              }).toList();

              if (products.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No matching products found"),
                  ),
                );
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
                        Get.toNamed(AppRoutes.productDetails,
                            arguments: product.id);
                      },
                      child: Card(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
            })
          ],
        ),
      ),
    );
  }
}
