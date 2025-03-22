import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_rating_bar.dart';

class ProductWishlistItemWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productOldPrice;
  final String productDiscount;
  final int? reviewCount;
  final double? rating;
  final VoidCallback onTrashClick;
  final VoidCallback onAddToCartClick;
  final VoidCallback onFullViewClick;

  const ProductWishlistItemWidget({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productOldPrice,
    required this.productDiscount,
    this.reviewCount,
    this.rating,
    required this.onTrashClick,
    required this.onAddToCartClick,
    required this.onFullViewClick,
  }) : super(key: key);

  @override
  State<ProductWishlistItemWidget> createState() => _ProductWishlistItemWidgetState();
}

class _ProductWishlistItemWidgetState extends State<ProductWishlistItemWidget> {
    String currencySymbol = '\$';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFullViewClick,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: appTheme.gray10002,
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trash Icon
            GestureDetector(
              onTap: widget.onTrashClick,
              child: CustomImageView(
                margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                imagePath: ImageConstant.wishTrash,
                height: 18.h,
                width: 20.h,
                alignment: Alignment.centerRight,
              ),
            ),

            // Product Image
            // Full view click action
            CustomImageView(
              imagePath: widget.productImage,
              height: 116.h,
              width: 84.h,
            ),

            SizedBox(height: 18.h),

            // Product Name
            Text(
              widget.productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium!.copyWith(
                height: 1.29,
              ),
            ),

            SizedBox(height: 2.h),

            // Rating and Reviews
            Row(
              children: [
                CustomRatingBar(
                  ignoreGestures: true,
                  initialRating: widget.rating ?? 0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "(${widget.reviewCount ?? 0} Review)",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),

            // Price and Discount
            Row(
              children: [
                Text(
                  '$currencySymbol${widget.productPrice}',
                  style: CustomTextStyles.titleMediumSemiBold
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    '$currencySymbol${widget.productOldPrice}',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    '${widget.productDiscount} % OFF',
                    style: CustomTextStyles.labelLargePinkA700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.h),

            // Add to Cart Button
            ElevatedButton(
              onPressed: widget.onAddToCartClick,
              child: Text(
                'Add To Cart',
                style: theme.textTheme.titleSmall,
              ),
              style: CustomButtonStyles.outlineAmber,
            ),
          ],
        ),
      ),
    );
  }
}
