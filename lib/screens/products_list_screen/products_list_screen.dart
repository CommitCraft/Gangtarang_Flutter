import 'dart:convert';

import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/categories_items.dart';
import 'package:amazmart/api/product.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/home_screen/widgets/product_item_component.dart';
import 'package:amazmart/screens/products_list_screen/widgets/brand_item.dart';
import 'package:amazmart/screens/products_list_screen/widgets/categories_button.dart';
import 'package:amazmart/screens/products_list_screen/widgets/product_item_component_list.dart';
import 'package:amazmart/screens/products_screen/products_screen.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_price_rang_selection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ProductsListScreen extends StatefulWidget {
  CategoriesItems? items;
  ProductsListScreen({super.key, this.items});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  bool isGrid = true; // false is list and true is grid
  bool isLoading = true;
  bool isCateItems = true;
  bool Relevance = true;
  bool Popularity = false;
  bool PricelH = false;
  bool PriceHl = false;
  bool Newest = false;
  List<Products> products = [];
  List<CategoriesItems> cateItems = [];
  int pageNo = 1;
  String? orderby;
  String? order;
  ScrollController _scrollController = ScrollController();

  late WooCommerceApi wc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _scrollController.addListener(_scrollListener);
    wc = WooCommerceApi(WooCommerceApi.createDio());
    fatchProducts();
    fetchCategories();
  }

    void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
      pageNo++;
      });
      print('fatchProducts $pageNo');
      fatchProducts();

    }
  }

  void fatchProducts() async {
    int? catId = widget.items?.id;
    try {
      final fetchedProducts =
          await wc.getProductList(catId, orderby, order, pageNo);
      setState(() {
        if (pageNo == 1) {
          products = fetchedProducts;
        } else {
         products.addAll(fetchedProducts);
        }
        isLoading = false;
      });
    } catch (e) {
      print('getProductsError$e');
    }
  }
  

  Future fetchCategories() async {
    print('Categories ');
    try {
      var categories = await wc.getCategories(39); // add your Main Categgor id get in your Wordpress Category Edit page in title bar 
      setState(() {
        cateItems = categories;
        isCateItems = false;

        // categoriesList = categories;
      });
      print("Categories Respons${cateItems.length}");
    } on DioException catch (e) {
      print('Categories Error ${e.response}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: CustomAppBar(
          title: 'Shopping Cart',
          boxDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appTheme.cyan200, appTheme.cyan50],
            ),
          ),
          rightBtn: true,
          rightIconPath: ImageConstant.iconSearch,
          onRightBtnPressed: () => Navigator.of(context).pushNamed(AppRoutes.searchScreen),

        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // BottomSheetSortFilterWidget(),
              // BottomSheetFilterWidget(),
              SortFilterWidget(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryChip(
                        'Crazy Deals ',
                        () {},
                      ),
                      CategoryChip(
                        'Budget Buys ',
                        () {},
                      ),
                      CategoryChip(
                        'Best Offer ',
                        () {},
                      ),
                      CategoryChip(
                        'Woman ',
                        () {},
                      ),
                      CategoryChip(
                        'Crazy Deals ',
                        () {},
                      ),
                      CategoryChip(
                        'Best Offer ',
                        () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                color: appTheme.blueGray50,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : products.isEmpty ? Center(child: Text('No product found'),)  :
                          Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(8.h),
                              decoration:
                                  BoxDecoration(color: appTheme.whiteA700),
                              child: Column(
                                children: [
                                  ResponsiveGridListBuilder(
                                    minItemWidth: 1,
                                    minItemsPerRow: isGrid ? 2 : 1,
                                    maxItemsPerRow: isGrid ? 2 : 1,
                                    horizontalGridSpacing: 8.h,
                                    verticalGridSpacing: 8.h,
                                    gridItems: List.generate(
                                      products.length,
                                      (index) {
                                        var item = products[index];
                                        // print('item.images[0].src ${item.images[0].src}');
                                        return isGrid
                                            ? ProductItemComponent(
                                                productName: item.name,
                                                productImage:
                                                    item.images.isNotEmpty
                                                        ? item.images.first.src
                                                        : ImageConstant
                                                            .imageNotFound,
                                                salePrice:
                                                    item.salePrice!.isNotEmpty
                                                        ? item.salePrice!
                                                        : item.price,
                                                originalPrice:
                                                    item.regularPrice,
                                                discountText: item.regularPrice!
                                                        .isNotEmpty
                                                    ? calculateDiscount(
                                                            parseDouble(item
                                                                .regularPrice!),
                                                            parseDouble(item
                                                                    .salePrice!
                                                                    .isNotEmpty
                                                                ? item
                                                                    .salePrice!
                                                                : item.price))
                                                        .toString()
                                                    : null,
                                                reviewCount: item.reviewCount,
                                                rating: item.averageRating,
                                                onItemClick: () {
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            ProductsScreen(
                                                          item: item,
                                                        ),
                                                      ));
                                                },
                                                onWishlistClick: () async {
                                                  SharedPreferenceHelper sp =
                                                      SharedPreferenceHelper();
                                                  String? token =
                                                      sp.getString('token');
                                                  // print("wishlist"+token!);
                                                  late final WooCommerceApi
                                                      apiWishlist =
                                                      WooCommerceApi(
                                                          WooCommerceApi
                                                              .WishlistDio(
                                                                  token ?? ""));
                                                  try {
                                                    Future<String> response =
                                                        apiWishlist
                                                            .addWWishlist(
                                                                item.id);
                                                    response.then(
                                                      (value) {
                                                        print(
                                                            'Response Data$value');
                                                        Map<String, dynamic>
                                                            datas =
                                                            jsonDecode(value);
                                                        if (datas['id'] == 0) {
                                                          // ToastMessage.show(
                                                          //     context,
                                                          //     'user someting is wrong!');
                                                        } else {
                                                          ToastMessage.show(
                                                              context,
                                                              'Wishlist Added Succefull');
                                                        }
                                                      },
                                                    );
                                                  } catch (e) {
                                                    ToastMessage.show(context,
                                                        "Wishlist add Some Error : $e");
                                                  }
                                                },
                                              )
                                            : ProductItemComponentList(
                                                productName: item.name,
                                                productImage:
                                                    item.images.isNotEmpty
                                                        ? item.images.first.src
                                                        : ImageConstant
                                                            .imageNotFound,
                                                salePrice:
                                                    item.salePrice!.isNotEmpty
                                                        ? item.salePrice!
                                                        : item.price,
                                                originalPrice:
                                                    item.regularPrice,
                                                discountText: item.regularPrice!
                                                        .isNotEmpty
                                                    ? calculateDiscount(
                                                            parseDouble(item
                                                                .regularPrice!),
                                                            parseDouble(item
                                                                    .salePrice!
                                                                    .isNotEmpty
                                                                ? item
                                                                    .salePrice!
                                                                : item.price))
                                                        .toString()
                                                    : null,
                                                reviewCount: item.reviewCount,
                                                rating: item.averageRating,
                                                onItemClick: () {
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            ProductsScreen(
                                                          item: item,
                                                        ),
                                                      ));
                                                },
                                                onWishlistClick: () async {
                                                  SharedPreferenceHelper sp =
                                                      SharedPreferenceHelper();
                                                  String? token =
                                                      sp.getString('token');
                                                  // print("wishlist"+token!);
                                                  late final WooCommerceApi
                                                      apiWishlist =
                                                      WooCommerceApi(
                                                          WooCommerceApi
                                                              .WishlistDio(
                                                                  token ?? ""));
                                                  try {
                                                    Future<String> response =
                                                        apiWishlist
                                                            .addWWishlist(
                                                                item.id);
                                                    response.then(
                                                      (value) {
                                                        print(
                                                            'Response Data$value');
                                                        Map<String, dynamic>
                                                            datas =
                                                            jsonDecode(value);
                                                        if (datas['id'] == 0) {
                                                          // ToastMessage.show(
                                                          //     context,
                                                          //     'user someting is wrong!');
                                                        } else {
                                                          ToastMessage.show(
                                                              context,
                                                              'Wishlist Added Succefull');
                                                        }
                                                      },
                                                    );
                                                  } catch (e) {
                                                    ToastMessage.show(context,
                                                        "Wishlist add Some Error : $e");
                                                  }
                                                },
                                              );
                                      },
                                    ),
                                    builder: (context, items) => ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: items,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SortFilterWidget() {
    return Container(
      color: const Color(0xFF1A1F25),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 56,
      child: Row(
        children: [
          // Sort Button
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: Border(),
                  builder: (BuildContext context) {
                    return BottomSheetSortFilterWidget();
                  });
              setState(() {});
            },
            icon: CustomImageView(
              imagePath: ImageConstant.iconSort,
              color: appTheme.orange500,
              height: 14,
            ),
            label: const Text(
              'SORT',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Vertical Divider
          const Spacer(),

          Container(
            height: 56,
            width: 0.2,
            color: appTheme.indigo100,
          ),
          // Filter Button
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  shape: Border(),
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetFilterWidget();
                  });
            },
            icon: CustomImageView(
              imagePath: ImageConstant.iconFilter,
              color: appTheme.orange500,
              height: 14,
            ),
            label: const Text(
              'FILTER',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 56,
            width: 0.2,
            color: appTheme.indigo100,
          ),
          // View Toggle Button
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = false;
              });
            },
            icon: CustomImageView(
              imagePath: ImageConstant.iconList,
              color: !isGrid ? appTheme.orange500 : appTheme.whiteA700,
              height: 24,
            ),
          ),
          Container(
            height: 56,
            width: 0.2,
            color: appTheme.indigo100,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = true;
              });
            },
            icon: CustomImageView(
              imagePath: ImageConstant.iconGridList,
              color: isGrid ? appTheme.orange500 : appTheme.whiteA700,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          decoration: BoxDecoration(
              color: appTheme.blueGray50,
              borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget BottomSheetSortFilterWidget() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SORT BY',
                  style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: CustomImageView(
                      imagePath: ImageConstant.iconClose,
                    ))
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 12.h),
          SortSelecter(() {
            setState(() {
            orderby = 'date';
              Relevance = true;
              Popularity = false;
              PriceHl = false;
              PricelH = false;
              Newest = false;
            });
            fatchProducts();

          }, 'Relevance', Relevance),
          SortSelecter(() {
            setState(() {
              orderby = 'popularity';
              Relevance = false;
              Popularity = true;
              PriceHl = false;
              PricelH = false;
              Newest = false;
            });
            fatchProducts();
          }, 'Popularity', Popularity),
          SortSelecter(() {
            setState(() {
              orderby = 'price';
              order = 'asc';
              Relevance = false;
              Popularity = false;
              PriceHl = false;
              PricelH = true;
              Newest = false;
            });
            fatchProducts();
          }, 'Price -- Low to High', PricelH),
          SortSelecter(() {
            setState(() {
              orderby = 'price';
              order = null;
              Relevance = false;
              Popularity = false;
              PriceHl = true;
              PricelH = false;
              Newest = false;
            });
            fatchProducts();
          }, 'Price -- High to Low', PriceHl),
          SortSelecter(() {
            setState(() {
              orderby = 'modified';
              order = null;

              Relevance = false;
              Popularity = false;
              PriceHl = false;
              PricelH = false;
              Newest = true;
            });
            fatchProducts();
          }, 'Newest First', Newest),
        ],
      ),
    );
  }

  Widget BottomSheetFilterWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: CustomTextStyles.bodyMediumErrorContainer.copyWith(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: CustomImageView(
                      imagePath: ImageConstant.iconClose,
                    ))
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 4.h),
          filterRow('Brand:', 'See All'),
          // Flexible
          !isCateItems ? _buildCatItemList(context, cateItems) : Container(),
          SizedBox(height: 4.h),
          filterRow('Categories:', 'See All'),
          !isCateItems
              ? _buildCategoriesButtonItemList(context, cateItems)
              : Container(),
          SizedBox(height: 4.h),
          filterRow('Size:', 'See All'),
          _buildSizeButtonItemList(context),
          SizedBox(height: 4.h),
          filterRow('Price:', ''),
          PriceRangeSlider(
            priceRanges: [PriceRange(label: '', min: 0, max: 300)],
            activeColor: appTheme.black900,
            inactiveColor: appTheme.blueGray100,
          ),
          SizedBox(height: 8.h),
          Container(
            color: appTheme.whiteA700,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 170,
                  height: 48,
                  child: ElevatedButton(
                    style: CustomButtonStyles.outlineIndigoTLS,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Reset',
                        style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: 170,
                  height: 48,
                  child: ElevatedButton(
                    style: CustomButtonStyles.outlinePrimary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Apply',
                        style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 16) ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatItemList(BuildContext context, List<CategoriesItems> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(left: 8),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Wrap(
            spacing: 8.0, // Adjust spacing between items as needed
            runSpacing: 8.0, // Adjust spacing between rows as needed
            children: List.generate(
              items.length,
              (index) => BrandCategorieslistItemWidget(
                imagePath: items[index].image != null
                    ? items[index].image!.src!
                    : ImageConstant.imageNotFound,
                label: items[index].name,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesButtonItemList(
      BuildContext context, List<CategoriesItems> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(left: 8),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Wrap(
            spacing: 8.0, // Adjust spacing between items as needed
            runSpacing: 8.0, // Adjust spacing between rows as needed
            children: List.generate(
              items.length,
              (index) => CategoriesButton(
                label: items[index].name,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButtonItemList(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(left: 0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 0.0, // Adjust spacing between items as needed
            runSpacing: 0.0, // Adjust spacing between rows as needed
            children: List.generate(
              sizes.length,
              (index) => CategoriesButton(
                label: sizes[index],
                onTap: () {},
              ),
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
              style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 15),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              action,
              style: CustomTextStyles.titleSmallPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget SortSelecter(VoidCallback ontap, String title, bool selecter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pageNo = 1;
          products = [];
        });
        ontap.call();
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB  (16,8,8,8),
            child: Text(
              title,
              style: CustomTextStyles.bodyMediumErrorContainer.copyWith(fontSize: 15),
            ),
          ),
          CustomImageView(
            imagePath: selecter
                ? ImageConstant.iconSelect
                : ImageConstant.iconUnSelect,
            margin: EdgeInsets.all(8),
          )
        ],
      ),
    );
  }
}
