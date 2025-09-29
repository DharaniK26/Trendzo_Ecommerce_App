
import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormfield extends StatelessWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? errorStyle;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int? maxLength;
  final double? fontSize;
  final Widget? iconfunction;
  final bool? obscureText;
  final bool? isReadonly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;
  final AutovalidateMode? autoValidateMode;
  final bool? autoFocus;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? forceUpperCase;

  const CustomTextFormfield({
    super.key,
    required this.hintText,
    this.hintTextStyle,
    this.controller,
    this.onTap,
    required this.textInputType,
    required this.maxLength,
    this.iconfunction,
    this.fontSize,
    this.obscureText,
    this.prefixIcon,
    this.maxLines = 1,
    this.validator,
    this.inputFormatters,
    this.suffixIcon,
    this.textAlign,
    this.textAlignVertical,
    this.isReadonly = false,
    this.errorStyle,
    this.onChanged,
    this.autoValidateMode,
    this.autoFocus = false,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.forceUpperCase = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      onChanged: onChanged,
      readOnly: isReadonly!,
      validator: validator,
      style: isReadonly!
          ? AppStyle.inputTextStyle.copyWith(
              color: AppColors.disabledText,
              fontSize: fontSize,
            )
          : AppStyle.inputTextStyle.copyWith(
              fontSize: fontSize,
            ),
      inputFormatters: [
        if (forceUpperCase == true)
          TextInputFormatter.withFunction(
            (oldValue, newValue) => newValue.copyWith(
              text: newValue.text.toUpperCase(),
              selection: newValue.selection,
            ),
          ),
        ...?inputFormatters,
      ],

      controller: controller,
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      cursorColor: AppColors.prime,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      // cursorHeight: 17.h,
      autovalidateMode: autoValidateMode,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        errorStyle: errorStyle,
        counterText: "",
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 40, maxWidth: 80),
        hintText: hintText,
        hintStyle: hintTextStyle ?? AppStyle.inputTextStyle,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textInputAction: textInputAction,
      onTap: onTap,
    );
  }
}