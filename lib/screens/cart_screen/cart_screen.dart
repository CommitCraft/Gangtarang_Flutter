import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/cart_screen/widgets/product_list_item_widget.dart';
import 'package:amazmart/screens/delivery_address_screen/delivery_address_screen.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/home_screen/home_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
      String currencySymbol = '\$';
  List<CartItem> cartItems = [];
  late var dbHelper =
      DatabaseHelper(); // webpage not work mysql so build app in android | ios
  late bool isLoading = true;
  int? badgeCount;

  @override
  void initState() {
    super.initState();
      SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
    dbHelper = DatabaseHelper();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    print('getCart');
    final items = await dbHelper.getCartItems();
    print('getCart Complete${items.length}');
    setState(() {
      cartItems = items;
      badgeCount = items.length;
      isLoading = false;
    });
  }

  Future<void> addCartItem(CartItem cartItem) async {
    await dbHelper.insertCartItem(cartItem);
    fetchCartItems();
  }

  Future<void> updateCartItemCount(String productId, int newCount) async {
    await dbHelper.updateCartItem(productId, newCount);
    fetchCartItems();
  }

  Future<void> RemoveCartItem(
    String productId,
  ) async {
    await dbHelper.removeCartItem(productId);
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        ));
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: CustomAppBar(
          boxDecoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [appTheme.cyan200, appTheme.cyan50])),
          title: 'Shopping Cart',
          rightBtn: true,
          rightIconPath: ImageConstant.navCart,
          showBadge: true,
          badgeCount: badgeCount ?? 0,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : cartItems.isEmpty
                ? Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                          'Cart is Empty Please add Product In Cart to View'),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                buildProgressSteps(context),
                                isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cartItems.length,
                                        itemBuilder: (context, index) {
                                          var e = cartItems[index];
                                          return ProductlistItemWidget(
                                            product: e,
                                            initialQuantity: e.itemCount,
                                            onQuantityChange:
                                                (productId, newQuantity) {
                                              updateCartItemCount(
                                                  productId, newQuantity);
                                              print(
                                                  "Product $productId quantity changed to $newQuantity");
                                            },
                                            onSaveForLater: (productId) {
                                              RemoveCartItem(productId);

                                              print(
                                                  "Saved product $productId for later");
                                            },
                                            onRemove: (productId) {
                                              print(
                                                  "Removed product $productId");
                                              RemoveCartItem(productId);
                                            },
                                            onBodyClick: (productId) {
                                              print(
                                                  "Clicked on product $productId");
                                            },
                                          );
                                        },
                                      ),
                               
                                buildPriceDetailsSection(context),
                      Container(color: appTheme.indigo50, height: 10,),

                              ],
                            ),
                          ),
                        ),
                      ),
                      buildCheckoutSection(context)
                    ],
                  ),
      )),
    );
  }

  Widget buildProgressSteps(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      height: 40.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 2.h),
            decoration: BoxDecoration(
              color: appTheme.amber400,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "1",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "Cart",
              style: CustomTextStyles.labelLargeWhiteA70013,
            ),
          ),
          Expanded(
            child: Divider(
              color: appTheme.whiteA700.withOpacity(0.3),
              indent: 7.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 8.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "2",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "Address",
              style: CustomTextStyles.labelLargeWhiteA70013,
            ),
          ),
          Expanded(
            child: Divider(
              color: appTheme.whiteA700.withOpacity(0.3),
              indent: 8.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "3",
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                "Payment",
                style: CustomTextStyles.labelLargeWhiteA70013,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPriceDetailsSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 14.h),
              child: Text(
                "Price Details",
                style: CustomTextStyles.titleMediumErrorContainer,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Divider(),
          SizedBox(height: 10.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 14.h),
            child: Column(
              children: [
                buildTotalAmountRow(context,
                    totalAmountText:
                        "Price (${cartItems.length} Items)",
                    priceText:
                        "$currencySymbol${getItemPrice().regularPrice}",
                    priceTextColor: appTheme.black900),
                    SizedBox(height: 2,),

                buildTotalAmountRow(context,
                    totalAmountText:
                        "Discount",
                    priceText:
                        "$currencySymbol${getItemPrice().discountPrice}",
                    priceTextColor: appTheme.black900),
                    SizedBox(height: 2,),
                buildTotalAmountRow(context,
                    totalAmountText:
                        "Delivery Charges",
                    priceText:
                        "Free Delivery",
                    priceTextColor: null),

              ],
            ),
          ),
          SizedBox(height: 18.h),
          Divider(),
          SizedBox(height: 18.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 14.h),
            child: buildTotalAmountRow(context,
                totalAmountText: "Total Amount",
                priceText: "$currencySymbol${getItemPrice().salePrice}",
                priceTextColor: null),
          ),
          SizedBox(height: 10.h),
          

        ],
      ),
    );
  }

  Widget buildProceedToBuyButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 14.h,
        right: 14.h,
        bottom: 14.h,
      ),
      child: SizedBox(height: 48, child: ElevatedButton(
        style: CustomButtonStyles.fillOrangeA,
        onPressed: () {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DeliveryAddressScreen(),
          ));
        },
        child: Text('Proceed to Buy',
            style: CustomTextStyles.titleMediumErrorContainer),
      ),),
    );
  }

  Widget buildCheckoutSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray400.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          buildProceedToBuyButton(context),
        ],
      ),
    );
  }

  Widget buildTotalAmountRow(
    BuildContext context, {
    required String totalAmountText,
    required String priceText,
    required Color? priceTextColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 0.h),
          child: Text(
            totalAmountText,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            priceText,
            style: CustomTextStyles.titleMediumGreen700.copyWith(
              color: priceTextColor ?? appTheme.green700,
            ),
          ),
        ),
      ],
    );
  }

  priceDetail getItemPrice() {
    double priceSale = 0;
    double priceRagular = 0;

    for (var i in cartItems) {
      priceSale += i.salePrice * i.itemCount;
      priceRagular += i.regularPrice * i.itemCount;
    }
    String pri = '$priceRagular  ${priceRagular - priceSale}  ${priceSale}';
    print(pri);
    priceDetail detail = priceDetail();
    detail.regularPrice = '$priceRagular';
    detail.salePrice = '$priceSale';
    detail.discountPrice = '${priceRagular - priceSale}';
    return detail;
  }
}

class priceDetail {
  late String salePrice;
  late String regularPrice;
  late String discountPrice;
}
