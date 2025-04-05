import 'package:amazmart/api/response_order/tax.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:flutter/material.dart';

class CouponsItem extends StatelessWidget {
  final String? CodeTitle;
  final String? Title;
  final String? discountPrice;
  final String? description;
  const CouponsItem(
      {super.key, this.Title, this.CodeTitle, this.discountPrice,this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16, left: 16, top: 8),
      decoration: BoxDecoration(
          border: Border.all(color: appTheme.indigo50),
          color: appTheme.whiteA700,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            child: Text(
              CodeTitle ?? '',
              style: CustomTextStyles.titleMediumErrorContainer,
            ),
          ),
          SizedBox(width: 10,),

          Container(height: 56,color: appTheme.indigo50, width: 2, ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title ?? '',
                style: CustomTextStyles.titleMediumErrorContainer,
              ),
              Text(
                description ?? '',
                style: CustomTextStyles.bodyMediumErrorContainer,
              )
            ],
          )
        ],
      ),
    );
  }
}
