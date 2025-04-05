import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/chat_list_screen/chat_list_screen.dart';
import 'package:amazmart/screens/choose_your_language_screen/choose_your_language_screen.dart';
import 'package:amazmart/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:amazmart/screens/notifications_screen/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_app_settings/flutter_app_settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SharedPreferenceHelper sp = SharedPreferenceHelper();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: buildAppBar(context),
          leadingWidth: double.infinity,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  color: appTheme.whiteA700,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 16, left: 16, bottom: 16),
                          child: Row(
                            children: [
                              CustomImageView(
                                border: sp.getString('image') != null
                                    ? Border.all(color: appTheme.indigo50)
                                    : Border.all(width: 0),
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                radius: BorderRadius.circular(50),
                                imagePath: sp.getString('image') ??
                                    ImageConstant.imageNotFound,
                                height: 45,
                                width: 45,
                              ),
                              Text(
                                sp.getString('displayName') ?? 'guest user',
                                style:
                                    CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        _buildOrderGrid(),
                      ])),
              _buildSection("Account Settings", _buildAccountSettings()),
              _buildSection("My Activity", _buildActivityList()),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a reusable section with a title and content
  Widget _buildSection(String title, Widget content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      color: appTheme.whiteA700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Text(
              title,
              style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 18),
            ),
          ),
          SizedBox(height: 8.h),
          Divider(),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }

  /// Builds the order grid section
  Widget _buildOrderGrid() {
    List<profileGrid> gridList = [
      profileGrid(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.myOrderOngoingScreen);
        },
        title: 'Your Order',
      ),
      profileGrid(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.wishlistPage);
        },
        title: 'Wishlist',
      ),
      profileGrid(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.couponscreen);
        },
        title: 'Coupons',
      ),
      profileGrid(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.myOrderOngoingScreen);
        },
        title: 'Track Order',
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.only(left: 12, right: 12),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 8.h,
        mainAxisSpacing: 8.h,
        childAspectRatio: 4.1, // Control item width/height ratio
      ),
      itemCount: gridList.length,
      itemBuilder: (context, index) {
        var items = gridList[index];
        return GestureDetector(
          onTap: items.onTap,
          child: Container(
            height: 48, // Custom height control
            width: double.infinity,
            decoration: BoxDecoration(
              color: appTheme.gray100,
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(color: appTheme.indigo5001, width: 2),
            ),
            child: Center(child: Text(items.title , style: CustomTextStyles.titleMedium18.copyWith(fontSize: 16),)),
          ),
        );
      },
    );
  }

  /// Builds the account settings list with height control
  Widget _buildAccountSettings() {
    return Column(children: [
      _SettingItem(
        ImageConstant.iconEditProfile,
        'Edit Profile',
        () {
          String? token = sp.getString('token');
          if (token != null) {
            Navigator.of(context, rootNavigator: true).pushReplacement(
              PageRouteBuilder(
                maintainState: true,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EditProfileScreen(),
              ),
            );
          } else {
            ToastMessage.show(context, 'Please Login Accout to ediit Profile');
          }
        },
      ),
      _SettingItem(
        ImageConstant.iconSavedCards,
        'Saved Cards & Wallet',
        () {
          Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.savedcardscreen);

        },
      ),
      _SettingItem(
        ImageConstant.iconSavedAddresses,
        'Saved Addresses',
        () {
          Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.savedaddressscreen);

        },
      ),
      _SettingItem(
        ImageConstant.iconSelectLanguage,
        'Select Language',
        () {
          Navigator.of(context,rootNavigator: true).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => ChooseYourLanguageScreen(value: true,),));

        },
      ),
      // _SettingItem(
      //   ImageConstant.iconNotificationSettings,
      //   'Notification Settings',
      //   () {
      //     // FlutterAppSettings.openNotificationSettings();
      //   },
      // ),
    ]);
  }

  /// Builds the activity list
  Widget _buildActivityList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _SettingItem(
          ImageConstant.iconReview,
          'Reviews',
          () {
          Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.myOrderOngoingScreen);

          },
        ),
        _SettingItem(
          ImageConstant.iconQuestans_icon,
          'Questions & Answers',
          () {
            Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatListScreen(),
            ));
          },
        )
      ],
    );
  }

  Widget _SettingItem(String icon, String title, VoidCallback onTap) {
    return Container(
      height: 40, // Control height of each item
      margin: const EdgeInsets.symmetric(vertical: 4), // Spacing between items
      child: ListTile(
        leading: CustomImageView(
          imagePath: icon,
          height: 24.h,
          width: 24.h,
        ), // Icon size
        title: Text(
          title,
          style: TextStyle(fontSize: 15), // Add custom styling
        ),
        trailing: CustomImageView(
          imagePath: ImageConstant.iconRightArrow,
          height: 16,
          width: 16,
        ), // Arrow icon
        onTap: onTap, // Call the provided function when tapped
      ),
    );
  }

Widget buildAppBar(BuildContext context) {
  return Container(
    height: kToolbarHeight,
    width: double.maxFinite,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        Color(0xFF8AE7ED), // Light blue
        Color(0xFFCDFFF3), // Light green
      ],
    )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: appTheme.gray100,
            borderRadius: BorderRadius.circular(5.h),
          ),
          margin: EdgeInsets.only(left: 12.h, top: 5.h, bottom: 5.h),
          child: IconButton(
            color: appTheme.black900,
            icon: CustomImageView(
              imagePath: ImageConstant.backIcon,
            ),
            onPressed: () {
            Navigator.pop(context);
             
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
              const SizedBox(width: 5),
              Text(
                'angtarang',
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: appTheme.gray100,
            borderRadius: BorderRadius.circular(5.h),
          ),
          margin: EdgeInsets.only(right: 12.h, top: 5.h, bottom: 5.h),
          child: IconButton(
            color: appTheme.black900,
            icon: CustomImageView(
              imagePath: ImageConstant.iconNotification,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NotificationsScreen(),
              ));
            },
          ),
        ),
      ],
    ),
  );
}


}

class profileGrid {
  final String title;
  final VoidCallback onTap;

  profileGrid({required this.title, required this.onTap});
}
