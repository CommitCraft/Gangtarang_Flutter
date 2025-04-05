import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class NotificationslistItemWidget extends StatelessWidget {
  final String? imgPath;
  final String? title;
  final String? subtitle;
  const NotificationslistItemWidget(
      {Key? key, this.imgPath, this.subtitle, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: imgPath ?? ImageConstant.spo1,
          height: 44.h,
          width: 44.h,
          radius: BorderRadius.circular(10.h),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              title ?? "New Arrivals Alert!",
                style: CustomTextStyles.titleMediumErrorContainer,
              ),
              SizedBox(height: 2.h),
              Text(
              subtitle ?? "15 July 2023",
                style: CustomTextStyles.bodyMediumErrorContainer2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
