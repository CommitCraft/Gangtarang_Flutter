import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/delivery_address_screen/delivery_address_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/core/app_export.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({super.key});

  @override
  State<AddDeliveryAddressScreen> createState() =>
      _AddDeliveryAddressScreenState();
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  DatabaseHelper db = DatabaseHelper();
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _address1 = TextEditingController();
  TextEditingController _localityTown = TextEditingController();
  TextEditingController _cityDistrict = TextEditingController();
  TextEditingController _state = TextEditingController();
  late String _type = 'Home';
  late String _ids = '0';
  int AddressTypeSelected = 0;

  @override
  void initState(){
    super.initState();
    _name = TextEditingController();
    _mobile = TextEditingController();
    _pincode = TextEditingController();
    _address1 = TextEditingController();
    _localityTown = TextEditingController();
    _cityDistrict = TextEditingController();
    _state = TextEditingController();
    db = DatabaseHelper();

    fetchIds();


  }
   
   void fetchIds(){
     try {
      db.getAddressItems().then((value) {
        setState(() {
          _ids = value.length.toString();
        });
      },);
    } catch (e) {
      print('ids Error$e');
    }
   }


  void saveAddress() {
    String name = _name.text;
    String mobile = _mobile.text;
    String pincode = _pincode.text;
    String address1 = _address1.text;
    String localityTown = _localityTown.text;
    String cityDistrict = _cityDistrict.text;
    String state = _state.text;
    int addressSelected = 0;

    Address address = Address(
        id: _ids,
        name: name,
        mobile: mobile,
        pincode: pincode,
        address: address1,
        localityTown: localityTown,
        cityDistrict: cityDistrict,
        state: state,
        type: _type,
        addressSelected: addressSelected);

    try {
      db.insertAddressItem(address);
      ToastMessage.show(context, 'Save Address Successfully');
      Navigator.pop(context);
    } catch (e) {
      print('error$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => DeliveryAddressScreen(),));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: 'Add delivery address'),
          backgroundColor: appTheme.whiteA700,
          body: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        color: appTheme.blueGray50,
                      ),

                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.h),
                        child: Align(
                          child: Text(
                            'Contact Details',
                            style: CustomTextStyles.titleMediumErrorContainer,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Divider(),
                      SizedBox(height: 8.h),
                      CustomInputField(
                        labelText: 'Full Name',
                        controller: _name,
                      ),
                      CustomInputField(
                        labelText: 'Mobile No.',
                        textInputType: TextInputType.number,
                        controller: _mobile,
                      ),

                      //address sec.
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 14, top: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address',
                            style: CustomTextStyles.titleMediumErrorContainer,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Divider(),
                      SizedBox(height: 8.h),
                      CustomInputField(
                        textInputType: TextInputType.number,
                        labelText: 'Pin Code',
                        controller: _pincode,
                      ),
                      CustomInputField(
                        labelText: 'Address',
                        controller: _address1,
                      ),
                      CustomInputField(
                        labelText: 'Locality/Town',
                        controller: _localityTown,
                      ),
                      CustomInputField(
                        labelText: 'City/District',
                        controller: _cityDistrict,
                      ),
                      CustomInputField(
                        labelText: 'State',
                        controller: _state,
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 10,
                        color: appTheme.blueGray50,
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 14, top: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address',
                            style: CustomTextStyles.titleMediumErrorContainer,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Divider(),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          _typeSelected(
                            context,
                            'Home',
                            1,
                            () {
                              setState(
                                () {
                                  AddressTypeSelected = 1;
                                  _type = 'Home';
                                },
                              );
                            },
                          ),
                          _typeSelected(context, 'Office', 2, () {
                            setState(
                              () {
                                AddressTypeSelected = 2;
                                _type = 'Office';
                              },
                            );
                          }),
                          _typeSelected(context, 'Shop', 3, () {
                            setState(
                              () {
                                AddressTypeSelected = 3;
                                _type = 'Shop';
                              },
                            );
                          }),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 10,
                        color: appTheme.blueGray50,
                      ),
                    ],
                  ),
                )),
                Container(
                  color: appTheme.whiteA700,
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: SizedBox(height: 48, child: ElevatedButton(
                    style: CustomButtonStyles.fillPrimary1,
                    onPressed: saveAddress,
                    child: Text('Save Address',
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

  Widget _typeSelected(
      BuildContext context, String Title, int selected, VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: OutlinedButton(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(50, 60)),
          backgroundColor: AddressTypeSelected == selected
              ? WidgetStatePropertyAll(theme.primaryColor)
              : WidgetStatePropertyAll(appTheme.indigo50),
        ),
        onPressed: onTap,
        child: Text(
          Title,
          style: CustomTextStyles.titleMediumErrorContainer,
        ),
      ),
    );
  }
}
