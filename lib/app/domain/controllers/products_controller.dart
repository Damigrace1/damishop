import 'package:damishop/app/data/product_list.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductsController extends GetxController {
  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return sampleProducts;
  }
}
