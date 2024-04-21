import 'package:flutter/material.dart';
import 'package:kakas_task/core/utils/app_colors.dart';

abstract class Styles {
  static TextStyle textStyle24 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.kPrimartTextColor);

  static TextStyle textStyle14 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.kSecondryTextColor);

  static TextStyle textStyle14W500 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.kPrimartTextColor);

  static TextStyle textStyle12 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.kPrimaryColor);

  static TextStyle textStyle18 = const TextStyle(
      fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle textStyle26 =
      const TextStyle(fontSize: 26, fontWeight: FontWeight.w700);
  static TextStyle textStyle23 =
      const TextStyle(fontSize: 23, fontWeight: FontWeight.w700);
}
