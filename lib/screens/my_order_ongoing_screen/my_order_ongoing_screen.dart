import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/response_orderes/response_orderes.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/my_order_ongoing_screen/widgets/order_list_Item_widget.dart';
import 'package:amazmart/screens/track_order_screen/track_order_screen.dart';
import 'package:amazmart/screens/write_review_screen/write_review_screen.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/api/response_order/response_order.dart';
import 'package:flutter/services.dart';

class MyOrderOngoingScreen extends StatefulWidget {
  const MyOrderOngoingScreen({super.key});

  @override
  State<MyOrderOngoingScreen> createState() => _MyOrderOngoingScreenState();
}

class _MyOrderOngoingScreenState extends State<MyOrderOngoingScreen> {
  late WooCommerceApi wc;
  late SharedPreferenceHelper sp;
  late List<ResponseOrderes> OrderList = [];
  bool isOrderLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wc = WooCommerceApi(WooCommerceApi.createDio());
    sp = SharedPreferenceHelper();
    fecthOrerList();
  }

  void fecthOrerList() async {
    int cId = int.parse(sp.getString('id')!);
    try {
      var order = await wc.getOrderList(cId);

      print('Order Length ${order.length}');
      print('Order Length $order');
      //  Clipboard.setData(ClipboardData(text: order));
      setState(() {
        OrderList = order;
        isOrderLoading = false;
      });

      // print('Order map ${order.map(
      //   (e) {
      //     e.lineItems?.first.toJson();
      //   },
      // )}');
    } on DioException catch (e) {
      print('order Error e ${e.response!.redirects}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'My Order',
            boxDecoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [appTheme.cyan200, appTheme.cyan50])),
          ),
          backgroundColor: appTheme.blueGray50,
          body: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildTabview(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 8,
                          color: appTheme.blueGray50,
                        ),
                        isOrderLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: List.generate(
                                  OrderList.length,
                                  (index) {
                                    var i = OrderList[index];
                                    return OrderlistItemWidget(
                                      product: i,
                                      onTrackOrder: (product) {
                                        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => TrackOrderScreen(product: product),));
                                      },
                                      onWriteReview: (product) {
                                        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => WriteReviewScreen(product: product),));
                                      },
                                      onRemove: (product) {},
                                      onBodyClick: (product) {},
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabview(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Distribute tabs evenly
        children: [
          // All Tab
          GestureDetector(
            onTap: () {
              // Add tap functionality for "All" tab
            },
            child: Text(
              "All",
              style: CustomTextStyles.bodyMediumPrimary,
            ),
          ),
          // Ongoing Tab
          GestureDetector(
            onTap: () {
              // Add tap functionality for "Ongoing" tab
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.iconOrderOngoing,
                  height: 14.h,
                  width: 18.h,
                  margin: EdgeInsets.only(top: 4.h),
                  color: theme.primaryColor,
                ),
                SizedBox(width: 4),
                Text(
                  "Ongoing",
                  style: CustomTextStyles.bodyMediumWhiteA70015,
                ),
              ],
            ),
          ),
          // Completed Tab
          GestureDetector(
            onTap: () {
              // Add tap functionality for "Completed" tab
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.iconOrderCompleted,
                  height: 18.h,
                  width: 18.h,
                ),
                SizedBox(width: 6),
                Text(
                  "Completed",
                  style: CustomTextStyles.bodyMediumWhiteA70015,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
