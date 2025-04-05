import 'package:amazmart/screens/enter_code_otp_screen/enter_code_otp_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/app_export.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailId = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailId = TextEditingController();
  }

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
          actions: [Padding(padding: EdgeInsets.all(16))],
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot Password',
                        textAlign: TextAlign.left,
                         style: CustomTextStyles.titleLargeJostErrorContainer
                                .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter the email associated with your account and we’ll \n send and email to reset your password',
                        style: TextStyle(
                                  fontSize: 15, color: appTheme.gray400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputField(
                      controller: _emailId,
                      labelText: 'Enter Emali Address',
                      hintText: 'info@gmail.com',
                    )
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
                            EnterCodeOtpScreen(
                              enterEmail: _emailId.text,
                            )));
                  },
                  child: Text('Sent Otp',
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
