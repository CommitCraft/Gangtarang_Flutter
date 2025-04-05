import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_rating_bar.dart';

class GridclassactitemWidget extends StatelessWidget {
  const GridclassactitemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 8.h,
          ),
          decoration: BoxDecoration(
            color: appTheme.gray10002,
            borderRadius: BorderRadiusStyle.roundedBorder6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgCart,
                height: 14.h,
                width: 16.h,
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 6.h),
              CustomImageView(
                imagePath: ImageConstant.imgCart,
                height: 114.h,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 14.h),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          "Class Act Bluetooth Headphones Wireless",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall!.copyWith(),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              CustomRatingBar(
                ignoreGestures: true,
                initialRating: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Text(
                  "(278 Reviews)",
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Text(
                "\$49",
                style: CustomTextStyles.titleMediumSemiBold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "\$99",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "50% OFF",
                  style: CustomTextStyles.labelLargePinkA700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
