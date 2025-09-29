import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_constants.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_button.dart';
import 'package:flutter/material.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.prime,
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(16),
        //     bottomRight: Radius.circular(16)
        //     )
      ),
      child: Padding(
        padding: AppLayout.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppLayout.spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppConstants.appName,
                  style:
                      AppStyle.titleTextStyle.copyWith(color: AppColors.white),
                ),
                Icon(
                  Icons.shopping_cart,
                  color: AppColors.white,
                ),
              ],
            ),
            AppLayout.spaceH20,
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   height: height * 0.07,
            //   width: width,
            //   decoration: BoxDecoration(
            //     color: AppColors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(16)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.1),
            //         blurRadius: 5,
            //         offset: const Offset(0, 2),
            //       )
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Icon(
            //         Icons.search,
            //         color: AppColors.prime,
            //       ),
            //       AppLayout.spaceW10,
            //       Text("Search")
            //     ],
            //   ),
            // ),
            CustomButton.icon(
                text: "Search",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.searchScreen);
                },
                width: width,
                textColor: AppColors.prime,
                bgColor: AppColors.white,
                rowAlignment: MainAxisAlignment.start,
                icon: Icon(
                  Icons.search,
                  color: AppColors.prime,
                ))
          ],
        ),
      ),
    );
  }
}
