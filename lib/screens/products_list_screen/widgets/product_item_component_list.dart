import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/api/shared_preference_helper.dart';


class ProductItemComponentList extends StatefulWidget {
  final String productName;
  final String productImage;
  final String salePrice;
  final String? originalPrice;
  final String? discountText;
  final int reviewCount;
  final double rating;
  final VoidCallback onItemClick;
  final VoidCallback onWishlistClick;

  const ProductItemComponentList({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.salePrice,
    required this.originalPrice,
    required this.discountText,
    required this.reviewCount,
    required this.rating,
    required this.onItemClick,
    required this.onWishlistClick,
  }) : super(key: key);

  @override
  State<ProductItemComponentList> createState() => _ProductItemComponentListState();
}

class _ProductItemComponentListState extends State<ProductItemComponentList> {
bool wishlistSelecte = false;
  String currencySymbol = '\$';
  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onItemClick, // Trigger item click
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left side
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF6F8FA),
                  borderRadius: BorderRadius.circular(8.0)),
              child: CustomImageView(
                imagePath: widget.productImage,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
                margin: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(width: 10.0),
            // Content on the right side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15.0,
                      fontWeight:  FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      // Rating bar
                      CustomRatingBar(
                        initialRating: widget.rating,
                        ignoreGestures: true,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '${widget.reviewCount} reviews)',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        '$currencySymbol${widget.salePrice}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                       widget.originalPrice!.isNotEmpty ? '$currencySymbol${widget.originalPrice}' : '',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF71757A),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                       widget.discountText!= null ? '${widget.discountText}% OFF' : '',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFCD005D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4.0),
                  Row(
                    children: [
                      CustomImageView(imagePath: ImageConstant.iconRetrun),
                      SizedBox(width: 4,),
                      Expanded(
                        child: Text(
                          '14 Days return available',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFF219653),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Wishlist Icon
            IconButton(
              onPressed: () {
                setState(() {
                  wishlistSelecte = !wishlistSelecte;
                });
                widget.onWishlistClick.call();
              },
              icon: CustomImageView(
                      imagePath: wishlistSelecte ? ImageConstant.IconWishlistRed :ImageConstant.navWishlist,
                      height: 14,
                      width: 14,
                    ),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
