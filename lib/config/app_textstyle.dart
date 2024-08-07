import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';

class AppTextStyle {
  static const TextStyle display = TextStyle(
      fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.black);

  static const TextStyle heading1 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white);

  static const TextStyle heading2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white);

  static const TextStyle body2Semibold = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black);
  static const TextStyle body2Medium = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black);
  static const TextStyle body1 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.white);
  static const TextStyle buttonTextSmall =
      TextStyle(fontSize: 12, color: AppColors.black);
}
