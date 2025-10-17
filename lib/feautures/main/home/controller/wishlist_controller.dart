import 'package:ecommerce_app_using_flutter/feautures/main/home/modal/product_list_modal.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  var wishlistItems = <ProductListModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    // _loadWishlist();
    // ever<List<ProductListModal>>(wishlistItems, (_) => _saveWishlist());
  }

  void addToWishList(ProductListModal product) {
    final exists = wishlistItems.any((p) => p.id == product.id);
    if (!exists) wishlistItems.add(product);
  }

  void removeFromWishList(ProductListModal product) {
    wishlistItems.remove(product);
  }

  // void _loadWishlist() {
  //   final jsonStrings = AppSharedpref.getStringList(AppSharedkeys.wishlist);
  //   final products = jsonStrings
  //       .map((s) => ProductListModal.fromJson(json.decode(s)))
  //       .toList();
  //   wishlistItems.assignAll(products);
  // }

  // void _saveWishlist() {
  //   final jsonStrings =
  //       wishlistItems.map((p) => json.encode(p.toJson())).toList();
  //   AppSharedpref.setStringList(AppSharedkeys.wishlist, jsonStrings);
  // }
}
