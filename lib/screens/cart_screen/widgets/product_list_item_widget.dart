import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/theme/theme_helper.dart';

class ProductlistItemWidget extends StatefulWidget {
  final CartItem product;
  final int initialQuantity;
  final void Function(String productId, int newQuantity) onQuantityChange;
  final void Function(String productId) onSaveForLater;
  final void Function(String productId) onRemove;
  final void Function(String productId) onBodyClick;

  const ProductlistItemWidget({
    Key? key,
    required this.product,
    this.initialQuantity = 1,
    required this.onQuantityChange,
    required this.onSaveForLater,
    required this.onRemove,
    required this.onBodyClick,
  }) : super(key: key);

  @override
  State<ProductlistItemWidget> createState() => _ProductlistItemWidgetState();
}

class _ProductlistItemWidgetState extends State<ProductlistItemWidget> {
  late int quantity;
    String currencySymbol = '\₹';

  @override
  void initState() {
    super.initState();
       SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\₹';
    quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
    widget.onQuantityChange(widget.product.productId as String, quantity);
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChange(widget.product.productId as String, quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return GestureDetector(
      onTap: () => widget.onBodyClick(product.productId as String),
      child: Container(
        margin: EdgeInsets.only(bottom: 10,),
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
                    product.productImage,
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
                        product.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Rating Bar
                          CustomRatingBar(initialRating: product.rating,),
                          const SizedBox(width: 4),
                          Text(
                            "(${product.reviewCount} Reviews)",
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
                            "$currencySymbol${product.salePrice}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$currencySymbol${product.regularPrice}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${product.discount}% OFF",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFCD005D) ,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Return Policy
                      Row(
                        children: [
                          CustomImageView(imagePath: ImageConstant.iconRetrun, height: 14 , width: 14),
                          const SizedBox(width: 8),
                          Text(
                            product.returnLabel,
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
                // Quantity Selector
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: appTheme.indigo50,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _decrementQuantity,
                        child: Container(
                          padding: EdgeInsets.only(right: 1),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          height: 40,
                          child: const Icon(Icons.remove, size: 20),
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 18, right: 18),
                        color: appTheme.whiteA700,
                        child: Center(child: Text(
                          "$quantity",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),),
                      ),
                      GestureDetector(
                        onTap: _incrementQuantity,
                        child: Container(
                            padding: EdgeInsets.only(left: 1),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            height: 40,
                            child: const Icon(Icons.add, size: 20)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Save for Later Button
                Expanded(
                  child: SizedBox(height: 40,child: OutlinedButton.icon(
                    onPressed: () => widget.onSaveForLater(product.productId as String),
                    icon: CustomImageView(imagePath: ImageConstant.iconSave   ),
                    label: const Text("Save for later" ,style: TextStyle(color: Color(0xFF7D899D)),),
                  ),),
                ),
                const SizedBox(width: 10),
                // Remove Button
                Expanded(
                  child:  SizedBox( 
                    height: 40,
                    child: OutlinedButton.icon(
                    onPressed: () =>
                        widget.onRemove(product.productId as String),
                    icon: const Icon(Icons.delete_outline, size: 16,color: Colors.red,),
                    label: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}