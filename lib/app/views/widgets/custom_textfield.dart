import 'package:damishop/app/core/colors.dart';
import 'package:damishop/app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      this.validator,
      this.controller,
      this.inputType = TextInputType.name,
      this.suffixIcon,
      this.prefixIcon,
      this.autoFocus = false,
      this.readOnly,
      this.onTap,
      this.maxLines,
      this.onChanged,
      this.capitalization,
      this.center = false,
      this.style,
      this.horizontalPadding,
      this.inputFormatters,
      this.focusNode});
  final String hintText;
  final TextEditingController? controller;
  final TextInputType inputType;
  final TextCapitalization? capitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final bool center;
  final double? horizontalPadding;
  final bool autoFocus;
  final int? maxLines;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator == null
            ? null
            : (v) {
                return validator!(controller?.text);
              },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: maxLines == null ? 36 : null,
                child: TextFormField(
                  maxLines: maxLines,
                  inputFormatters: [
                    if (inputType == TextInputType.number)
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ...?inputFormatters
                  ],
                  onTap: onTap,
                  autovalidateMode: AutovalidateMode.always,
                  autofocus: autoFocus,
                  controller: controller,
                  textCapitalization: capitalization ?? TextCapitalization.none,
                  keyboardType: (maxLines != null && maxLines! > 1)
                      ? TextInputType.multiline
                      : inputType,
                  onChanged: onChanged,
                  focusNode: focusNode,
                  textInputAction: (maxLines != null && maxLines! > 1)
                      ? TextInputAction.newline
                      : TextInputAction.next,
                  textAlign: center ? TextAlign.center : TextAlign.start,
                  readOnly: readOnly ?? false,
                  style: style ??
                      buildTextStyle(
                          weight: FontWeight.w400, size: 14, height: 20 / 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding ?? 16,
                          vertical: maxLines != null ? 12 : 0),
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: hintText,
                      suffixIcon: suffixIcon,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding ?? 0),
                        child: prefixIcon,
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      suffixIconConstraints: const BoxConstraints(),
                      hintStyle: GoogleFonts.raleway(
                          color: AppColors.grey300, fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: state.hasError
                                ? AppColors.error
                                : AppColors.grey200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: state.hasError
                                ? AppColors.error
                                : AppColors.primary),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              if (state.hasError)
                const SizedBox(
                  height: 6,
                ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: GoogleFonts.raleway(color: AppColors.error),
                )
            ],
          );
        });
  }
}
