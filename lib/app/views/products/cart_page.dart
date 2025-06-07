import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/domain/controllers/cart_controller.dart';
import 'package:damishop/app/views/components/action_tile.dart';
import 'package:damishop/app/views/components/cart_card.dart';
import 'package:damishop/app/views/components/custom_button.dart';
import 'package:damishop/app/views/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GetBuilder<CartController>(
          id: 'cart',
          builder: (cartCtrl) {
            return Column(
              children: [
                const ActionTile(actionText: AppString.yourCart),
                cartCtrl.cartItems.entries.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text('No item in cart'),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    itemBuilder: (context, index) => CartCard(
                                        product: cartCtrl.cartItems.keys
                                            .toList()[index]),
                                    separatorBuilder: (c, _) => const SizedBox(
                                          height: 15,
                                        ),
                                    itemCount: cartCtrl.cartItems.length)),
                            Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: AppColors.greyF6))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: CustomButton(
                                  loading: cartCtrl.isBusy.value,
                                  text:
                                      '${AppString.checkout} (\$${formatMoney(cartCtrl.total.toString())})',
                                  onTap: () {},
                                )),
                          ],
                        ),
                      )
              ],
            );
          }),
    );
  }
}
