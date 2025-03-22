import 'package:amazmart/core/app_export.dart';
import 'package:flutter/material.dart';

class CheckoutTitle extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const CheckoutTitle({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: appTheme.whiteA700,
            border:
                Border(bottom: BorderSide(color: appTheme.indigo50, width: 1))),
        // margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(
          16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: appTheme.indigo50),
              child: CustomImageView(
                imagePath: icon,
                height: 24.h,
                width: 24.h,
                color: appTheme.black900,
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyles.titleMediumErrorContainer,
                  ),
                  Text(
                    subTitle,
                    style: CustomTextStyles.bodyMediumBluegray40014,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.h),
            CustomImageView(
              imagePath: ImageConstant.iconRightArrow,
              height: 24.h,
              width: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
