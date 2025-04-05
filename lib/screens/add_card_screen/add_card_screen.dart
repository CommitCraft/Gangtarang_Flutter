import 'package:amazmart/api/mySql/card_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/core/utils/validation_functions.dart';
import 'package:amazmart/screens/payment_screen/payment_screen.dart';
import 'package:amazmart/screens/payment_screen/widgets/card_item.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/app_export.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController _cardNo = TextEditingController();
  TextEditingController _cardholderName = TextEditingController();
  TextEditingController _cardExpires = TextEditingController();
  TextEditingController _cardcvv = TextEditingController();
  String? _cardType;
  String? cardholderName;
  String? cardNo;
  String? cardExpire;
  String? cardCvv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
    _cardNo = TextEditingController();
    _cardholderName = TextEditingController();
    _cardExpires = TextEditingController();
    _cardcvv = TextEditingController();
    _cardType;
    cardholderName;
    cardNo;
    cardExpire;
    cardCvv;
  }

  void saveCard() {
    String cName = _cardholderName.text;
    String cNo = _cardNo.text;
    String cExpire = _cardExpires.text;
    String cCvv = _cardcvv.text;
    if (cName.isNotEmpty) {
      if (cNo.isNotEmpty) {
        if (cExpire.isNotEmpty) {
          if (cCvv.isNotEmpty) {
            if (getCardType(cNo) != ImageConstant.imageNotFound) {
              print(
                  "all Done ${getCardType(cNo)}  ${ImageConstant.imageNotFound}");

              db
                  .insertCardItem(Cards(
                      name: cName,
                      cardNo: cNo,
                      expire: cExpire,
                      cvv: cCvv,
                      type: getCardType(cNo),
                      bg: ImageConstant.imgCardBg))
                  .then(
                (value) {
                  // ignore: use_build_context_synchronously
                  ToastMessage.show(context, 'Card data Insert Successfull');
                },
              ).onError(
                (error, stackTrace) {
                  print("Inserts Data Eror $error");
                },
              );
            } else {
              ToastMessage.show(context, 'CardNo Not Valid');
            }
          }
        }
      }
    }
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
          appBar: CustomAppBar(
            title: 'Add Card',
            boxDecoration: BoxDecoration(
              color: Color(0xFFB6F4EE),
            ),
            divider: false,
          ),
          // backgroundColor: appTheme.whiteA700,
          body: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 200,
                              color: Color(0xFFB6F4EE),
                            ),
                            Positioned(
                              left: 0,
                              top: 100,
                              right: 0,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 10,
                              right: 20,
                              bottom: 18,
                              child: CreditCard(
                                cardType: _cardType,
                                padding: EdgeInsets.all(0),
                                cardHolderName: cardholderName ?? null,
                                cardNo: cardNo ?? '**** **** **** 4532',
                                cardExpire: cardExpire ?? null,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: appTheme.whiteA700,
                          child: Column(
                            children: [
                              CustomInputField(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 15),
                                textInputType: TextInputType.name,
                                hintText: 'Card Holder Name',
                                controller: _cardholderName,
                                onChanged: (p0) {
                                  setState(() {
                                    cardholderName = p0;
                                  });
                                },
                              ),
                              CustomInputField(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 15),
                                endIcon: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.h, 14.h, 12.h, 14.h),
                                  child: CustomImageView(
                                    imagePath:
                                        _cardType ?? ImageConstant.isEmpty,
                                    height: 18.h,
                                    width: 20.h,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                controller: _cardNo,
                         
                                hintText: 'Card Number',
                                textInputType: TextInputType.number,
                                onChanged: (p0) {
                                  // _cardNo
                                  setState(() {
                                    cardNo = p0;
                                    _cardType = getCardType(p0);
                                  });
                                  // ToastMessage.show(context, getCardType(p0));
                                },
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomInputField(
                                    controller: _cardExpires,
                                    margin: EdgeInsets.only(left: 16 ,
                                    bottom: 15),
                                    width: 200,
                                    textInputType: TextInputType.number,
                                    hintText: 'Expiry Date',
                                    onChanged: (p0) {
                                      // Check if the user is typing or deleting
                                      if (p0.length == 2 && !p0.contains('/')) {
                                        p0 = '$p0/';
                                      }

                                      setState(() {
                                        cardExpire = p0;
                                        // Update the text field only if it's different
                                        if (_cardExpires.text != cardExpire) {
                                          _cardExpires.value = TextEditingValue(
                                            text: cardExpire!,
                                            selection: TextSelection.collapsed(
                                                offset: cardExpire!.length),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  CustomInputField(
                                    controller: _cardcvv,
                                    margin: EdgeInsets.only(right: 16,bottom: 15),
                                    width: 150,
                                    textInputType: TextInputType.number,
                                    hintText: 'CVV',
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
                // btn for submit
                Container(
                  color: appTheme.whiteA700,
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: SizedBox(height: 48, child: ElevatedButton(
                    style: CustomButtonStyles.fillOrangeA,
                    onPressed: saveCard,
                    child: Text('Save Card',
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
}
