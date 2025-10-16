import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum StatusTypes { success, info, error }

extension ResultExtension on StatusTypes {
  Color getColor() {
    switch (this) {
      case StatusTypes.success:
        return AppColors.success;
      case StatusTypes.info:
        return AppColors.prime;
      case StatusTypes.error:
        return AppColors.error;
    }
  }

  IconData getIcon() {
    switch (this) {
      case StatusTypes.success:
        return Icons.check_circle;
      case StatusTypes.info:
        return Icons.info;
      case StatusTypes.error:
        return Icons.error;
    }
  }
}

void showCustomSnackbar({
  
  required String text,
  String? title,
  StatusTypes status = StatusTypes.info,
  Color? textColor = AppColors.white,
  Widget? icon,
}) {
  Get.closeAllSnackbars(); 

  Get.snackbar(
    title ?? '', 
    text,
    backgroundColor: status.getColor(),
    colorText: textColor,
    borderRadius: AppLayout.cornerRadius,
    margin: const EdgeInsets.all(12),
    icon: icon ??
        Icon(
          status.getIcon(),
          color: textColor,
        ),
    snackPosition: SnackPosition.BOTTOM, 
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 3),
    messageText: Text(
      text,
      style: AppStyle.bodyTextStyle.copyWith(color: textColor),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
