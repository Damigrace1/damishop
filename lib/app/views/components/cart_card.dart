import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/domain/controllers/cart_controller.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:damishop/app/views/components/cached_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Container(
      height: 132,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.greyF8, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          CachedImageWidget(
            path: product.imagePath,
            width: 102.87,
          ),
          horizontalSpacer(10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                style: buildTextStyle(
                    color: AppColors.grey700,
                    size: 12,
                    weight: FontWeight.w400),
              ),
              Text(
                '\$${formatMoney(product.price.toString())}',
                style: buildTextStyle(
                    color: AppColors.grey700,
                    size: 17,
                    weight: FontWeight.w600),
              ),
              Text(
                AppString.inStock,
                style: buildTextStyle(color: AppColors.success, size: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      cartCtrl.decreaseQuantity(product);
                    },
                    child: SvgPicture.asset(AppIcons.decrease),
                  ),
                  Text(cartCtrl.getProductQuantity(product)),
                  InkWell(
                    onTap: () {
                      cartCtrl.increaseQuantity(product);
                    },
                    child: SvgPicture.asset(AppIcons.increase),
                  ),
                  InkWell(
                    onTap: () {
                      cartCtrl.removeFromCart(product);
                    },
                    child: SvgPicture.asset(AppIcons.delete),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
