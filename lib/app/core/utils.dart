import 'package:damishop/app/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

TextStyle buildTextStyle(
        {double? size, FontWeight? weight, double? height, Color? color}) =>
    GoogleFonts.ibmPlexSans(
        height: height ?? 1,
        fontWeight: weight ?? FontWeight.w400,
        fontSize: size ?? 14,
        color: color ?? AppColors.black);

String formatMoney(String? value) {
  if (value == 'null') {
    return '--';
  }
  return NumberFormat('#,##0').format(double.parse(value!));
}

SizedBox verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}
