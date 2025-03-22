import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';

class TrendingProductsItemWidget extends StatelessWidget {
  final String Trending;
  final String Title;
  final String Discount;
  final String imagePath;
  const TrendingProductsItemWidget({
    Key? key,
   required this.Trending,
   required this.Discount,
   required this.Title,
   required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadiusStyle.roundedBorder6,
      child: Container(
        height: 206.h,
        width: 160.h,
        decoration: BoxDecoration(
          color: appTheme.blueGray100,
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 206.h,
              width: double.maxFinite,
              radius: BorderRadius.circular(6.h),
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 10.h,
                top: 10.h,
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.gray90082,
                borderRadius: BorderRadiusStyle.roundedBorder6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Trending,
                    style: CustomTextStyles.labelLargeWhiteA700,
                  ),
                  Text(
                  Title,
                    style: CustomTextStyles.titleMediumWhiteA700Bold.copyWith(fontSize: 18),
                  ),
                  Text(
                    Discount.toUpperCase(),
                    style: CustomTextStyles.labelMediumRedA100.copyWith(fontWeight: FontWeight.w600, color: Color(0xFFFF8383)),
                  ),
                  SizedBox(height: 80.h),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () { Navigator.of(context,
                                                rootNavigator: true)
                                            .push(PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              ProductsListScreen(
                                          ),
                                        ));},
                      child: Text(
                        'Shop Now',
                        style: theme.textTheme.titleMedium,
                      ),
                      style: CustomButtonStyles.fillWhiteA,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
