import 'package:amazmart/screens/home_screen/home_screen.dart';
import 'package:amazmart/screens/sign_in_screen/sign_in_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
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
            TextButton(
              onPressed: () {},
              child: Text('Skip',
                  style: TextStyle(fontSize: 16, color: theme.primaryColor)),
            ),
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
                        'Enter New Password',
                        style:  CustomTextStyles.titleLargeJostErrorContainer
                                .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Your new password must be different from previously used password.',
                        style: TextStyle(fontSize: 15, color: appTheme.gray400),
                      ),
                    ),

                    CustomInputField(labelText: 'Password*', hintText: '*********',),
                    CustomInputField(labelText: 'Confirm Password*', hintText: '*********')

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
                          SignInScreen(),
                    ));
                  },
                  child: Text('Continue',
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
