
import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:flutter/material.dart';

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
}

void showCustomSnackbar(
  BuildContext context, {
  required String text,
  Widget? icon,
  Color? textColor = AppColors.white,
  StatusTypes status = StatusTypes.info
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: status.getColor(),
      content: Row(
        children: [
          icon ?? Icon(Icons.info, color: textColor),
          AppLayout.spaceW10,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              text,
              style: AppStyle.bodyTextStyle.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}