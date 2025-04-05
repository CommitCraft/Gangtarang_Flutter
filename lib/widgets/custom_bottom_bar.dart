import 'package:flutter/material.dart';
import '../core/app_export.dart';

enum BottomBarEnum {
  vectoronprimary20x20,
  heart81onerror,
  cartonerror,
  grid,
  lock,



}

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.navHome,
      activeIcon: ImageConstant.navHome,
      type: BottomBarEnum.vectoronprimary20x20,
    ),
    BottomMenuModel(
      icon: ImageConstant.IconMenuProducts,
      activeIcon: ImageConstant.IconMenuProducts,
      type: BottomBarEnum.cartonerror,
    ),
    // BottomMenuModel(
    //   icon: ImageConstant.navWishlist,
    //   activeIcon: ImageConstant.navWishlist,
    //   type: BottomBarEnum.heart81onerror,
    // ),

    BottomMenuModel(
      icon: ImageConstant.navMore,
      activeIcon: ImageConstant.navMore,
      type: BottomBarEnum.grid,
    ),
    BottomMenuModel(
      icon: ImageConstant.navCart,
      activeIcon: ImageConstant.navCart,
      type: BottomBarEnum.cartonerror,
    ),
    // BottomMenuModel(
    //   icon: ImageConstant.navProfile,
    //   activeIcon: ImageConstant.navProfile,
    //   type: BottomBarEnum.lock,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: Color(0XFFDFE7F4),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0X33708990),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(
                  0,
                  6,
                ),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 20.h,
                  width: 22.h,
                  color: appTheme.gray400
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 20.h,
                    width: 22.h,
                    color: appTheme.black900,
                  ),
                ),
                label: '',
              );
            }),
            onTap: (index) {
              selectedIndex = index;
              widget.onChanged?.call(bottomMenuList[index].type);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;
  String activeIcon;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
