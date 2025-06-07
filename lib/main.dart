import 'package:damishop/app/core/bindings.dart';
import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/domain/controllers/auth_controller.dart';
import 'package:damishop/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(iconTheme: IconThemeData()),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: GoogleFonts.ibmPlexSansTextTheme(),
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
      initialBinding: AppBindings(),
    );
  }
}
