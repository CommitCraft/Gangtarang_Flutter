import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({super.key});
  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(
              context, AppRoutes.chooseYourLanguageScreen);
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                                context, AppRoutes.chooseYourLanguageScreen);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.g_logo,
                              width: 28,
                              height: 24,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'angtarang',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          child: Image.asset(ImageConstant.onbgImg),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 16, bottom: 10),
                          child: Text(
                            'Divine Puja Emporium',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28.fSize,
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w600,
                              color: appTheme.black900,
                              height: 1.25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 40, left: 40, top: 0, bottom: 10),
                          child: Text(
                            'Experts in Rudraksha Shaligram Shivling Yantras Shankhs and various spiritual artifacts.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displayMedium?.copyWith(color: Color(0xFF7D899D)),
                          ),
                        ),
                      ]),

                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 16.0),
                          child: Column(
                            children: [
                             SizedBox(height: 48 ,child: ElevatedButton(
                                style: CustomButtonStyles.fillAmber,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.signInScreen);
                                },
                                child: Text(
                                  'Already a customer? Sign In',
                                  style: TextStyle(
                                      fontFamily: 'Jost',
                                      fontSize: 16.h,
                                      color: appTheme.black900,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                              const SizedBox(height: 16),
                             SizedBox(height: 48 ,child: ElevatedButton(
                                style: CustomButtonStyles.fillOnPrimaryTL8,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.signUpScreen);
                                },
                                child: Text(
                                  'Create an account',
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    color: appTheme.whiteA700,
                                    fontSize: 16.h,
                                  ),
                                ),
                              )),
                              const SizedBox(height: 16),
                             SizedBox(height: 48 ,child: ElevatedButton(
                                style: CustomButtonStyles.fillBlueGray,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.homeScreen);
                                },
                                child: Text(
                                  'Skip sign in',
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    color: appTheme.black900,
                                    fontSize: 16.h,
                                  ),
                                ),
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),);
  }
}




// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.whiteA700,
//         body: Column(
//           children: [
//             Container(
//               height: kToolbarHeight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: appTheme.gray100,
//                       borderRadius: BorderRadius.circular(5.h),
//                     ),
//                     margin: EdgeInsets.only(left: 12.h, top: 5.h, bottom: 5.h),
//                     child: IconButton(
//                       color: appTheme.black900,
//                       icon: CustomImageView(
//                         imagePath: ImageConstant.backIcon,
//                       ),
//                       onPressed: () {
//                               Navigator.pushReplacementNamed(context, AppRoutes.chooseYourLanguageScreen);
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomImageView(
//                           imagePath: ImageConstant.imgCart,
//                           width: 28,
//                           height: 24,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           'AmazMart',
//                           style: theme.textTheme.titleLarge,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: TextButton(
//                       onPressed: () {
//                               Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
//                       },
//                       child: Text(
//                         'Skip',
//                         style: TextStyle(
//                           color: theme.primaryColor,
//                           fontSize: 14.fSize,
//                           fontFamily: 'Jost',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//               color: Theme.of(context).dividerTheme.color,
//               thickness: 1,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 465,
//                       child: Image.asset(ImageConstant.onbgImg),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 40,right: 40,top: 16,bottom: 0
//                          ),
//                       child: Text(
//                         'Discovering The World Of Everything',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 28.fSize,
//                           fontFamily: 'Jost',
//                           fontWeight: FontWeight.w700,
//                           color: appTheme.black900,
//                           height: 1.25,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 40,left: 40 ,top: 0,bottom: 10),
//                       child: Text(
//                         'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                         textAlign: TextAlign.center,
//                         style: theme.textTheme.displayMedium,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15.0, vertical: 16.0),
//                       child: Column(
//                         children: [
//                           ElevatedButton(
//                             style: CustomButtonStyles.fillAmber,
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
//                             },
//                             child: Text(
//                               'Already a customer? Sign In',
//                               style: TextStyle(
//                                 fontFamily: 'Jost',
//                                 fontSize: 16.h,
//                                 color: appTheme.black900,
//                                 fontWeight: FontWeight.w400
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             style: CustomButtonStyles.fillOnPrimaryTL8,
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(context, AppRoutes.signUpScreen);
//                             },
//                             child: Text(
//                               'Create an account',
//                               style: TextStyle(
//                                 fontFamily: 'Jost',
//                                 color: appTheme.whiteA700,
//                                 fontSize: 16.h,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             style: CustomButtonStyles.fillBlueGray,
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
//                             },
//                             child: Text(
//                               'Skip sign in',
//                               style: TextStyle(
//                                 fontFamily: 'Jost',
//                                 color: appTheme.black900,
//                                 fontSize: 16.h,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
