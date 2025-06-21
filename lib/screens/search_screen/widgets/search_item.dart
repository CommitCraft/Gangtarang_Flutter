import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SearchItemList extends StatelessWidget {
 final String title;
 final VoidCallback? onTap;
  const SearchItemList({Key? key , required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.IconClock,
          height: 20.h,
          width: 22.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Container(
            width: 200,
            child: Text(
              title,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.iconRightTopArrow,
          height: 20.h,
          width: 22.h,
        ),
      ],
    ),);
   
  }
}