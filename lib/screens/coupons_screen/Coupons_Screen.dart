import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/screens/coupons_screen/widgets/coupons_item.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../api/coupons/coupons.dart';
import '../../core/app_export.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  bool isLoading = true;
  late WooCommerceApi wc;
  List<Coupons> couponsList = [
    Coupons(code: '10%\nOFF', amount: '100.00', minimumAmount: '999',productCategories: ['Home Decor']),
    Coupons(code: '20%\nOFF', amount: '1000.00', minimumAmount: '9999',productCategories: ['Mobile Accessories']),
    Coupons(code: '15%\nOFF', amount: '1000.00', minimumAmount: '9999',productCategories: ['Accessories'])
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wc = WooCommerceApi(WooCommerceApi.createDio());
    fetchCoupons();
  }

  void fetchCoupons() async {
    try {
      var data = await wc.getCoupons();
      print('Response data ${data}');

      setState(() {
        couponsList.isEmpty ? couponsList = data : couponsList.addAll(data);
        isLoading = false;
      });
    } on DioException catch (e) {
      print('Response eror ${e.response}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: CustomAppBar(
          title: 'Coupons',
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : couponsList.isEmpty
                ? Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('No Coupons'),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: couponsList.length,
                                        itemBuilder: (context, index) {
                                          var e = couponsList[index];
                                          return CouponsItem(
                                            CodeTitle: e.code,
                                            discountPrice: e.amount,
                                            Title: '${e.productCategories?.first ?? ''} ',
                                            description: "${e.description ?? ''} On Minimum Purchase ${e.minimumAmount}",
                                          );
                                        },
                                      ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
