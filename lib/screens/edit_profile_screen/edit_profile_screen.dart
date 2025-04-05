import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/customer.dart';
import 'package:amazmart/api/customer_response.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _yourName = TextEditingController();
  late TextEditingController _mobiileNomber = TextEditingController();
  late TextEditingController _emailId = TextEditingController();
  late TextEditingController _location = TextEditingController();
  late String _userName;
  late SharedPreferenceHelper sp = SharedPreferenceHelper();
  late WooCommerceApi wp;
  @override
  void initState() {
    super.initState();
    wp = WooCommerceApi(WooCommerceApi.createDio());
    _yourName = TextEditingController();
    _mobiileNomber = TextEditingController();
    _emailId = TextEditingController();
    _location = TextEditingController();
    _userName = '';
    sp = SharedPreferenceHelper();

    fetchUserInfo();
  }

  void fetchUserInfo() {
    // _yourName.text = sp.getString("displayName") ?? " guest";
    // _emailId.text = sp.getString("email") ?? "uset@gmail.com";
    try {
      String? id = sp.getString("id");
      wp.getUserInfo(int.parse(id!)).then(
        (value) {
          Customer cus = value;
          _yourName.text = cus.firstName;
          _emailId.text = cus.email;
          _mobiileNomber.text = cus.billing.phone;
          _location.text = cus.billing.address1;
          setState(() {
          _userName = cus.firstName;
          
          });
        },
      ).onError(
        (error, stackTrace) {},
      );
    } catch (e) {
      print(e);
    }
  }

  updateProfile() {
    late String name = _yourName.text;
    late String email = _emailId.text;
    late String mobile = _mobiileNomber.text;
    late String location = _location.text;
    late String? id = sp.getString("id");
    if (name.isNotEmpty) {
      if (email.isNotEmpty) {
        if (mobile.isNotEmpty) {
          if (location.isNotEmpty) {
            if (id != null) {
              try {
                Customer customer = Customer(
                    email: email,
                    firstName: name,
                    lastName: '',
                    billing: Billing(
                        firstName: name,
                        address1: location,
                        email: email,
                        phone: mobile,
                        lastName: '',
                        company: '',
                        address2: '',
                        city: '',
                        state: '',
                        postcode: '',
                        country: ''),
                    shipping: Shipping(
                      firstName: name,
                      address1: location,
                      lastName: '',
                      company: '',
                      address2: '',
                      city: '',
                      state: '',
                      postcode: '',
                      country: '',
                    ));
                wp.updateCustomer(int.parse(id), customer).then(
                  (value) {
                    CustomerResponse cs = value;
                    if (cs.id != null) {
                      ToastMessage.show(context, 'Profile Updated');
                    } else {
                      ToastMessage.show(context, 'Error');
                    }
                  },
                ).onError(
                  (error, stackTrace) {
                    print(error);
                  },
                );
              } catch (e) {
                // Priint
                ToastMessage.show(context, 'Error');
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.homeScreen);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CustomAppBar(
            title: 'Edit Profile',
            onBackPressed: () async =>
                Navigator.pushNamed(context, AppRoutes.homeScreen),
          ),
          leadingWidth: double.infinity,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( 
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildProfileHeader(context),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: appTheme.whiteA700,
                      child: Column(
                        children: [
                          CustomInputField(
                            controller: _yourName,
                            labelText: 'Your Name',
                          ),
                          CustomInputField(
                            controller: _mobiileNomber,
                            labelText: 'Mobile Number',
                          ),
                          CustomInputField(
                            controller: _emailId,
                            labelText: 'Email Id',
                          ),
                          CustomInputField(
                            controller: _location,
                            labelText: 'Location',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: appTheme.whiteA700,
              padding:
                  EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
              child: ElevatedButton(
                onPressed: updateProfile,
                child: Text(
                  'Update Profile',
                  style: CustomTextStyles.bodyMediumOnPrimary15,
                ),
                style: CustomButtonStyles.fillAmber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.h),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: appTheme.whiteA700),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture and Actions
          Container(
            height: 94.h,
            width: 96.h,
            margin: EdgeInsets.only(top: 2.h),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Profile Card with Picture
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 2.h,
                      ),
                    ),
                    child: Container(
                      height: 90.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusStyle.roundedBorder44,
                        border: Border.all(
                          color: appTheme.whiteA700,
                          width: 5.h,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Main Profile Picture
                          CustomImageView(
                            imagePath: ImageConstant.imgUserImage,
                            height: 84.h,
                            width: 84.h,
                            radius: BorderRadius.circular(42.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Edit Icon
                Positioned(
                  bottom: 8.h,
                  right: 8.h,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2, color: appTheme.whiteA700),
                      color: theme.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add action here
                      },
                      padding: EdgeInsets.all(8.h),
                      icon: CustomImageView(
                        imagePath: ImageConstant.iconPenCil,
                      ),
                      iconSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // User Details
          Padding(
            padding: EdgeInsets.only(left: 16.h, top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: theme.textTheme.headlineSmall,

                ),
                SizedBox(height: 4.h),
                Text(
                  "Last Visit: 17 March 2025",
                  style: CustomTextStyles.labelLargeBluegray400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
