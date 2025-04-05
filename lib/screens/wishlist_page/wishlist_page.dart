import 'dart:convert';

import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/api/wishlist_model.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/wishlist_page/widgets/product_wishlist_item_widget.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../api/mySql/cart_item.dart';
import '../../core/app_export.dart';
import 'package:amazmart/api/WooCommerceApi.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool isLoading = true;
  List<WishlistResponse> wishlistList = [];
  List<Product> product = [];
  late WooCommerceApi wooCommerceApi;
  final SharedPreferenceHelper sp = SharedPreferenceHelper();
  late bool userAuth = false;
  late String token;
  late DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    String? tempToken = sp.getString('token');
    token = tempToken ?? "";
    // print(token);
    wooCommerceApi = WooCommerceApi(WooCommerceApi.WishlistDio(token));
    db = DatabaseHelper();
    fatchWishlist();
  }

  void fatchWishlist() async {
    try {
      final fatchedWishlist = await wooCommerceApi.getWishlistList();
      setState(() {
        wishlistList = fatchedWishlist;
        print('aaaaaaabb $wishlistList');
        product = wishlistList.isNotEmpty ? wishlistList.first.product ?? [] : [];
        isLoading = false;
        userAuth = true;
      });
    } on DioException catch (e) {
      print('wishlist Error ${e.response}');
      print('wishlist header ${e.response!.headers}');
      if (e.response != null) {
        Map<String, dynamic> data = jsonDecode('${e.response}');
        if (data['code']! == "unauthorized") {
          setState(() {
            userAuth = false;
            isLoading = false;
          });
          print(token == null
              ? "please login  to view wishlist here"
              : "wishlist user token is expire user login anather divice");
        } else {
          print("wishlist user valid");
        }
      }
    }
    print('wishlist Response ${wishlistList.length}');
  }

  Future<void> addCartItem(CartItem cartItem) async {
    await db.insertCartItem(cartItem);
  }

  deleteWishlist(int wId, int pId) async {
    try {
      String _values = await wooCommerceApi.removeWishlist(wId, pId);
      ToastMessage.show(context, 'Wishlist Remove Successful');
      fatchWishlist();
      print('ResponnseForwishlistRemove ${_values}');
    } on DioException catch (e) {
      print(e.response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: AppBar(
          leading: _buildAppBar(context),
          leadingWidth: double.infinity,
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 8.h,
            top: 6.h,
            right: 8.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildProductGrid(context),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border( bottom: BorderSide(color: appTheme.indigo50)),
        color: appTheme.whiteA700, // Light blue
        // Light green
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Text(
                  'My Wishlist',
                  style: theme.textTheme.titleMedium,
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
            child: Stack(
              children: [
                IconButton(
                  color: appTheme.black900,
                  icon: CustomImageView(
                    imagePath: ImageConstant.navWishlist,
                    height: 14,
                    width: 14,
                    color: appTheme.black900,
                  ),
                  onPressed: () {
                    // _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: appTheme.redA70001),
                      child: Padding(
                        padding: EdgeInsets.only(right: 4, left: 4),
                        child: Text(
                          product.isEmpty ? '0' : '${product.length}',
                          style: CustomTextStyles.bodySmallWhiteA700,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return Expanded(
      child: !isLoading
          ? userAuth
              ? product.isNotEmpty
                  ? ResponsiveGridListBuilder(
                      minItemWidth: 1,
                      minItemsPerRow: 2,
                      maxItemsPerRow: 2,
                      horizontalGridSpacing: 8.h,
                      verticalGridSpacing: 8.h,
                      builder: (context, items) => ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: items,
                      ),
                      gridItems: List.generate(
                        product.length,
                        (index) {
                          var item = product[index];
                          return ProductWishlistItemWidget(
                            productName: item.title,
                            productImage: item.image,
                            productPrice: item.salePrice,
                            productOldPrice: item.regularPrice,
                            reviewCount: item.ratingCount,
                            rating : item.averageRating,
                            productDiscount: calculateDiscount(
                                    parseDouble(item.regularPrice),
                                    parseDouble(item.salePrice))
                                .toString(),
                            onTrashClick: () {
                              deleteWishlist(wishlistList[0].wishlist.id,
                                  int.parse(item.id));
                            },
                            onAddToCartClick: () {
                              addCartItem(CartItem(
                                  productId: item.id,
                                  productName: item.title,
                                  productImage: item.image,
                                  rating: item.averageRating,
                                  reviewCount: item.ratingCount,
                                  salePrice: int.parse(item.salePrice),
                                  regularPrice: int.parse(item.regularPrice),
                                  discount: calculateDiscount(
                                      parseDouble(item.regularPrice),
                                      parseDouble(item.salePrice)),
                                  returnLabel: 'retrun available',
                                  itemCount: 1));
                              ToastMessage.show(
                                  context, "Product is add in cart View");
                            },
                            onFullViewClick: () {},
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('user wishlist is empty'),
                    )
              : Center(
                  heightFactor: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        token.isNotEmpty
                            ? 'user token expire please re login'
                            : 'Please login to view wishlist',
                        style: CustomTextStyles.labelLargeBlack900,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator(
                              onDidRemovePage: (page) => page.name,
                            );
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(AppRoutes.signInScreen);
                          },
                          child: Text(token.isNotEmpty ? "Relogin" : "Login"),
                          style: CustomButtonStyles.fillOnPrimary,
                        ),
                      ),
                    ],
                  ),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
