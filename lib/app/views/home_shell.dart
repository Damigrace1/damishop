import 'package:damishop/app/domain/controllers/nav_controller.dart';
import 'package:damishop/app/views/components/custom_navbar.dart';
import 'package:damishop/app/views/home/home_page.dart';
import 'package:damishop/app/views/products/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeShell extends StatelessWidget {
  HomeShell({super.key});
  final NavController navController = Get.find<NavController>();

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const SizedBox(),
    const SizedBox(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: navController.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            currentIndex: navController.currentIndex.value,
            onTap: navController.changeTab,
          )),
    );
  }
}
