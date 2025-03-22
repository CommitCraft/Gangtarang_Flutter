import 'package:amazmart/api/response_orderes/response_orderes.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/theme/theme_helper.dart';

class OrderlistItemWidget extends StatefulWidget {
  final ResponseOrderes product;
  final int initialQuantity;
  final void Function(ResponseOrderes product) onTrackOrder;
  final void Function(ResponseOrderes product) onWriteReview;
  final void Function(ResponseOrderes product) onRemove;
  final void Function(ResponseOrderes product) onBodyClick;

  const OrderlistItemWidget({
    Key? key,
    required this.product,
    this.initialQuantity = 1,
    required this.onTrackOrder,
    required this.onWriteReview,
    required this.onRemove,
    required this.onBodyClick,
  }) : super(key: key);

  @override
  State<OrderlistItemWidget> createState() => _OrderlistItemWidgetState();
}

class _OrderlistItemWidgetState extends State<OrderlistItemWidget> {
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
    final product = widget.product;

    return GestureDetector(
      onTap: () => widget.onBodyClick(widget.product),
      child: Container(
        margin: EdgeInsets.only(
          bottom: 5,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.shade300,
            //   blurRadius: 5,
            //   offset: const Offset(0, 2),
            // ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Product Image
                Container(
                  height: 130,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    product.lineItems?.first?.image?.src as String,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.lineItems?.first.name as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Rating Bar
                          CustomRatingBar(
                            ignoreGestures: true,
                            initialRating: 0,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "( Reviews)",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Price Row
                      Row(
                        children: [
                          Text(
                            "$currencySymbol${product.lineItems?.first.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$currencySymbol${product.lineItems?.first.price}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${product.discountTotal}% OFF",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFCD005D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Return Policy
                      Row(
                        children: [
                          CustomImageView(imagePath: ImageConstant.iconRetrun),
                          SizedBox(width: 4),
                          Text(
                            "14 Days return available",
                            
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Buttons
            Row(
              children: [
                // Save for Later Button
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () => widget.onTrackOrder(widget.product),
                      icon: CustomImageView(
                        imagePath: ImageConstant.iconTrack,
                        color: theme.primaryColor,
                      ),
                      label: const Text(
                        "Track Order",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF7D899D)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                // Save for Later Button
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () => widget.onWriteReview(widget.product),
                      icon: CustomImageView(
                        imagePath: ImageConstant.iconOrderstar_un,
                        color: const Color(0xFF7D899D),
                      ),
                      label: const Text(
                        "Write Review",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF7D899D)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Remove Button
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () => widget.onRemove(widget.product),
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Remove",
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
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
