import 'package:amazmart/api/customer.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ListAddressWidget extends StatelessWidget {
  Address address;
  VoidCallback onTap;

  ListAddressWidget({
    Key? key,
    required this.address,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: appTheme.whiteA700,border: Border(bottom: BorderSide(color: appTheme.indigo50,width: 1))),
        // margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(
          16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: appTheme.indigo50),
              child: CustomImageView(
                imagePath: address.type == 'Home'
                    ? ImageConstant.iconHome
                    : address.type == 'Shop'
                        ? ImageConstant.iconShop
                        : address.type == 'Office'
                            ? ImageConstant.iconOffice
                            : ImageConstant.iconHome,
                height: 24.h,
                width: 24.h,
                color: appTheme.black900,
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${address.type} Address",
                    style: CustomTextStyles.titleMediumErrorContainer,
                  ),
                  Text(
                    '${address.address}, ${address.localityTown}, ${address.cityDistrict}, ${address.state},  ${address.pincode}',
                    style: CustomTextStyles.bodyMediumBluegray40014,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.h),
            CustomImageView(
              imagePath: address.addressSelected == 1
                  ? ImageConstant.iconSelect
                  : ImageConstant.iconUnSelect,
              height: 24.h,
              width: 24.h,
            ),
          ],
        ),
      ),
    );
  
  }
}



