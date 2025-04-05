import 'dart:convert';
import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/categories_items.dart';
import 'package:amazmart/api/tags.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/core/utils/url_decode.dart';
import 'package:amazmart/screens/notifications_screen/notifications_screen.dart';
import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:amazmart/screens/products_screen/products_screen.dart';
import 'package:amazmart/screens/search_screen/search_screen.dart';
import 'package:amazmart/screens/splash_screen/splash_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:amazmart/screens/home_screen/widgets/product_item_component.dart';
import 'package:amazmart/widgets/custom_search_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import '../../core/app_export.dart';
import '../../api/product.dart';
import '../wishlist_page/wishlist_page.dart';
import 'widgets/brandlist_item_widget.dart';
import 'widgets/categorylist_item_widget.dart';
import 'widgets/featureslist_item_widget.dart';
import 'widgets/homedecorlist_item_widget.dart';
import 'widgets/Text_With_Icon.dart';
import 'widgets/listgroup_item_widget.dart';
import 'widgets/trendingproducts_item_widget.dart';

bool isLoading = true;
bool isLoadingTags = true;
bool isCatLoading = true;
List<Products> products = [];
late List<CategoriesItems> categoriesList = [];
List<TagItem> tagsList = [];
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
SharedPreferenceHelper sp = SharedPreferenceHelper();

class HomeInitialPage extends StatefulWidget {
  const HomeInitialPage({Key? key}) : super(key: key);

  @override
  HomeInitialPageState createState() => HomeInitialPageState();
}

class HomeInitialPageState extends State<HomeInitialPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  // late TabController tabviewController;
  late WooCommerceApi wooCommerceApi;

  @override
  void initState() {
    super.initState();
    wooCommerceApi = WooCommerceApi(WooCommerceApi.createDio());
    fetchProducts();
    fetchTags();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      final cat = await wooCommerceApi.getCategories(0);
      setState(() {
        categoriesList = cat;
        isCatLoading = false;
        print('Length Length ${categoriesList.length}');
      });
    } catch (e) {
      print('getcategoriesListError$e');
    }
  }

  void fetchProducts() async {
    try {
      final fetchedProducts =
          await wooCommerceApi.getProductList(null, null, null, null);
      setState(() {
        products = fetchedProducts;
        isLoading = false;
        print('Length Length ${products.length}');
      });
    } catch (e) {
      print('getProductsError$e');
    }
  }

  void fetchTags() async {
    try {
      final fetchedTags = await wooCommerceApi.getTags();
      setState(() {
        tagsList = fetchedTags;
        isLoadingTags = false;
      });
    } catch (e) {
      print('getTagsError $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: buildAppBar(context),
        leadingWidth: double.infinity,
      ),
      drawer: Drawer(
        width: 240,
        child: _Drawer(context),
      ),
      body: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildSearchAndCategories(context),
                    SizedBox(height: 12.h),
                    _buildCategoryList(context),
                    SizedBox(height: 6.h),
                    _buildTrendingBanner(context),
                    SizedBox(height: 10.h),
                    _buildFeaturesList(context),
                    SizedBox(height: 14.h),
                    _buildTrendingProducts(context),
                    SizedBox(height: 14.h),
                    _buildAdvertisementBanner(context),
                    SizedBox(height: 18.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: 14.h,
                        right: 10.h,
                      ),
                      child: _buildRowSponsored(
                        context,
                        sponsoredone: "Choose Brand",
                        offerone: "View All",
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildBrandList(context),
                    SizedBox(height: 14.h),
                    MainList(context),
                    SizedBox(height: 18.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "Divine Puja Emporium",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildHomeDecorList(context),
                    SizedBox(height: 14.h),
                    _buildSponsoredSection(context),
                    SizedBox(height: 8.h),
                    _buildAdditionalBanner(context),
                    SizedBox(height: 16.h),
                    _buildTabview(context),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ];
          },
          // body: _buildAdditionalBanner(context),
          body: SingleChildScrollView(child: MainList(context))),
    );
  }
}

Widget MainList(BuildContext context) {
  return isLoading
      ? Center(
          child: CircularProgressIndicator(),
        )
      : Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(8.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: appTheme.whiteA700),
          child: Column(
            children: [
              ResponsiveGridListBuilder(
                minItemWidth: 1,
                minItemsPerRow: 2,
                maxItemsPerRow: 2,
                horizontalGridSpacing: 8.h,
                verticalGridSpacing: 8.h,
                gridItems: List.generate(
                  products.length,
                  (index) {
                    var item = products[index];
                    return ProductItemComponent(
                      productName: item.name,
                      productImage: item.images.isNotEmpty
                          ? item.images.first.src
                          : ImageConstant.imageNotFound,
                      salePrice: item.salePrice!.isNotEmpty
                          ? item.salePrice!
                          : item.price,
                      originalPrice: item.regularPrice,
                      discountText: item.regularPrice!.isNotEmpty
                          ? calculateDiscount(
                                  parseDouble(item.regularPrice!),
                                  parseDouble(item.salePrice!.isNotEmpty
                                      ? item.salePrice!
                                      : item.price))
                              .toString()
                          : null,
                      reviewCount: item.reviewCount,
                      rating: item.averageRating,
                      onItemClick: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductsScreen(
                            item: item,
                          ),
                        ));
                      },
                      onWishlistClick: () async {
                        SharedPreferenceHelper sp = SharedPreferenceHelper();
                        String? token = sp.getString('token');
                        // print("wishlist"+token!);

                        late final WooCommerceApi apiWishlist = WooCommerceApi(
                            WooCommerceApi.WishlistDio(token ?? ""));
                        try {
                          Future<String> response =
                              apiWishlist.addWWishlist(item.id);
                          response.then(
                            (value) {
                              print('Response Data$value');
                              Map<String, dynamic> datas = jsonDecode(value);
                              if (datas['id'] == 0) {
                                // ToastMessage.show(context, 'Please login to add wishlist');
                              } else {
                                ToastMessage.show(
                                    context, 'Wishlist Added Succefull');
                              }
                            },
                          );
                        } catch (e) {
                          ToastMessage.show(
                              context, "Wishlist add Some Error : $e");
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
        );
}

// Common widget
Widget _buildRowSponsored(
  BuildContext context, {
  required String sponsoredone,
  required String offerone,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        sponsoredone,
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onPrimary.withOpacity(1),
        ),
      ),
      Text(
        offerone,
        style: CustomTextStyles.bodyMediumLufgaRedA70003.copyWith(
          color: appTheme.black900,
        ),
      ),
    ],
  );
}

Widget _buildSearchAndCategories(BuildContext context) {
  var _SearchController;

  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(vertical: 14.h),
    decoration: BoxDecoration(
      color: appTheme.whiteA700,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          // onDoubleTap in Search View then open Search Screen
          child: CustomSearchView(
            controller: _SearchController,
            hintText: "Search Best items for You",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 10.h,
            ),
          ),
        ),
        SizedBox(height: 14),
        Padding(
          padding: EdgeInsets.only(left: 16.h, top: 10, bottom: 10, right: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.h,
                children: isLoadingTags
                    ? []
                    : List.generate(
                        tagsList.length,
                        (index) {
                          var i = tagsList[index];
                          return TextWithIcon(
                            text: i.name!,
                            icon: null,
                          );
                        },
                      ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryList(BuildContext context) {
  final List<Map<String, String>> localCategory = [
    {"title": "Shivling", "icon": ImageConstant.shivaling},
    {"title": "Shankh", "icon": ImageConstant.Shankh},
    {"title": "Ganga Water", "icon": ImageConstant.water},
    {"title": "MALA", "icon": ImageConstant.mala},
    {"title": "Pendant", "icon": ImageConstant.pendant},
     {"title": "Ring", "icon": ImageConstant.ring},
  ];

  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.only(right: 12, left: 12, bottom: 4, top: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          children: List.generate(
            localCategory.length,
            (index) {
              var i = localCategory[index];
              return CategorylistItemWidget(
                iconPath: i['icon']!,
                name: i['title']!,
                margin: EdgeInsets.only(left: 5, right: 10, top: 10),
                spacing: 10,
              );
            },
          ),
        ),
      ),
    ),
  );
}

Widget _buildTrendingBanner(BuildContext context) {
  return Container(
    height: 170.h,
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: appTheme.blueGray100,
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.img1,
          height: 170.h,
          width: double.maxFinite,
        ),
      ],
    ),
  );
}

// price tag
Widget _buildFeaturesList(BuildContext context) {
  List<FeaturesListItemWidget> item = [
    FeaturesListItemWidget(
        text: "Free Shipping & Returns",
        subText: "For all orders over Rs.99",
        textStyle: TextStyle(color: appTheme.whiteA700),
        bgcolor: appTheme.black900,
        imagePath: ImageConstant.iconDelivery),
    FeaturesListItemWidget(
        text: "Secure Payment",
        subText: "We ensure secure payment",
        textStyle: CustomTextStyles.titleSmallErrorContainer15,
        bgcolor: appTheme.whiteA700,
        imagePath: ImageConstant.iconchecksecur),
  ];

  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 14.h, right: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 6.h,
          children: List.generate(
            item.length,
            (index) {
              var i = item[index];
              return FeaturesListItemWidget(
                text: i.text,
                subText: i.subText,
                imagePath: i.imagePath,
                bgcolor: i.bgcolor,
                textStyle: i.textStyle,
              );
            },
          ),
        ),
      ),
    ),
  );
}

List<TrendingProductsItemWidget> TrendingProducts = [
  TrendingProductsItemWidget(
      Trending: "Trending Collection",
      Discount: "Up to 25% OFF",
      Title: "Electronics Sale",
      imagePath: ImageConstant.el1),
  TrendingProductsItemWidget(
      Trending: "Men Collection",
      Discount: "Up to 35% OFF",
      Title: "Man Sale",
      imagePath: ImageConstant.el2),
  TrendingProductsItemWidget(
      Trending: "Sport Collection",
      Discount: "Up to 30% OFF",
      Title: "Sport Sale",
      imagePath: ImageConstant.el3),
];
Widget _buildTrendingProducts(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 14.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.h,
          children: List.generate(
            TrendingProducts.length,
            (index) {
              var tr = TrendingProducts[index];
              return TrendingProductsItemWidget(
                Trending: tr.Trending,
                Title: tr.Title,
                Discount: tr.Discount,
                imagePath: tr.imagePath,
              );
            },
          ),
        ),
      ),
    ),
  );
}

//ad1
Widget _buildAdvertisementBanner(BuildContext context) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: appTheme.blueGray100,
      border: Border.all(
        color: appTheme.whiteA700,
        width: 3.h,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: ImageConstant.ad1,
          height: 92.h,
          width: double.maxFinite,
        ),
      ],
    ),
  );
}

Widget _buildBrandList(BuildContext context) {
  List<BrandlistItemWidget> barndList = [
    BrandlistItemWidget(imagePath: ImageConstant.GoogleIcon, title: "Google"),
    BrandlistItemWidget(imagePath: ImageConstant.AppleIcon, title: "Apple"),
    BrandlistItemWidget(imagePath: ImageConstant.MicroSoft, title: "Microsoft"),
    BrandlistItemWidget(imagePath: ImageConstant.hp, title: "Hp"),
    BrandlistItemWidget(imagePath: ImageConstant.adidas, title: "adidas"),
    BrandlistItemWidget(imagePath: ImageConstant.dell, title: "Dell"),
  ];

  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(left: 14.h, right: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.h,
          children: List.generate(
            barndList.length,
            (index) {
              var item = barndList[index];
              return BrandlistItemWidget(
                  imagePath: item.imagePath, title: item.title);
            },
          ),
        ),
      ),
    ),
  );
}

// Widget _buildProductGrid(BuildContext context) {
//   return Container(
//     width: double.maxFinite,
//     padding: EdgeInsets.all(8.h),
//     decoration: BoxDecoration(
//       color: appTheme.whiteA700,
//     ),
//     child: Column(
//       children: [
//         ResponsiveGridListBuilder(
//           minItemWidth: 1,
//           minItemsPerRow: 2,
//           maxItemsPerRow: 2,
//           horizontalGridSpacing: 8.h,
//           verticalGridSpacing: 8.h,
//           builder: (context, items) => ListView(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             physics: const NeverScrollableScrollPhysics(),
//             children: items,
//           ),
//           gridItems: List.generate(
//             4,
//             (index) {
//               return Gridheart6oneItemWidget();
//             },
//           ),
//         ),
//         SizedBox(height: 12.h)
//       ],
//     ),
//   );
// }

Widget _buildHomeDecorList(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      height: 170,
      margin: EdgeInsets.only(left: 14.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          children: List.generate(
            products.length,
            (index) {
              var i = products[index];
              return HomedecorListItemWidget(
                img: i.images.isNotEmpty
                    ? i.images[0].src
                    : ImageConstant.imageNotFound,
                ontap: () => Navigator.of(context, rootNavigator: true)
                    .push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProductsScreen(
                    item: i,
                  ),
                )),
              );
            },
          ),
        ),
      ),
    ),
  );
}

Widget _buildSponsoredSection(BuildContext context) {
  List<ListSponsoredItemWidget> sponsoredList = [
    ListSponsoredItemWidget(imagePath: ImageConstant.spo1),
    ListSponsoredItemWidget(imagePath: ImageConstant.spo2),
  ];

  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(vertical: 10.h),
    decoration: BoxDecoration(
      color: appTheme.whiteA700,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 16.h),
          child: _buildRowSponsored(
            context,
            sponsoredone: "Sponsored",
            offerone: "Min. 30% off",
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          margin: EdgeInsets.only(left: 14.h, right: 14),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10.h,
              children: List.generate(
                sponsoredList.length,
                (index) {
                  var item = sponsoredList[index];
                  return ListSponsoredItemWidget(
                    imagePath: item.imagePath,
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
      ],
    ),
  );
}

Widget _buildAdditionalBanner(BuildContext context) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: appTheme.blueGray100,
      border: Border.all(
        color: appTheme.whiteA700,
        width: 4.h,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: ImageConstant.ad2,
          height: 92.h,
          width: double.maxFinite,
        ),
      ],
    ),
  );
}

Widget _buildTabview(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 16.h, bottom: 10.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: SizedBox(
        child: Row(
          children: !isCatLoading
              ? List.generate(
                  categoriesList.length,
                  (index) {
                    var item = categoriesList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductsListScreen(
                            items: item,
                          ),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10.h),
                        padding: EdgeInsets.only(
                            left: 5.h, right: 8, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                            border: Border.all(color: appTheme.indigo100),
                            borderRadius: BorderRadius.circular(18.h)),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: item.image != null ? item.image!.src ?? ImageConstant.imageNotFound :ImageConstant.imageNotFound ,
                              margin: EdgeInsets.all(5),
                              height: 24,
                            ),
                            Text(
                              item.name,
                              style: CustomTextStyles.labelLargeBlack900,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : [],
        ),
      ),
    ),
  );
}

Widget _buildMainContentPager(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: appTheme.whiteA700,
    ),
    height: double.infinity,
    padding: EdgeInsets.all(10),
    child: Expanded(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : ResponsiveGridList(
              minItemWidth: 1,
              minItemsPerRow: 2,
              maxItemsPerRow: 2,
              horizontalGridSpacing: 8.h,
              verticalGridSpacing: 8.h,
              listViewBuilderOptions: ListViewBuilderOptions(),
              children: products.map(
                (item) {
                  // String? img = item.images != null ? item.images?.first.src.toString():'';
                  // print('ImageUrl');
                  return Container(
                    child: ProductItemComponent(
                      productName: item.name,
                      productImage: item.images.isNotEmpty
                          ? item.images.first.src
                          : ImageConstant.imageNotFound,
                      salePrice: item.salePrice!.isNotEmpty
                          ? item.salePrice!
                          : item.price,
                      originalPrice: item.regularPrice,
                      discountText: item.regularPrice!.isNotEmpty
                          ? calculateDiscount(
                                  parseDouble(item.regularPrice!),
                                  parseDouble(item.salePrice!.isNotEmpty
                                      ? item.salePrice!
                                      : item.price))
                              .toString()
                          : null,
                      reviewCount: item.reviewCount,
                      rating: item.averageRating,
                      onItemClick: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductsScreen(
                            item: item,
                          ),
                        ));
                      },
                      onWishlistClick: () async {
                        SharedPreferenceHelper sp = SharedPreferenceHelper();
                        String? token = sp.getString('token');
                        // print("wishlist"+token!);
                        late final WooCommerceApi apiWishlist = WooCommerceApi(
                            WooCommerceApi.WishlistDio(token ?? ""));
                        try {
                          Future<String> response =
                              apiWishlist.addWWishlist(item.id);
                          response.then(
                            (value) {
                              print('Response Data$value');
                              Map<String, dynamic> datas = jsonDecode(value);
                              if (datas['id'] == 0) {
                                ToastMessage.show(
                                    context, 'user someting is wrong!');
                              } else {
                                ToastMessage.show(
                                    context, 'Wishlist Added Succefull');
                              }
                            },
                          );
                        } catch (e) {
                          ToastMessage.show(
                              context, "Wishlist add Some Error : $e");
                        }
                      },
                    ),
                  );
                },
              ).toList(),
            ),
    ),
  );
}

int calculateDiscount(double regularPrice, double salePrice) {
  if (regularPrice <= 0 || salePrice < 0 || salePrice > regularPrice) {
    throw ArgumentError(
        "Invalid prices provided. Regular price must be greater than sale price and prices should be positive.");
  }
  return (((regularPrice - salePrice) / regularPrice) * 100).toInt();
}

double parseDouble(String value) {
  // Try to parse the string to double, return null if invalid
  try {
    double parsedValue = double.parse(value);
    if (parsedValue < 0) {
      throw FormatException("Value cannot be negative");
    }
    return parsedValue;
  } catch (e) {
    print("Error parsing '$value': ${e.toString()}");
    return 0; // Return null for invalid input
  }
}

Widget buildAppBar(BuildContext context) {
  return Container(
    height: kToolbarHeight,
    width: double.maxFinite,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        Color(0xFF8AE7ED), // Light blue
        Color(0xFFCDFFF3), // Light green
      ],
    )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: appTheme.gray100,
            borderRadius: BorderRadius.circular(5.h),
          ),
          margin: EdgeInsets.only(left: 12.h, top: 5.h, bottom: 5.h),
          child: IconButton(
            color: appTheme.black900,
            icon: CustomImageView(
              imagePath: ImageConstant.iconMenu,
            ),
            onPressed: () {
              print("menu iConClick");
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.g_logo,
                width: 28,
                height: 24,
              ),
              const SizedBox(width: 5),
              Text(
                'angtarang',
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: appTheme.gray100,
            borderRadius: BorderRadius.circular(5.h),
          ),
          margin: EdgeInsets.only(right: 12.h, top: 5.h, bottom: 5.h),
          child: IconButton(
            color: appTheme.black900,
            icon: CustomImageView(
              imagePath: ImageConstant.iconTr,
            ), onPressed: () {
  Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
         pageBuilder: (context, animation, secondaryAnimation) =>
  WishlistPage()
         ));
  },
        )
        )



        // iconNotification
        // Container(
        //   decoration: BoxDecoration(
        //     color: appTheme.gray100,
        //     borderRadius: BorderRadius.circular(5.h),
        //   ),
        //   margin: EdgeInsets.only(right: 12.h, top: 5.h, bottom: 5.h),
        //   child: IconButton(
        //     color: appTheme.black900,
        //     icon: CustomImageView(
        //       imagePath: ImageConstant.iconNotification,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        //         pageBuilder: (context, animation, secondaryAnimation) =>
        //             NotificationsScreen(),
        //       ));
        //     },
        //   ),
        // ),
      ],
    ),
  );
}

Widget _Drawer(BuildContext context) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(color: appTheme.whiteA700),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            _buildTopSection(context),
            SizedBox(
              height: 15,
            ),
            Divider(),
            _buildNavigationMenu(context),
          ],
        ),
        _buildFooter(),
      ],
    ),
  );
}

// Widget for the top section with switch button and profile info
Widget _buildTopSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space widgets evenly
    children: [
      // Switch button
      // Card(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16.0), // Card corner radius
      //   ),
      //   elevation: 4.0, // Shadow effect
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Row(
      //       children: [
      //         CustomImageView( imagePath:
      //           'assets/ic_sun.png', // Assuming image assets are in an assets folder
      //           width: 24,
      //           height: 24,
      //           color: Colors.white,
      //         ),
      //         SizedBox(width: 5.0), // Spacing between icons
      //         Image.asset('assets/images/ic_moon.png'),
      //       ],
      //     ),
      //   ),
      // ),

      // Profile section
      Row(
        
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 10.0),
          CustomImageView(
            imagePath: ImageConstant.imageNotFound,
            height: 60,
            width: 60,
            radius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: appTheme.amber300),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start  ,

            children: [
              SizedBox(
                // height: 70,
                width: MediaQuery.of(context).size.width /2 -50,
                child: Text(
                    sp.getString('displayName') ?? 'Guset user',
                    // 'hjgdfjhdsgfjdsgfhsdfhjsjfkjs dsffkdsjhkfjskf fd ',
                    // textDirection: TextDirection.ltr,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)),
              ),
              Text(
                sp.getString('email') ?? 'example@gmail.com',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.0, color: theme.primaryColor),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// Widget for the side navigation menu
Widget _buildNavigationMenu(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildNavigationItem(
          title: 'Home',
          icon: ImageConstant.IconMenuHome,
          onItemClick: () {},
        ),
        _buildNavigationItem(
          title: 'Products',
          icon: ImageConstant.IconMenuProducts,
          onItemClick: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.productsListScreen);
          },
        ),
        _buildNavigationItem(
          title: 'Wishlist',
          icon: ImageConstant.IconMenuWishlist,
          onItemClick: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.wishlistPage);
          },
        ),
        _buildNavigationItem(
          title: 'My Orders',
          icon: ImageConstant.IconMenu_order,
          onItemClick: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.myOrderOngoingScreen);
          },
        ),
        _buildNavigationItem(
          title: 'My Cart',
          icon: ImageConstant.IconMenu_cart,
          onItemClick: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.cartScreen);
          },
        ),
        _buildNavigationItem(
          title: 'Profile',
          icon: ImageConstant.IconMenuProfile,
          onItemClick: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.editProfileScreen);
          },
        ),
        _buildNavigationItem(
          title: 'Logout',
          icon: ImageConstant.IconMenuLogout,
          onItemClick: () {
            sp.remove('token');
            sp.remove('id');
            sp.remove('email');
            sp.remove('nicename');
            sp.remove('displayName');
            sp.remove('image');

            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SplashScreen()),
              (route) => false, // Clear the main stack
            );
            // Navigator.popUntil(context, ModalRoute.withName(AppRoutes.splashScreen));
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  SplashScreen(),),(route) => route.isActive,);
          },
        ),
      ],
    ),
  );
}

// Reusable widget for each side navigation menu item
Widget _buildNavigationItem(
    {required String title,
    required String icon,
    required VoidCallback onItemClick}) {
  return GestureDetector(
    onTap: onItemClick,
    child: Container(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color(0xFFFAFDFF),
              border: Border.all(color: Color(0xFFCFDAE6)),
              borderRadius: BorderRadius.circular(12)),
          child: CustomImageView(
            imagePath: icon,
            width: 15,
            height: 15,
          ),
        ),
        title: Text(title, style: TextStyle(fontSize: 16.0)),
        trailing: CustomImageView(
          imagePath: ImageConstant.iconRightArrow,
          color: appTheme.blueGray50,
        ), // Trailing arrow
      ),
    ),
  );
}

// Widget for the side footer section
Widget _buildFooter() {
  return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: appTheme.indigo50))),
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'AmazMart', // Assuming app_name is defined elsewhere
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text('Ecommerce Store'),
            ],
          ),
          Row(
            children: [
              Text('Version 1.0'),
            ],
          ),
          SizedBox(height: 10.0), // Spacing between text and icon
        ],
      ));
}
