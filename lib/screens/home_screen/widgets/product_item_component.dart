import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/api/wishlist_model.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class ProductItemComponent extends StatefulWidget {
  final String productName;
  final String productImage;
  final String salePrice;
  final String? originalPrice;
  final String? discountText;
  final int reviewCount;
  final double rating;
  final VoidCallback onItemClick;
  final VoidCallback onWishlistClick;
  final Color? bgColor;

  ProductItemComponent({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.salePrice,
    required this.originalPrice,
    required this.discountText,
    required this.reviewCount,
    required this.rating,
    required this.onItemClick,
    this.bgColor,
    required this.onWishlistClick,
  }) : super(key: key);

  @override
  ProductItemComponentPageState createState() =>
      ProductItemComponentPageState();
}

class ProductItemComponentPageState extends State<ProductItemComponent> {
  bool wishlistSelecte = false;
  String currencySymbol = '\$';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // wishlistSelecte = false;
    SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onItemClick, // Trigger item click
      child: Container(
        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: widget.bgColor ??
                          Color(0xFFF6F8FA), // Divider color equivalent
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: SizedBox(
                        height:
                            172.0, // Set a fixed height for the image container
                        width: double.maxFinite -
                            10, // Allow image width to expand
                        child: ClipRRect(
                          // Clip overflowing image content
                          borderRadius: BorderRadius.circular(6.0),
                          child: CustomImageView(
                            imagePath: widget.productImage,
                            height: 99,
                            width: double.maxFinite - 20,
                            fit: BoxFit
                                .contain, // Resize image while maintaining aspect ratio
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.productName,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'jost',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRatingBar(
                                initialRating: widget.rating,
                                itemSize: 14,
                                ignoreGestures: true,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                            width: 10,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            '(${widget.reviewCount} Reviews)',
                            style: const TextStyle(
                              fontFamily: 'jost',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Color(0xFF757575), // TextColorSecondary
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          '$currencySymbol${widget.salePrice}',
                          style: const TextStyle(
                            fontFamily: 'jost',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Flexible(
                          child: Text(
                            widget.originalPrice!.isNotEmpty
                                ? '$currencySymbol${widget.originalPrice}'
                                : '',
                            style: const TextStyle(
                              fontFamily: 'jost',
                              fontSize: 13.0,
                              color: Color(0xFF757575), // TextColorSecondary
                              decoration: TextDecoration.lineThrough,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Flexible(
                          child: Text(
                            widget.discountText != null
                                ? '${widget.discountText} %OFF'
                                : '',
                            style: CustomTextStyles.bodyMediumLufgaRedA70003
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                            // style: const TextStyle(
                            //   fontFamily: 'jost',
                            //   fontSize: 14.0,
                            //   color: Color(0xFFE53935), // TextColorDiscount
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 1.0,
                  right: -5.0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                      wishlistSelecte = !wishlistSelecte;
                      print('$wishlistSelecte');
                        
                      });

                      widget.onWishlistClick.call();
                    },
                    icon: CustomImageView(
                      imagePath: wishlistSelecte ? ImageConstant.IconWishlistRed :ImageConstant.navWishlist,
                      height: 14,
                      width: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
