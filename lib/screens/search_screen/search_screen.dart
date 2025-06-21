import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/product.dart';
import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:amazmart/screens/products_screen/products_screen.dart';
import 'package:amazmart/screens/search_screen/widgets/catItem.dart';
import 'package:amazmart/screens/search_screen/widgets/search_item.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late WooCommerceApi wc;
  bool isSearch = true;

  List<Products> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wc = WooCommerceApi(WooCommerceApi.createDio());
  }

  void fetchSearchProduct(String searchText) async {
    try {
      var data = await wc.SearchProductListOnly(searchText);
      setState(() {
        products = data;
        isSearch = false;
      });
    } on DioException catch (e) {
      print('Eror ${e.response}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: _searchbar(context),
        leadingWidth: double.infinity,
        toolbarHeight: 74,
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(14.h),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !isSearch
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.0.h),
                        child: Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: appTheme.indigo50,
                        ),
                      );
                    },
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return SearchItemList(
                        title: products[index].name,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductsScreen(
                              item: products[index],
                            ),
                          ));
                        },
                      );
                    },
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: appTheme.blueGray50,
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            filterRow('Discover More', 'Clear All'),
            Divider(),
            SizedBox(height: 10,),
            _buildSizeButtonItemList(context),
          ],
        ),
      ),
    ));
  }

  Widget _buildSizeButtonItemList(BuildContext context) {
    List<String> sizes = [
      'Mobiles',
      'Electronics',
      'Camera',
      'Headphone',
      'TVs & LED',
      'Mobiles',
      'Furniture'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(left: 0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0, // Adjust spacing between items as needed
            runSpacing: 8.0, // Adjust spacing between rows as needed
            children: List.generate(
              sizes.length,
              (index) => Container(
                child: CatButton(
                  label: sizes[index],
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProductsListScreen(),
                    ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchbar(BuildContext context) {
    return Container(
      height: 71,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white, // Replace with your app's theme color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.fromLTRB(
                    12,
                    6,
                    0,
                    6,
                  ),
                  child: IconButton(
                    icon: CustomImageView(
                      imagePath: ImageConstant.backIcon,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: CustomInputField(
                    onChanged: (p0) => fetchSearchProduct(p0),
                    width: double.minPositive,
                    hintText: 'Search Best items for You ',
                    borderDecoration: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.h),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 00),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Divider(
              height: 1,
              color: appTheme.indigo50,
            ),
          ),
        ],
      ),
    );
  }

  Widget filterRow(String title, String action) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              title,
              style: CustomTextStyles.titleMediumErrorContainer,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              action,
              style: CustomTextStyles.titleSmallPrimary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


