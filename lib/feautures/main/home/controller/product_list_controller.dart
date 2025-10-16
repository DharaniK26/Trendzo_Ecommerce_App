import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../modal/product_list_modal.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductListModal>[].obs;
  var selectedCategory = ''.obs;
  var sortOrder = ''.obs;

  final Dio _dio = Dio(); 

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

void fetchProducts() async {
    try {
      isLoading(true);
      final response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        productList.value =
            jsonData.map((e) => ProductListModal.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to load products");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }
  
  List<ProductListModal> get filteredProducts {
    List<ProductListModal> products = [...productList];

    // Category Filter
    if (selectedCategory.value.isNotEmpty) {
      products = products
          .where((p) =>
              p.category.toLowerCase() ==
              selectedCategory.value.toLowerCase())
          .toList();
    }

    // Sort by Price
    if (sortOrder.value == "low_to_high") {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOrder.value == "high_to_low") {
      products.sort((a, b) => b.price.compareTo(a.price));
    }

    return products;
  }

  // Setters
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setSortOrder(String order) {
    sortOrder.value = order;
  }
}