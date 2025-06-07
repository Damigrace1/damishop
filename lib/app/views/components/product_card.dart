import 'package:damishop/app/core/services/navigator.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/views/products/product_details.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.to(ProductDetails(product: product));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.62),
              child: Image.asset(product.imagePath)),
          const SizedBox(
            height: 7,
          ),
          Text(product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: buildTextStyle(
                size: 14,
                weight: FontWeight.w400,
              )),
          const SizedBox(
            height: 7,
          ),
          Text('\$${formatMoney(product.price.toString())}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: buildTextStyle(
                size: 16,
                weight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}
