import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? textColor;
  final Color? bgColor;
  final double? radius;
  final Widget? icon;
  final MainAxisAlignment rowAlignment;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.fontSize,
    this.height = 48,
    this.textColor = AppColors.white,
    this.bgColor,
    this.radius,
    this.rowAlignment = MainAxisAlignment.start,
  }) : icon = null;

  const CustomButton.icon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.fontSize,
    this.width,
    this.bgColor,
    this.height = 48,
    this.textColor = AppColors.white,
    this.radius,
    this.rowAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,

        //   overlayColor: Colors.transparent,
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(radius ?? AppLayout.cornerRadius),
        // ),
        textStyle: AppStyle.buttonTextStyle,
        backgroundColor: bgColor ?? AppColors.prime,
        foregroundColor: textColor,
        disabledBackgroundColor: AppColors.disabledButton,
        disabledForegroundColor: AppColors.disabledText,
        fixedSize: (width == null || height == null)
            ? null
            : Size(width ?? MediaQuery.sizeOf(context).width, height!),
      ),
      child: icon == null
          ? Text(
              text,
              textAlign: TextAlign.center,
              style: AppStyle.buttonTextStyle.copyWith(
                fontSize: fontSize,
                color: textColor,
              ),
            )
          : Row(
              mainAxisAlignment: rowAlignment,
              mainAxisSize: MainAxisSize.max,
              children: [
                icon!,
                AppLayout.spaceW8,
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppStyle.buttonTextStyle.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ),
              ],
            ),
    );
  }
}
