import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/screens/delivery_address_screen/widgets/list.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  late DatabaseHelper db = DatabaseHelper();

  late List<Address> addressList = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper();
    fetchAddressList();
  }

  void fetchAddressList() {
    isLoading = true;
    try {
      db.getAddressItems().then(
        (value) {
          print(value);
          var i = value;
          setState(() {
            addressList = i;
            isLoading = false;
          });
        },
      );
    } catch (e) {
      print('Error$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: CustomAppBar(
          title: 'Saved Address',
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : addressList.isEmpty
                ? Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('No Address'),
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
                                        itemCount: addressList.length,
                                        itemBuilder: (context, index) {
                                          var i = addressList[index];
                                          return ListAddressWidget(
                                            address: i,
                                            onTap: () {
                                              setState(() {
                                                for (Address ad
                                                    in addressList) {
                                                  ad.addressSelected = 0;
                                                  db.updateDefaultAddress(
                                                      ad.id, 0);
                                                }
                                                i.addressSelected = 1;
                                                db.updateDefaultAddress(
                                                    i.id, 1);
                                              });
                                            },
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
