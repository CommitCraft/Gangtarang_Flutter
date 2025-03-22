import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/api/system_status/system_status.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/app_export.dart';
import 'package:html/parser.dart'; // For parsing HTML
import 'package:html_unescape/html_unescape.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// SharedPreferenceHelper sp = new SharedPreferenceHelper();

class _SplashScreenState extends State<SplashScreen> {
  late WooCommerceApi wc;
  late SharedPreferenceHelper sp;
  @override
  void initState() {
    wc = WooCommerceApi(WooCommerceApi.createDio());
    sp = new SharedPreferenceHelper();
    super.initState();
    // Set a 1-second delay before navigating to the onboarding screen
    fetchStatus();
    Timer(Duration(seconds: 2), () {
      String? token = sp.getString('token');
      if (token != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } else {
        Navigator.pushReplacementNamed(
            context, AppRoutes.chooseYourLanguageScreen);
      }
    });
   
  }

  void fetchStatus() async {
    try {
      SystemStatus _value = await wc.getSystem_status();
      print('currencySymbol: ${_value.settings!.currencySymbol!}');
      print('currency: ${_value.settings!.currency!}');

      var unescape = HtmlUnescape();
      String output = unescape.convert(_value.settings!.currencySymbol!);
      sp.saveString('currencySymbol', output);
      
      print('Output ER: $output'); // Output: $
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgSplashScreenBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            // Centers the column vertically and horizontally
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgCart,
                      height: 38.h,
                      width: 44.h,
                      margin: EdgeInsets.only(top: 8.h),
                    ),
                    SizedBox(width: 6.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Gangtarang",
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildVersionInfo(context),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              "Version 1.0".toUpperCase(),
              style: CustomTextStyles.labelLargeBlack900,
            ),
          ),
        ],
      ),
    );
  }
}
