import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/domain/controllers/products_controller.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/views/components/action_tile.dart';
import 'package:damishop/app/views/components/custom_future_builder.dart';
import 'package:damishop/app/views/components/custom_scaffold.dart';
import 'package:damishop/app/views/components/product_card.dart';
import 'package:damishop/app/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> allProducts = [];
    ValueNotifier<List<ProductModel>> filteredProducts = ValueNotifier([]);

    return CustomScaffold(
        body: CustomFutureBuilder(
            future: Get.find<ProductsController>().fetchProducts,
            successBody: (products) {
              allProducts = filteredProducts.value = products;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextfield(
                        horizontalPadding: 11.96,
                        onChanged: (v) {
                          if (v.isEmpty) {
                            filteredProducts.value = allProducts;
                          } else {
                            filteredProducts.value = allProducts
                                .where((p) => p.name
                                    .toLowerCase()
                                    .contains(v.toLowerCase()))
                                .toList();
                          }
                        },
                        prefixIcon: SvgPicture.asset(AppIcons.search),
                        hintText: AppString.search),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    children: [
                      const ActionTile(actionText: AppString.technology),
                      ValueListenableBuilder(
                          valueListenable: filteredProducts,
                          builder: (context, products, _) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              color: AppColors.greyFB,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products
                                        .map((p) => p.subCategory)
                                        .toSet()
                                        .join(', '),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: buildTextStyle(
                                        weight: FontWeight.w500, size: 18),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 220,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: 0.7,
                                        ),
                                        itemCount: products.length,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          return ProductCard(product: product);
                                        },
                                        shrinkWrap: true,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          })
                    ],
                  ))
                ],
              );
            }));
  }
}
