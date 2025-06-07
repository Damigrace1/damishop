import 'package:damishop/app/domain/controllers/auth_controller.dart';
import 'package:damishop/app/domain/controllers/cart_controller.dart';
import 'package:damishop/app/domain/controllers/nav_controller.dart';
import 'package:damishop/app/domain/controllers/products_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController, permanent: true);
    Get.put(NavController(), permanent: true);
    Get.put(ProductsController(), permanent: true);
    Get.lazyPut(() => CartController());
  }
}
