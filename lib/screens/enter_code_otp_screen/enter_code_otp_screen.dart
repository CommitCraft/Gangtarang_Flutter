import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/create_password_screen/create_password_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_pin_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/app_export.dart';

class EnterCodeOtpScreen extends StatefulWidget {
  String? enterEmail;
  EnterCodeOtpScreen({super.key, this.enterEmail});

  @override
  State<EnterCodeOtpScreen> createState() => _EnterCodeOtpScreenState();
}

class _EnterCodeOtpScreenState extends State<EnterCodeOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.whiteA700,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: appTheme.gray100,
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: IconButton(
              icon: CustomImageView(imagePath: ImageConstant.backIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(imagePath: ImageConstant.imgCart),
              SizedBox(width: 5),
              Text(
                'AmazMart',
                style: TextStyle(
                        fontFamily: 'Noto',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Padding(padding: EdgeInsets.all(18)),
          ],
        ),
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16,top: 16),
                      child: Text(
                        'Please enter the OTP sent to',
                        style:  CustomTextStyles.titleLargeJostErrorContainer
                                .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          widget.enterEmail!.isEmpty ? 'null' : widget.enterEmail!,
                          style:
                              TextStyle(fontSize: 15, color: appTheme.gray400),
                        )),
                    SizedBox(height: 10),
                  
                   Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      child:   RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Enter OTP",
                            style: theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: "*",
                            style: CustomTextStyles.titleSmallRedA70001,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0 , 16, 0),
                      width: double.maxFinite,

                      child: CustomPinCodeTextField(
                        context: context,
                        onChanged: (value) {},
                      ),
                    ),
                      Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      child:   RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "If you don’t receive code! ",
                            style: theme.textTheme.titleSmall,
                          ),
                          TextSpan(onEnter: (event) {
                            ToastMessage.show(context, 'Otp Sent Your ${widget.enterEmail} ');
                            // 
                          },
                            text: "Resend",
                            style: CustomTextStyles.titleSmallPrimary,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),),
                  ],
                ),
              )),
              // btn for submit
              Container(
                color: appTheme.whiteA700,
                padding: EdgeInsets.all(
                  16,
                ),
                child: SizedBox(height: 48 ,child: ElevatedButton(
                  style: CustomButtonStyles.fillAmber,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                         CreatePasswordScreen(),
                    ));
                  },
                  child: Text('Verify and proceed',
                      style: CustomTextStyles.titleMediumErrorContainer),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
