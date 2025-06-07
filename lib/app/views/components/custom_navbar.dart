import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/domain/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: AppIcons.home, label: AppString.home),
      _NavItem(
          icon: AppIcons.cart,
          label: AppString.cart,
          stackedWidget: GetBuilder<CartController>(
              id: 'cart',
              builder: (ctrl) {
                return ctrl.cartItems.isEmpty
                    ? const SizedBox()
                    : Positioned(
                        top: 0,
                        right: 4,
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: AppColors.grey56, shape: BoxShape.circle),
                          child: Text(
                            ctrl.cartItems.length.toString().length > 2
                                ? '${ctrl.cartItems.length.toString().substring(0, 2)}+'
                                : ctrl.cartItems.length.toString(),
                            maxLines: 1,
                            style: buildTextStyle(
                                size: 10.22,
                                color: AppColors.white,
                                weight: FontWeight.w700),
                          ),
                        ),
                      );
              })),
      _NavItem(icon: AppIcons.favourites, label: AppString.favourite),
      _NavItem(icon: AppIcons.profile, label: AppString.profile),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final selected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Stack(
              children: [
                const SizedBox(
                  width: 60,
                  height: 36,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 56,
                        height: 32,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : AppColors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          items[index].icon,
                          color: selected ? AppColors.white : AppColors.black,
                          width: 24,
                          colorBlendMode: BlendMode.srcATop,
                          height: 24,
                        )),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: selected ? AppColors.primary : AppColors.dark4F,
                      ),
                    ),
                  ],
                ),
                if (items[index].stackedWidget != null)
                  items[index].stackedWidget!
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String label;
  final Widget? stackedWidget;

  _NavItem({required this.icon, this.stackedWidget, required this.label});
}
