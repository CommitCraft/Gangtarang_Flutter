import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class FeaturesListItemWidget extends StatelessWidget {
  final String text;
  final String subText;
  final TextStyle? textStyle;
  final Color? imgcolor;
  final Color? bgcolor;
  final String imagePath;

  const FeaturesListItemWidget(
      {Key? key,
      required this.text,
      required this.subText,
      required this.bgcolor,
      required this.imagePath,
      this.imgcolor,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 267,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: imagePath,
                  height: 44.h,
                  width: 44.h,
                  margin: EdgeInsets.all(5),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: textStyle,
                      ),
                      Text(
                        subText,
                        style: CustomTextStyles.labelLargeBluegray400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
