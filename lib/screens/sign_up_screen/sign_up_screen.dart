import 'dart:convert';
import 'package:amazmart/api/config.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/models/user_registration.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/core/utils/validation_functions.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();
String username = Config.username; // Replace with your admin username
String password = Config.password; // Replace with your admin password
String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  TextEditingController _countryCode = TextEditingController();
  TextEditingController _phoneno = TextEditingController();
  TextEditingController _emailId = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  Country? selectedCountry;
  bool isSignUpLoad = false;

  List<Country> countries = [
    Country(
        name: 'India',
        code: '+91',
        flag: ImageConstant.flag_hindi,
        selected: true),
    Country(
        name: 'United Kingdom',
        code: '+44',
        flag: ImageConstant.flag_French,
        selected: false),
    Country(
        name: 'United States',
        code: '+1',
        flag: ImageConstant.flag_japanese,
        selected: false),
    // Add more countries as needed
  ];

  @override
  void initState() {
    super.initState();
    _countryCode = TextEditingController();
    _phoneno = TextEditingController();
    _emailId = TextEditingController();
    _name = TextEditingController();
    _password = TextEditingController();

    selectedCountry = countries[0];
    _countryCode.text = selectedCountry!.code;
  }

  void onCountrySelecte() {
    showModalBottomSheet(
        // isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return BottomSheetCountrySelecteWidget();
        });
  }

  void _SignUpProgress() async {
    // _emailId.text;
    String countryCode = _countryCode.value.text;
    String phoneno = _phoneno.value.text;
    String email = _emailId.value.text;
    String name = _name.value.text;
    String password = _password.value.text;
    if (countryCode.isNotEmpty) {
      if (phoneno.isNotEmpty && phoneno.length == 10) {
        if (email.isNotEmpty && isValidEmail(email)) {
          if (name.isNotEmpty && name.length >= 3) {
            if (password.isNotEmpty && password.length >= 5) {
              if (isChecked) {
                final user = UserRegistration(
                  username: email.split('@').first,
                  email: email,
                  password: password,
                  firstName: name.split(' ').first,
                  lastName: name.split(' ').first,
                  displayName: name,
                );

                try {
                  setState(() {
                    isSignUpLoad = true;
                  });
                  final response = await dio.post(
                    Config.registerEndpoint,
                    data: user.toJson(),
                    options: Options(
                      headers: {
                        'Authorization': basicAuth,
                        'Content-Type': 'application/json',
                      },
                    ),
                  );

                  if (response.statusCode == 201) {
                     setState(() {
                    isSignUpLoad = false;
                  });
                    ToastMessage.show(context, 'User registered successfully');
                    print('User registered successfully: ${response.data}');
                    Navigator.pushNamed(context, AppRoutes.signInScreen);
                  } else {
                    print('Failed to register user: ${response.statusCode}');
                    ToastMessage.show(context, 'Failed to register user');
                  }

                  // print(user);
                } catch (e) {
                  setState(() {
                    isSignUpLoad = false;
                  });
                  if (e is DioError) {
                    if (e.response != null) {
                      print('Error Response Body: ${e.response}');

                      Map<String, dynamic> res = json.decode('${e.response}');
                      String message = res['message'];
                      ToastMessage.show(context, message);
                      print('Error Status Code: ${e.response?.statusCode}');
                    } else {
                      print('Error: ${e.message}');
                    }
                  }
                }
              } else {
                ToastMessage.show(context, 'Check box ');
              }
            } else {
              ToastMessage.show(context, 'Enter passwword');
            }
          } else {
            ToastMessage.show(context, 'Enter Name');
          }
          // print(_emailId.value.text);
        } else {
          ToastMessage.show(context, 'Enter valid email');
        }
      } else {
        ToastMessage.show(context, 'Enter a Valid No');
      }
    } else {
      ToastMessage.show(context, 'Country Code Enter');
    }
  }

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
          backgroundColor: appTheme.whiteA700,
          body: Column(
            children: [
              // top bar container
              Container(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: appTheme.gray100,
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      margin:
                          EdgeInsets.only(left: 12.h, top: 5.h, bottom: 5.h),
                      child: IconButton(
                        color: appTheme.black900,
                        icon: CustomImageView(
                          imagePath: ImageConstant.backIcon,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.OnboardingScreen);
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgCart,
                            width: 28,
                            height: 24,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Gangtarang',
                            style: TextStyle(
                        fontFamily: 'Noto',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeScreen);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 14.fSize,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).dividerTheme.color,
                thickness: 1,
              ),
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Create Account Title
                            Text(
                              'Create Your Account',
                              style:
                                  CustomTextStyles.titleLargeJostErrorContainer
                                .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Welcome Back! You’ve Been Missed!',
                              style: TextStyle(
                                  fontSize: 15, color: appTheme.gray400),
                            ),
                            // Mobile Number
                            SizedBox(height: 15),

                            Stack(
                              children: [
                                Positioned(
                                    top: -5,
                                    child: Text(
                                      'Enter Mobile Number*',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomInputField(
                                        margin: EdgeInsets.only(top: 1),
                                        controller: _countryCode,
                                        textInputType: TextInputType.number,
                                        hintText: selectedCountry!.code,
                                        // label: Text('+91',),
                                        // labelText: "Enter Mobile Number*",
                                        prefixIcon: GestureDetector(
                                          onTap: onCountrySelecte,
                                          child: CustomImageView(
                                            imagePath: selectedCountry!.flag,
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10, left: 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: CustomInputField(
                                          margin: EdgeInsets.only(top: 17),
                                          controller: _phoneno,
                                          maxLength: 10,
                                          textInputType: TextInputType.number,
                                          hintText: 'Mobile Number',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            CustomInputField(
                              controller: _emailId,
                              margin: EdgeInsets.all(0),
                              textInputType: TextInputType.emailAddress,
                              hintText: 'Email Id',
                              labelText: 'Enter Email Id*',
                            ),

                            // Name
                            CustomInputField(
                              margin: EdgeInsets.all(0),
                              controller: _name,
                              labelText: 'Name*',
                              hintText: 'Name',
                            ),

                            // Password

                            CustomInputField(
                              margin: EdgeInsets.all(0),
                              controller: _password,
                              labelText: 'Password*',
                              hintText: 'Password',
                              obscureText: true,
                            ),

                            CheckboxListTile(
                              checkColor: appTheme.black900,
                              activeColor: Theme.of(context).primaryColor,
                              value: isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              },
                              title: Text(
                                  "I agree to all Terms, Privacy and Fees"),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ],
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
                    // Sign Up Button
                    SizedBox(height: 15),

                    !isSignUpLoad
                        ? SizedBox(height: 48 ,child: ElevatedButton(
                            onPressed: () {
                              _SignUpProgress();
                            },
                            style: CustomButtonStyles.fillAmber,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: appTheme.black900,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                        : SizedBox(height: 25, width: 25, child: CircularProgressIndicator(),), // Already have an account
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.signInScreen);
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BottomSheetCountrySelecteWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: List.generate(
          countries.length,
          (index) {
            var i = countries[index];
            return CountrySelecteItem(i.name, i.flag, () {
              for (var c in countries) {
                setState(() {
                  c.selected = false;
                });
              }
              setState(() {
                i.selected = true;
                selectedCountry = i;
                _countryCode.text = selectedCountry!.code;
              });
              Navigator.pop(context);
            }, i.selected);
          },
        ),
      ),
    );
  }

  Widget CountrySelecteItem(
      String title, String icon, VoidCallback ontap, bool selected) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: ontap,
              label: Text(
                title,
                style: CustomTextStyles.titleMediumErrorContainer,
                textAlign: TextAlign.left,
              ),
              icon: CustomImageView(imagePath: icon),
              iconAlignment: IconAlignment.start,
            ),
            CustomImageView(
              imagePath: selected
                  ? ImageConstant.iconSelect
                  : ImageConstant.iconUnSelect,
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
      ),
    );
  }
}

class Country {
  final String name;
  final String code;
  final String flag;
  late bool selected;

  Country(
      {required this.name,
      required this.code,
      required this.flag,
      required this.selected});
}
