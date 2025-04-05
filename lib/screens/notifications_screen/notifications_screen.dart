import 'package:amazmart/screens/notifications_screen/widgets/NotificationslistItemWidget.dart';
import 'package:amazmart/screens/search_screen/search_screen.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          boxDecoration: BoxDecoration(gradient: LinearGradient(colors: [appTheme.cyan200,appTheme.cyan50])),
          title: 'Notifications',
          rightIconPath: ImageConstant.iconSearch,
          rightBtn: true,
          onRightBtnPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchScreen(),
            ));
          },
        ),
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildCategoryRow(context),
                      ListBody(
                        children: List.generate(
                          listOfNotiFication.length,
                          (index) {
                           var i = listOfNotiFication[index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: appTheme.blueGray50,
                                          width: 1))),
                              padding: EdgeInsets.fromLTRB(16, 8, 0, 10),
                              child: NotificationslistItemWidget(imgPath: i.imgPath,title: i.title,subtitle: i.subtitle,),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
 
  }

List<NotificationslistItemWidget> listOfNotiFication = [
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti1,
    title: 'New Arrivals Alert!',
    subtitle: '15 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti2,
    title: 'Flash Sale Starts Now!',
    subtitle: '16 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti3,
    title: 'Limited Time Offer!',
    subtitle: '17 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti4,
    title: 'Weekend Sale Alert!',
    subtitle: '18 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti5,
    title: 'New Product Launch!',
    subtitle: '19 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti6,
    title: 'Exclusive Discount on Orders!',
    subtitle: '20 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti7,
    title: 'Clearance Sale - Up to 70% Off!',
    subtitle: '21 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti8,
    title: 'Holiday Sale Starts Soon!',
    subtitle: '22 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti1,
    title: 'Order Today, Get Free Shipping!',
    subtitle: '23 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti2,
    title: 'Summer Collection is Here!',
    subtitle: '24 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti3,
    title: 'VIP Members Sale!',
    subtitle: '25 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti4,
    title: 'Mid Year Clearance Event!',
    subtitle: '26 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti5,
    title: 'Limited Edition Products Now Available!',
    subtitle: '27 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti6,
    title: 'Pre-Order Your Favorite Items!',
    subtitle: '28 July 2023',
  ),
  NotificationslistItemWidget(
    imgPath: ImageConstant.ImgNoti7,
    title: 'Final Day for Summer Offers!',
    subtitle: '29 July 2023',
  ),
];


  Widget buildCategoryRow(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            topLable('All', null),
            topLable('Offer', ImageConstant.IconOffers),
            topLable('Crazy Deals', ImageConstant.IconFire),
            topLable('Deal of the day', null),
          ],
        ),
      ),
    );
  }

  Widget topLable(String title, String? imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: CustomTextStyles.titleSmallWhiteA700,
          ),
        ),
        imagePath != null
            ? CustomImageView(
                imagePath: imagePath,
                height: 14.h,
                width: 14.h,
                margin: EdgeInsets.only(
                  left: 20.h,
                ),
              )
            : Container(),
      ],
    );
  }
}
