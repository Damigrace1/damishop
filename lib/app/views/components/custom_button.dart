import 'package:damishop/app/core/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final double elevation;
  final bool loading;
  final bool isPrimary;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.loading = false,
    this.isPrimary = true,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.disabled = false,
    this.borderRadius = 0,
    this.padding,
    this.icon,
    this.elevation = 7,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> showChild = ValueNotifier(loading);

    Future.delayed(const Duration(milliseconds: 100), () {
      showChild.value = !loading;
    });
    return InkWell(
      borderRadius: BorderRadius.circular(200),
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 200),
          height: 40,
          padding: loading ? null : padding ?? const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: disabled ? AppColors.grey200 : backgroundColor),
            color: isPrimary
                ? (disabled
                    ? AppColors.grey200
                    : loading
                        ? AppColors.loading
                        : backgroundColor)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    backgroundColor: AppColors.white,
                  ))
              : ValueListenableBuilder(
                  valueListenable: showChild,
                  builder: (context, v, _) {
                    return v
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (icon != null) ...[
                                icon!,
                                const SizedBox(width: 8),
                              ],
                              Text(
                                text,
                                style: TextStyle(
                                  height: 1,
                                  color: isPrimary
                                      ? disabled
                                          ? AppColors.grey500
                                          : textColor
                                      : backgroundColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox();
                  })),
    );
  }
}
