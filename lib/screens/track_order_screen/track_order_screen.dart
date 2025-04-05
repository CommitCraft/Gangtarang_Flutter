import 'package:amazmart/api/response_orderes/response_orderes.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/track_order_screen/widgets/order_timeline.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  ResponseOrderes product;
  TrackOrderScreen({super.key, required this.product});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState(product);
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late ResponseOrderes product = ResponseOrderes();
  _TrackOrderScreenState(ResponseOrderes responseOrderes) {
    product = responseOrderes;
  }
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Write Review'),
        backgroundColor: appTheme.whiteA700,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 4.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  color: Color(0xFFE0E5EB),
                ),
                Row( children: [
                    // Product Image
                    Container(
                      padding: EdgeInsets.all(11),
                      margin: EdgeInsets.all(10),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$currencySymbol${product.lineItems?.first.price}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${product.discountTotal}% OFF",
                                style: const TextStyle(
                                  fontSize: 12,
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
                Container(
                  height: 10,
                  color: Color(0xFFE0E5EB),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Overall Rating',
                      style: CustomTextStyles.titleMediumErrorContainer,
                    ),
                  ),
                ),
                Divider(),
                Container(
                                       width: MediaQuery.of(context).size.width - 70,

                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderTimeline(orderStatuses: orderStatuses)
                      ],
                    )),
              
              ],
            ),
          ),
        ),
      ),
    );
  }

List<OrderStatus> orderStatuses = [
      OrderStatus(
        title: 'Order Placed',
        subtitle: 'We have received your order',
        date: '27 Dec 2023',
        isCompleted: true,
      ),
      OrderStatus(
        title: 'Order Confirm',
        subtitle: 'We have confirmed your order',
        date: '27 Dec 2023',
        isCompleted: true,
      ),
      OrderStatus(
        title: 'Order Processed',
        subtitle: 'We are preparing your order',
        date: '28 Dec 2023',
        isCompleted: true,
      ),
      OrderStatus(
        title: 'Ready To Ship',
        subtitle: 'Your order is ready for shipping',
        date: '28 Dec 2023',
        isCompleted: false,
      ),
      OrderStatus(
        title: 'Out For Delivery',
        subtitle: 'Your order is out for delivery',
        date: '28 Dec 2023',
        isCompleted: false,
      ),
    ];


}
