import 'package:amazmart/core/app_export.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
 final String? cardbg;
 final String? cardType;
 final String? cardHolderName;
 late String cardNo;
 final String? cardExpire;
 final EdgeInsets? padding;

  CreditCard({super.key, 
  this.cardbg , 
  this.cardType ,
  this.cardHolderName ,
  this.cardNo =  '**** **** **** 4532',
  this.cardExpire,
  this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(top: 10, bottom: 30),
      width: 340,
      height: 222,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageConstant.imgCardBg), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Visa logo
                CustomImageView(imagePath: cardType ?? ImageConstant.iconVisa ,
                height: 40 ,
                width: 50,
                fit: BoxFit.fitWidth, ),
                 Spacer(),

                 SizedBox(height: 16),
                // Card holder and expiry
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardHolderName ?? 'ROOPA SMITH',
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Card number
                        Text( cardNo ,
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          'EXPIRES',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                         cardExpire ??'10/28',
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
