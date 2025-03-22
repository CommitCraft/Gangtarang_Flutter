import 'package:amazmart/api/mySql/card_item.dart';
import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/utils/validation_functions.dart';
import 'package:amazmart/screens/payment_screen/widgets/card_item.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class SavedCardScreen extends StatefulWidget {
  const SavedCardScreen({super.key});

  @override
  State<SavedCardScreen> createState() => _SavedCardScreenState();
}

class _SavedCardScreenState extends State<SavedCardScreen> {
  late SharedPreferenceHelper sp;
  late var dbHelper = DatabaseHelper();
  List<Cards> CardItems = [];
  late bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sp = SharedPreferenceHelper();
    dbHelper = DatabaseHelper();
    fetchCardItems();
  }

  Future<void> fetchCardItems() async {
    final items = await dbHelper.getCardsItems();
    print('getCart Complite${items.length}');
    setState(() {
      CardItems = items;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: CustomAppBar(
          title: 'Saved Cards & Wallet',
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CardItems.isEmpty
                ? Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('No Card'),
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
                                isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: CardItems.length,
                                        itemBuilder: (context, index) {
                                          var item = CardItems[index];
                                          return CreditCard(
                                            cardHolderName: item.name,
                                            cardNo: maskCardNumber(item.cardNo!),
                                            cardExpire: item.expire,
                                            cardType: item.type,
                                          );
                                        },
                                      ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
