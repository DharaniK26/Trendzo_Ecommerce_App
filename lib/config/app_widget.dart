import 'package:flutter/material.dart';
import 'package:ecommerce_app_using_flutter/config/app_assets.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';

noItemDataWidget({String? msg}) {
  return Padding(
    padding: AppLayout.screenPadding,
    child: Column(
      children: [
        Center(
          child: Image.asset(
            AppAssets.noItem,
            // height: 400,
          ),
        ),
        Center(
          child: Text(
            msg ?? 'No data!',
            style: AppStyle.commonText14,
          ),
        ),
        // AppSizes.spaceH30,
      ],
    ),
  );
}
