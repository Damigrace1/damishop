import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:damishop/app/core/images.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/domain/controllers/auth_controller.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.body,
      this.appBar,
      this.scaffoldColor,
      this.appBarColor});

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? scaffoldColor;
  final Color? appBarColor;
  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: appBarColor ?? AppColors.white,
      appBar: appBar ??
          AppBar(
            leading: Container(
              color: AppColors.white,
              child: Image.asset(
                AppImages.logo,
                width: 40,
              ),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: appBarColor ?? AppColors.white,
            actions: [
              SvgPicture.asset(AppIcons.notification),
              const SizedBox(
                width: 32,
              )
            ],
            title: Column(
              children: [
                Text(
                  AppString.deliveryAddress,
                  style: buildTextStyle(
                      weight: FontWeight.w600, size: 10, height: 28 / 10),
                ),
                Text(
                  authCtrl.deliveryAddress,
                  style: buildTextStyle(
                      weight: FontWeight.w600, size: 12, height: 28 / 12),
                )
              ],
            ),
            centerTitle: true,
          ),
      body: Column(
        children: [
          if (appBar == null)
            const SizedBox(
              height: 8,
            ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
