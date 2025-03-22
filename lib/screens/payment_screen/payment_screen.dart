import 'package:amazmart/api/mySql/card_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/core/utils/validation_functions.dart';
import 'package:amazmart/screens/add_card_screen/add_card_screen.dart';
import 'package:amazmart/screens/checkout_screen/checkout_screen.dart';
import 'package:amazmart/screens/delivery_address_screen/delivery_address_screen.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/payment_screen/widgets/card_item.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  DatabaseHelper db = DatabaseHelper();
  List<Cards> cardList = [];
  bool isCardLoading = true;
  String paymentMethod = '';
  String paymentMethodTitle = '';
  bool selecteCod = false;
  bool selecteUpi = false;
  bool selecteWalt = false;
  bool selecteNetB = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
    fetchCardItems();
  }

  void fetchCardItems() {
    db.getCardsItems().then(
      (value) {
        setState(() {
          cardList = value;
          isCardLoading = true;
        });
      },
    ).onError(
      (error, stackTrace) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DeliveryAddressScreen(),
            ));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: 'Payment'),
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
                      buildProgressSteps(context),
                      Container(
                        height: 8,
                        color: appTheme.blueGray50,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 14, top: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Credit/Debit Card',
                                style:
                                    CustomTextStyles.titleMediumErrorContainer,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            AddCardScreen(),
                                      ));
                                    },
                                    label: Text("Add Card"),
                                    icon: CustomImageView(
                                        imagePath:
                                            ImageConstant.iconPlusCircel)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      _CardItemWidget(context),
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                      _paymentSelect(
                        ImageConstant.iconDollar,
                        selecteCod,
                        'Cash On Delivery (Cash/UPI)',
                        () {
                          setState(() {
                            selecteCod = !selecteCod;
                            selecteUpi = false;
                            selecteWalt = false;
                            selecteNetB = false;
                            paymentMethod = 'Cash On Delivery (Cash/UPI)';
                          });
                        },
                      ),
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                      _paymentOption(_googleUpi(), ImageConstant.iconGoogleUpi,
                          'Google Pay/Phone Pay/BHIM UPI',selecteUpi , () {
                        setState(() {
                          selecteUpi = !selecteUpi;
                            selecteCod = false;
                            selecteWalt = false;
                            selecteNetB = false;
                          paymentMethod = 'Google Pay/Phone Pay/BHIM UPI';
                        });
                      }),
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                      _paymentOption(_wallet(), ImageConstant.iconGoogleUpi,
                          'Payments/Wallet',selecteWalt , () {
                        setState(() {
                          selecteWalt = !selecteWalt;
                            selecteCod = false;
                            selecteUpi = false;
                            selecteNetB = false;
                          paymentMethod = 'Payments/Wallet';
                        });
                      }),
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                      _paymentSelect(
                          ImageConstant.iconNetBanking, selecteNetB, 'Netbanking',
                          () {
                        setState(() {
                          selecteNetB = !selecteNetB;
                           selecteCod = false;
                            selecteUpi = false;
                            selecteWalt = false;
                          paymentMethod = 'Netbanking';
                        });
                      }),
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CheckoutScreen(
                          paymentTitle: paymentMethod,
                        ),
                      ));
                    },
                    child: Text('Continue',
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
              color: appTheme.amber400,
              indent: 7.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 8.h),
            decoration: BoxDecoration(
              color: appTheme.amber400,
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
              color: appTheme.amber400,
              indent: 8.h,
            ),
          ),
          Container(
            width: 18.h,
            height: 18.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.amber400,
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

  Widget _CardItemWidget(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: isLoading
              ? []
              : List.generate(
                  cardList.length,
                  (index) {
                    var item = cardList[index];
                    return CreditCard(
                      cardHolderName: item.name,
                      cardNo: maskCardNumber(item.cardNo!),
                      cardExpire: item.expire,
                      cardType: item.type,
                    );
                  },
                ),
        ));
  }

  Widget _paymentOption(
      Widget child, String icon, String title ,bool selecte, VoidCallback onTap) {
    return Column(
      children: [
        _paymentSelect(icon, selecte, title, onTap),
        Divider(),
        SizedBox(
          height: 20,
        ),
        child,
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _paymentSelect(
      String icon, bool selected, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: onTap,
              label: Text(
                title,
                style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 14),
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

  Widget _googleUpi() {
    return Column(
      children: [
        CustomInputField(
          hintText: 'Link upi',
        ),
        Container(
          padding: EdgeInsets.only(right: 16, left: 16, top: 10),
          child: SizedBox(height: 48, child: ElevatedButton(
            onPressed: () {},
            child: Text("Continue",
                style: CustomTextStyles.titleMediumErrorContainer),
            style: CustomButtonStyles.fillAmber,
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
                margin: EdgeInsets.only(left: 10, right: 10),
                imagePath: ImageConstant.iconSecuricon),
            Expanded(
              child: Text(
                'Your UPI ID Will be encrypted and is 100% safe with us.',
                textAlign: TextAlign.left,
                style: CustomTextStyles.bodyMediumOnPrimary14.copyWith(fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _wallet() {
    return Column(
      children: [
        CustomInputField(
          labelText: 'Link Your Wallet',
          prefix: Text('+91 '),
          textInputType: TextInputType.number,
        ),
        Container(
          padding:  EdgeInsets.only(right: 16, left: 16, top: 10),
          child:SizedBox(height: 48, child: ElevatedButton(
            onPressed: () {},
            child: Text("Continue",
                style: CustomTextStyles.titleMediumErrorContainer),
            style: CustomButtonStyles.fillAmber,
          )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
