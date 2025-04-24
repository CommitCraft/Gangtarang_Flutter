import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/cart_screen/cart_screen.dart';
import 'package:amazmart/screens/category_page/category_page.dart';
import 'package:amazmart/screens/profile_page/profile_page.dart';
import 'package:amazmart/screens/wishlist_page/wishlist_page.dart';
import 'package:amazmart/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../products_list_screen/products_list_screen.dart';
import 'home_initial_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          decoration: BoxDecoration(
            color: appTheme.blueGray50,
          ),
          child: Column(
            children: [
              Expanded(
                child: Navigator(
                  key: navigatorKey,
                  initialRoute: AppRoutes.homeInitialPage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) {
                      debugPrint("routeSetting.name : ${routeSetting.name} ");
                      return getCurrentPage(routeSetting.name!);
                    },
                    transitionDuration: Duration(seconds: 0),
                  ),
                ),
              ),
              // SizedBox(height: 60.h)
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          debugPrint("Current Route : ${type.name} $type");
          Navigator.pushNamed(
            navigatorKey.currentContext!,
            getCurrentRoute(type),
          );
        },
      ),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    debugPrint("Current Route : ${type.name} $type");
    switch (type) {
      case BottomBarEnum.vectoronprimary20x20:
        return AppRoutes.homeInitialPage;
      case BottomBarEnum.heart81onerror:
        return AppRoutes.wishlistPage;
      case BottomBarEnum.cartonerror:
        return AppRoutes.cartScreen;
      case BottomBarEnum.grid:
        return AppRoutes.categoryPage;
      case BottomBarEnum.products_list: // Add this case for ProductsListScreen
        return AppRoutes
            .productsListScreen; // Assuming you've defined this in AppRoutes
      case BottomBarEnum.lock:
      default:
        return AppRoutes.profilePage;
    }
  }

  Widget getCurrentPage(String currentRoute) {
    debugPrint("currentRoute :::$currentRoute");
    switch (currentRoute) {
      case AppRoutes.homeInitialPage:
        return HomeInitialPage();
      case AppRoutes.wishlistPage:
        return WishlistPage();
      case AppRoutes.categoryPage:
        return CategoryPage();
      case AppRoutes.profilePage:
        return ProfilePage();
      case AppRoutes.cartScreen:
        return CartScreen();
      case AppRoutes.productsListScreen:
        return ProductsListScreen();
      default:
        return DefaultWidget();
    }
  }

  Widget buildDrawer(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.maxFinite,
      color: appTheme.whiteA700,
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
                // _scaffoldKey.currentState?.openDrawer();
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
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
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
    );
  }
}
