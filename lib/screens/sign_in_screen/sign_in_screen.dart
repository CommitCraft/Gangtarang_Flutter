import 'dart:convert';

import 'package:amazmart/api/config.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/models/userlogin.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:dio/dio.dart';
import '/core/app_export.dart';
import 'package:flutter/material.dart';

final dio = Dio();
TextEditingController _userId = TextEditingController();
TextEditingController _password = TextEditingController();

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isSigninLoad = false;
  @override
  void initState() {
    super.initState();
    _userId = TextEditingController();
    _password = TextEditingController();
  }

  SharedPreferenceHelper sp = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    dio.options = BaseOptions(
      receiveTimeout:
          Duration(seconds: 100), // 10 seconds timeout for receiving data
      connectTimeout: Duration(
          seconds: 100), // 10 seconds timeout for establishing connection
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.OnboardingScreen);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: appTheme.whiteA700,
              elevation: 0,
              leadingWidth: 70,
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: IconButton(
                  icon: CustomImageView(
                    imagePath: ImageConstant.backIcon,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.OnboardingScreen);
                  },
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(imagePath: ImageConstant.imgCart),
                  SizedBox(width: 5),
                  Text(
                    'Gangtarang',
                    style: TextStyle(
                        fontFamily: 'Noto',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.homeScreen);
                  },
                  child: Text('Skip',
                      style:
                          TextStyle(fontSize: 16, color: theme.primaryColor)),
                ),
              ],
            ),
            backgroundColor: appTheme.whiteA700,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In To Your Account',
                            style: CustomTextStyles.titleLargeJostErrorContainer
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Welcome Back You\'ve Been Missed!',
                            style: TextStyle(
                                fontSize: 15, color: appTheme.gray400),
                          ),
                          SizedBox(height: 20),
                          CustomInputField(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            labelText: 'Enter Mobile number or email*',
                            controller: _userId,
                            hintText: 'info@example.com',
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomInputField(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            controller: _password,
                            labelText: 'Enter your password*',
                            hintText: '***********',
                            obscureText: true,
                            textInputType: TextInputType.visiblePassword,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: theme.primaryColor))),
                              padding: EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.forgotPasswordScreen);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 44),
                      !isSigninLoad
                          ? SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _siginIn,
                                style: CustomButtonStyles.fillAmber,
                                child: Text('Sign In',
                                    style: CustomTextStyles
                                        .titleMediumErrorContainer
                                        .copyWith(fontSize: 16)),
                              ),
                            )
                          : SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: CustomImageView(
                              imagePath: ImageConstant.GoogleIcon,
                              width: 20,
                              height: 20),
                          label: Text('Sign in with Google',
                              style: CustomTextStyles.titleMediumErrorContainer
                                  .copyWith(fontSize: 16)),
                          style: CustomButtonStyles.fillBlueGray,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: CustomImageView(
                                imagePath: ImageConstant.AppleIcon,
                                width: 20,
                                height: 20),
                            label: Text(
                              'Sign in with Apple',
                              style: CustomTextStyles.titleMediumErrorContainer
                                  .copyWith(fontSize: 16),
                            ),
                            style: CustomButtonStyles.fillBlueGray,
                          )),
                      // SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member?',
                              style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.signUpScreen);
                            },
                            child: Text('Create an account',
                                style: TextStyle(
                                    fontSize: 16, color: theme.primaryColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _siginIn() async {
    String userId = _userId.value.text;
    String password = _password.value.text;
    if (password.isNotEmpty && userId.isNotEmpty) {
      final loginData = UserLogin(username: userId, password: password);

      print("Sharedprefrence: " + sp.getString('token').toString());

      sp.saveString('userid', userId);

      try {
        setState(() {
          isSigninLoad = true;
        });

        final response = await dio.post(
          Config.loginEndpoint,
          data: loginData.toJson(),
          options: Options(
            headers: {
              'Authorization': '',
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          setState(() {
            isSigninLoad = false;
          });
          print('User Signin successfully: ${response}');
          sp.saveString('res', '$response');
          Map<String, dynamic> resData = jsonDecode('${response}');
          if (resData['success'].toString() == 'true') {
            Map<String, dynamic> data = resData['data'];
            // ToastMessage.show(context, resData.toString());
            setState(() {
              isSigninLoad = false;
            });
            if (data.isNotEmpty) {
              var item = data;
              sp.saveString('token', item['token'].toString());
              sp.saveString('id', item['id'].toString());
              sp.saveString('email', item['email'].toString());
              sp.saveString('nicename', item['nicename'].toString());
              sp.saveString('displayName', item['displayName'].toString());

              ToastMessage.show(context, 'welcome back ${item['displayName']}');
              Navigator.pushNamed(context, AppRoutes.homeScreen);
            } else {
              ToastMessage.show(context, 'section not store');
            }
          } else {
            ToastMessage.show(
                context, 'Enter a valid username / emial  & Password');
            Navigator.pushNamed(context, AppRoutes.signInScreen);
          }
        } else {
          print('Failed to register user: ${response.statusCode}');
          ToastMessage.show(context, 'Failed to login user ');
        }

        // print(user);
      } catch (e) {
        setState(() {
          isSigninLoad = false;
        });
        if (e is DioError) {
          // Check if the error is a response error (status code 400 or others)
          if (e.response != null) {
            // You can access the response body here
            Map<String, dynamic> data = jsonDecode('${e.response}');
            ToastMessage.show(context, "${data["message"]} ");
          } else {
            // Handle request error (no response received)
            print('Error: ${e.message}');
          }
        }
      }
    } else {
      ToastMessage.show(context, "Enter valid email & password");
    }
  }
}
