import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/feautures/main/home/controller/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final ProductController productController = Get.find<ProductController>();

  // ✅ Dynamic Categories from API
  List<String> get categories {
    final allCategories =
        productController.productList.map((p) => p.category).toSet().toList();
    allCategories.sort(); // alphabetical order
    return allCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppLayout.screenPadding,
      child: Row(
        children: [
          // CATEGORY DROPDOWN
          Expanded(
            child: Obx(() {
              return DropdownButtonFormField<String>(
                value: productController.selectedCategory.value.isEmpty
                    ? null
                    : productController.selectedCategory.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hint: const Text("Select Category"),
                onChanged: (value) {
                  productController.setCategory(value ?? '');
                },
                items: categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  );
                }).toList(),
              );
            }),
          ),
          const SizedBox(width: 10),

          // SORT DROPDOWN
          Expanded(
            child: Obx(() {
              return DropdownButtonFormField<String>(
                value: productController.sortOrder.value.isEmpty
                    ? null
                    : productController.sortOrder.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hint: const Text("Sort"),
                onChanged: (value) {
                  productController.setSortOrder(value ?? '');
                },
                items: const [
                  DropdownMenuItem(
                    value: 'low_to_high',
                    child: Text("Low-High"),
                  ),
                  DropdownMenuItem(
                    value: 'high_to_low',
                    child: Text("High-Low"),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
