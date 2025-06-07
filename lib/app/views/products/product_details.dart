import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/icons.dart';
import 'package:damishop/app/core/strings.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:damishop/app/domain/controllers/cart_controller.dart';
import 'package:damishop/app/models/product_model.dart';
import 'package:damishop/app/views/components/action_tile.dart';
import 'package:damishop/app/views/components/cached_image_viewer.dart';
import 'package:damishop/app/views/components/custom_button.dart';
import 'package:damishop/app/views/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
// The task does not include wishlist so the state is just temporily managed but not saved
  bool wished = false;

  final GlobalKey _productKey = GlobalKey();
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;

  Offset _startOffset = Offset.zero;
  Offset _endOffset = Offset.zero;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  void _startAnimation() {
    final size = MediaQuery.of(context).size;

    _startOffset = Offset.zero;
    final Offset jumpOffset = Offset(-100, _startOffset.dy + 100);
    _endOffset = Offset(-size.width, size.height);

    _positionAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween<Offset>(begin: _startOffset, end: jumpOffset)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween<Offset>(begin: jumpOffset, end: _endOffset)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 10),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.1, end: 0.3)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 30),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.3, end: 0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30),
    ]).animate(_animationController);

    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry);

    _animationController.forward(from: 0).whenComplete(() {
      _overlayEntry.remove();
    });
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          Offset offset = _positionAnimation.value;
          double scale = _scaleAnimation.value;
          return Positioned(
            top: offset.dy,
            left: offset.dx,
            child: Transform.scale(
              scale: scale,
              child: CachedImageWidget(path: widget.product.imagePath),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();
    return CustomScaffold(
      body: Column(
        children: [
          const ActionTile(actionText: AppString.goBack),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: CachedImageWidget(
                          key: _productKey,
                          path: widget.product.imagePath,
                        ),
                      ),
                      Positioned(
                          top: 11,
                          right: 14,
                          child: StatefulBuilder(builder: (context, reb) {
                            return InkWell(
                                onTap: () {
                                  reb(() {
                                    wished = !wished;
                                  });
                                },
                                child: SvgPicture.asset(wished
                                    ? AppIcons.wished
                                    : AppIcons.unwished));
                          }))
                    ],
                  ),
                  verticalSpacer(10),
                  Text(
                    widget.product.name,
                    style: buildTextStyle(size: 17),
                  ),
                  verticalSpacer(10),
                  Text(
                    '\$${formatMoney(widget.product.price.toString())}',
                    style: buildTextStyle(size: 32.75, weight: FontWeight.w700),
                  ),
                  verticalSpacer(15),
                  Text(
                    AppString.aboutItem,
                    style: buildTextStyle(color: AppColors.grey99),
                  ),
                  verticalSpacer(5),
                  Column(
                      children: List.generate(
                    2,
                    (i) => Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 2.5,
                              backgroundColor: AppColors.grey99,
                            ),
                            horizontalSpacer(10),
                            Expanded(
                              child: Text(
                                [AppString.aboutNote1, AppString.aboutNote2][i],
                                style: buildTextStyle(
                                    color: AppColors.grey99, height: 1.3),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.greyF6))),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Obx(
                () => CustomButton(
                  loading: cartCtrl.isBusy.value,
                  text: AppString.addToCart,
                  disabled: cartCtrl.inCart(widget.product),
                  onTap: () async {
                    await cartCtrl.addToCart(context, widget.product);
                    _startAnimation();
                  },
                ),
              ))
        ],
      ),
    );
  }
}
