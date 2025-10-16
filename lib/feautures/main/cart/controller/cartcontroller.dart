import 'package:ecommerce_app_using_flutter/feautures/main/home/modal/product_list_modal.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // Observable list to store cart items
  var cartItems = <ProductListModal>[].obs;

  // Add to cart
  void addToCart(ProductListModal product) {
    if (!cartItems.contains(product)) {
      cartItems.add(product);
    }
  }

  // Remove from cart
  void removeFromCart(ProductListModal product) {
    cartItems.remove(product);
  }

  // Increase quantity
  void increaseQuantity(ProductListModal product) {
    product.count++;
    cartItems.refresh();
  }

  // Decrease quantity
  void decreaseQuantity(ProductListModal product) {
    if (product.count >= 1) {
      product.count--;
      cartItems.refresh(); 
    } else {
      removeFromCart(product);
    }
  }

  // Total amount
  double totalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.count;
    }
    return total;
  }
}
