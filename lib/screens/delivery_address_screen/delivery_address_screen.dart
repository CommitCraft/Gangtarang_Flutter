import 'package:amazmart/api/customer.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/add_delivery_address_screen/add_delivery_address_screen.dart';
import 'package:amazmart/screens/cart_screen/cart_screen.dart';
import 'package:amazmart/screens/delivery_address_screen/widgets/list.dart';
import 'package:amazmart/screens/payment_screen/payment_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  late DatabaseHelper db = DatabaseHelper();
  late List<Address> addressList = [];
  late bool isAddressLoading;

  

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper();
    fetchAddressList();
  }

  void fetchAddressList() {
    isAddressLoading = true;
    try {
      db.getAddressItems().then(
        (value) {
          print(value);
          var i = value;
          setState(() {
            addressList = i;
            isAddressLoading = false;
          });
        },
      );
    } catch (e) {
      print('Error$e');
    }
  }

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),));
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(title: 'Delivery Address'),
            // backgroundColor: appTheme.whiteA700,
            body: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildProgressSteps(context),
                        SizedBox(height: 6.h),
                        isAddressLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buildAddressList(context),
                        Container(
                          padding: EdgeInsets.all(16),
                          color: appTheme.whiteA700,
                          child: ElevatedButton(
                            style: CustomButtonStyles.fillBlueGray,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                          AddDeliveryAddressScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8,
                                            left: 8,
                                            top: 8,
                                            bottom:
                                                8), // Space around the start icon
                                        child: CustomImageView(
                                            imagePath:
                                                ImageConstant.iconPlusCircel),
                                      ),
                                      Text(
                                        'Add Address',
                                        style: CustomTextStyles
                                            .titleMediumErrorContainer,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8,
                                        right:
                                            8), // Space around the end arrow icon
                                    child: CustomImageView(
                                        imagePath: ImageConstant.iconRightArrow),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    color: appTheme.whiteA700,
                    padding: EdgeInsets.all(
                      16,
                    ),
                    child: SizedBox(height: 48, child: ElevatedButton(
                      style: CustomButtonStyles.fillAmber,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              PaymentScreen(),
                        ));
                      },
                      child: Text('Proceed to Buy',
                          style: CustomTextStyles.titleMediumErrorContainer),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget buildProgressSteps(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      height: 40.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.h),
            decoration: BoxDecoration(
              color: appTheme.amber400,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "1",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "Cart",
              style: CustomTextStyles.labelLargeWhiteA70013,
            ),
          ),
          Expanded(
            child: Divider(
              color: appTheme.amber400,
              indent: 7.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 8.h),
            decoration: BoxDecoration(
              color: appTheme.amber400,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "2",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "Address",
              style: CustomTextStyles.labelLargeWhiteA70013,
            ),
          ),
          Expanded(
            child: Divider(
              color: appTheme.whiteA700.withOpacity(0.3),
              indent: 8.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "3",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                "Payment",
                style: CustomTextStyles.labelLargeWhiteA70013,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddressList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appTheme.indigo50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          addressList.length,
          (index) {
              var i = addressList[index];
            return ListAddressWidget(
              address: i,
              onTap: () {
                setState(() {
                  for(Address ad in addressList){
                    ad.addressSelected = 0; 
                    db.updateDefaultAddress(ad.id, 0);                   
                  }
                i.addressSelected  = 1;
                    db.updateDefaultAddress(i.id, 1);                   
                });
              },
            );
          },
        ),
      ),
    );
  }
}
