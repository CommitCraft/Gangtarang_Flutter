import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/api/orders/billing.dart';
import 'package:amazmart/api/orders/line_item.dart';
import 'package:amazmart/api/orders/orders.dart';
import 'package:amazmart/api/orders/shipping.dart';
import 'package:amazmart/api/orders/shipping_line.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/checkout_screen/widgets/items.dart';
import 'package:amazmart/screens/payment_screen/payment_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class CheckoutScreen extends StatefulWidget {
  String? paymentTitle;
  CheckoutScreen({super.key, this.paymentTitle});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState(paymentTitle);
}

class priceDetail {
  late String salePrice;
  late String regularPrice;
  late String discountPrice;
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late WooCommerceApi wc;
  late DatabaseHelper db;
  late SharedPreferenceHelper sp;
  late List<CartItem> cartItems = [];
  late List<Address> addressItem = [];
  late String addressLable = '';
  late String? paymentLable;
      String currencySymbol = '\$';

  _CheckoutScreenState(String? paymentTitle) {
    paymentLable = paymentTitle;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
    sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
    wc = WooCommerceApi(WooCommerceApi.createDio());
    fetchCardItems();
    print(" fffff pay $paymentLable");
  }

  void fetchCardItems() async {
    List<CartItem> data = await db.getCartItems();
    List<Address> addressData = await db.getAddressItems();
    setState(() {
      cartItems = data;
      addressItem = addressData;
      for (var e in addressData) {
        if (e.addressSelected == 1) {
          addressLable =
              '${e.address}, ${e.localityTown}  ${e.cityDistrict}  ${e.state}  ${e.pincode}';
        }
      }
    });
  }

  void orderSubmit() async {
    List<LineItem> lineItem = [];
    for (var e in cartItems) {
      lineItem.add(LineItem(
          productId: int.parse(e.productId),
          quantity: e.itemCount,
          variationId: int.parse(e.productId)));
    }

    Billing billing = Billing();
    Shipping shipping = Shipping();
    List<ShippingLine> shippingLine = [
      ShippingLine(
          methodId: 'paymentData',
          methodTitle: '',
          total: getItemPrice().salePrice)
    ];
    for (var e in addressItem) {
      if (e.addressSelected == 1) {
        billing = Billing(
            address1: e.address,
            address2: e.localityTown,
            city: e.cityDistrict,
            state: e.state,
            postcode: e.pincode,
            phone: e.mobile,
            firstName: e.name,
            lastName: '',
            country: '',
            email: sp.getString('email'));
        shipping = Shipping(
          firstName: e.name,
          lastName: '',
          country: '',
          address1: e.address,
          address2: e.localityTown,
          city: e.cityDistrict,
          state: e.state,
          postcode: e.pincode,
        );
      }
    }

    Orders orders = Orders(
        customer_id: int.parse(sp.getString('id')!),
        setPaid: false,
        paymentMethod: 'bacs',
        paymentMethodTitle: 'Direct Bank Transfer',
        lineItems: lineItem,
        billing: billing,
        shipping: shipping,
        shippingLines: shippingLine);
    try {
      Orders createOrder = await wc.createOrder(orders);
      print('Order ${createOrder.toJson()}');
      for (var c in cartItems) {
        db.removeCartItem(c.productId);
      }
      ToastMessage.show(context, "Order place Successfully");
      Navigator.of(context).pushNamed(AppRoutes.cartScreen);

    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('Order Errorr ${e.response}');
      } else {
        print('Order Errorr not 400 ${e.response}');
      }
    }


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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PaymentScreen(),
            ));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: 'Checkout'),
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
                      Container(
                        height: 8,
                        color: appTheme.blueGray50,
                      ),
                      CheckoutTitle(
                        title: 'Delivery address',
                        subTitle: addressLable,
                        icon: ImageConstant.iconOffice,
                        onTap: () {},
                      ),
                      CheckoutTitle(
                        title: 'Payment method',
                        subTitle: paymentLable ?? '',
                        icon: ImageConstant.iconSavedCards,
                        onTap: () {},
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(left: 16, top: 14, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Additional Notes:',
                            style: CustomTextStyles.titleLargeJostOnPrimary,
                          )),
                      SizedBox(
                        // height: 150,
                        child: CustomInputField(
                          hintText: 'Write Here',
                          maxLines: 4,
                          textInputType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(height:  15,),

                      Container(color: appTheme.blueGray50,height: 40,),
                      _buildPriceDetailsSection(context),
                       Container(
                        margin: EdgeInsets.only(  top:   10),
                  height: 10,
                  color: appTheme.blueGray50,),

                    ],
                  ),
                )),
                // btn for submit
               
                Container(
                  color: appTheme.whiteA700,
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: SizedBox(height: 48, child: ElevatedButton(
                    style: CustomButtonStyles.fillOrangeA,
                    onPressed: orderSubmit,
                    child: Text('Submit Order',
                        style: CustomTextStyles.titleMediumErrorContainer),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceDetailsSection(BuildContext context) {
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
            child: buildTotalAmountRow(
              context,
              totalAmountText: "Total Amount",
              priceText: "$currencySymbol${getItemPrice().salePrice}",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalAmountRow(BuildContext context,
      {required String totalAmountText, required String priceText , Color? priceTextColor}) {
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
}
