import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/response_orderes/response_orderes.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/api/write_review.dart';
import 'package:amazmart/api/write_review_response.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  ResponseOrderes product;
  WriteReviewScreen({super.key, required this.product});

  @override
  State<WriteReviewScreen> createState() =>
      _WriteReviewScreenState(product ?? ResponseOrderes());
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  late ResponseOrderes product = ResponseOrderes();
  _WriteReviewScreenState(ResponseOrderes responseOrderes) {
    product = responseOrderes;
  }
  bool isYes = false;
  bool isNo = false;
  double? initialRating;

  late TextEditingController _ProductReview = TextEditingController();
  late TextEditingController _ReviewTitle = TextEditingController();
  late SharedPreferenceHelper sp = SharedPreferenceHelper();
  late WooCommerceApi wc;
  String currencySymbol = '\$';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
    _ProductReview = TextEditingController();
    _ReviewTitle = TextEditingController();
    sp = SharedPreferenceHelper();
    wc = WooCommerceApi(WooCommerceApi.createDio());
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
              children: [
                Container(
                  height: 10,
                  color: Color(0xFFE0E5EB),
                ),
                Row(
                  children: [
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
                                  fontWeight: FontWeight.w600 ,
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
                      style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                Divider(),
                Container(
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Your average rating is $initialRating',
                            textAlign: TextAlign.left,
                            style: CustomTextStyles.bodyMediumErrorContainer.copyWith (fontSize: 16 ,fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 5,
                        ),
                        CustomRatingBar(
                          onRatingUpdate: (p0) {
                            setState(() {
                              initialRating = p0;
                            });
                          },
                          initialRating: initialRating,
                          itemSize: 24,
                        ),
                      ],
                    )),
                CustomInputField(
                  controller: _ReviewTitle,
                  labelText: 'Review Title',
                ),
                CustomInputField(
                  controller: _ProductReview,
                  labelText: 'Product Review',
                  maxLines: 5,
                  // height: 170,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text('Would you recommend this product to a friend?',
                      textAlign: TextAlign.left,
                      style: CustomTextStyles.bodyMediumErrorContainer.copyWith(fontSize: 15)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      _IconSelecter(isYes, 'Yes', () {
                        setState(() {
                          isYes = !isYes;
                          isNo = false;
                        });
                      }),
                      _IconSelecter(isNo, 'No', () {
                        setState(() {
                          isNo = !isNo;
                          isYes = false;
                        });
                      })
                    ],
                  ),
                ),
                Container(
                  color: appTheme.whiteA700,
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: SizedBox(height: 48, child: ElevatedButton(
                    style: CustomButtonStyles.fillOrangeA,
                    onPressed: reviewSubmit,
                    child: Text('Submit Review',
                        style: CustomTextStyles.titleMediumErrorContainer),
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  
  }

  Widget _IconSelecter(bool image, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16,16,0,16),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            CustomImageView(
                imagePath: image
                    ? ImageConstant.iconSelect
                    : ImageConstant.iconUnSelect),
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                title,
                style: CustomTextStyles.titleMediumErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reviewSubmit() async {
    WriteReview review = WriteReview(
        productId: product.lineItems?.first.productId,
        rating: initialRating?.toInt(),
        review: _ProductReview.text,
        reviewer: sp.getString('displayName'),
        reviewerEmail: sp.getString('email'));
    print(review.toJson());
    try {
      WriteReviewResponse resData = await wc.createProductReview(review);
      if(resData.id!=null){
        ToastMessage.show(context, "Review Submit Successfuly");
      }
      print('Res Data : ${resData.toJson()}');
    } on DioException catch (e) {
      print('Erorr ${e.response}');
    }
  }
}
