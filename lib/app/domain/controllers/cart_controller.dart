import 'package:damishop/app/core/services/alerts.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //Map of product and quantity
  RxMap<ProductModel, int> cartItems = <ProductModel, int>{}.obs;

  RxBool isBusy = false.obs;

  bool inCart(ProductModel product) {
    return cartItems.containsKey(product);
  }

  Future<void> addToCart(BuildContext context, ProductModel product) async {
    //Simulating adding to cart synchrous process.
    isBusy.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isBusy.value = false;
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    update(['cart']);
    if (context.mounted) {
      AlertService.showSuccess(context, 'Item added to cart');
    }
  }

  void removeFromCart(ProductModel product) async {
    //Simulating removing from cart synchrous process.

    cartItems.remove(product);
    update(['cart']);
  }

  void increaseQuantity(ProductModel product) {
    cartItems[product] = cartItems[product]! + 1;
    update(['cart']);
  }

  void decreaseQuantity(ProductModel product) {
    if (cartItems[product] == 1) {
      cartItems.remove(product);
    } else {
      cartItems[product] = cartItems[product]! - 1;
    }
    update(['cart']);
  }

  String getProductQuantity(ProductModel p) => cartItems[p].toString();

  double get subtotal =>
      cartItems.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  double get shipping => cartItems.isEmpty ? 0 : 10;

  double get total => subtotal + shipping;

  int get totalItems => cartItems.entries.fold(0, (sum, e) => sum + e.value);
}
