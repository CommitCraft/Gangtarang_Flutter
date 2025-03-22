import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class BrandlistItemWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  const BrandlistItemWidget({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProductsListScreen(),
        ));
      },
      child:  Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadius.circular(4.h),
        ),
        height: 48.h,
        // width: double.,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 8.h),
              margin: EdgeInsets.only(
                right: 8.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.gray50,
                borderRadius: BorderRadius.circular(4.h),
              ),
              child: CustomImageView(
                imagePath: imagePath,
                height: 20.h,
                width: 18.h,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                title,
                style: CustomTextStyles.bodyMediumOnPrimary,
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
