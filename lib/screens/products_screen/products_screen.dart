import 'dart:convert';

import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/api/mySql/database_helper.dart';
import 'package:amazmart/api/product.dart';
import 'package:amazmart/api/response_product_detail/response_product_detail.dart';
import 'package:amazmart/api/shared_preference_helper.dart';
import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/home_screen/widgets/product_item_component.dart';
import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:share/share.dart';

import '../../core/app_export.dart';

class ProductsScreen extends StatefulWidget {
  Products? item;
  ProductsScreen({super.key, this.item});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState(item);
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Products products;
  late ResponseProductDetail rpd = ResponseProductDetail();
  bool isDetals = false;
  List<Products> relatedIds = [];
  bool isRelatedIds = true;
  bool? wishlistCheck = false;
  late WooCommerceApi wc;
  late String imageSelected;
  late DatabaseHelper db = DatabaseHelper();

  _ProductsScreenState(Products? item) {
    products = item!;
  }
    String currencySymbol = '\$';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       SharedPreferenceHelper sp = SharedPreferenceHelper();
    currencySymbol = sp.getString('currencySymbol') ?? '\$';
    db = DatabaseHelper();
    wc = WooCommerceApi(WooCommerceApi.createDio());
    fetchProductDetails();
    print('Item ${products.toJson()}');
    imageSelected = products.images.isNotEmpty
        ? products.images.first.src
        : ImageConstant.imageNotFound;
  }

  List<int> selectedOptions = [];

  void selectOption(int attributeIndex, int optionIndex) {
    print('attributeIndex $attributeIndex \n optionIndex $optionIndex');
    setState(() {
      selectedOptions[attributeIndex] = optionIndex;
    });
  }

  void fetchProductDetails() async {
    try {
      var data = await wc.getProductDetails(products.id);
      // Clipboard.setData(ClipboardData(text: data.toJson()));
      print("Response $data");

//  late ResponseProductDetail rpd;
      try {
        rpd = ResponseProductDetail.fromJson(data);
        setState(() {
          print("Response value ${rpd.relatedIds}");
          products = Products(
              id: rpd.id!,
              name: rpd.name!,
              regularPrice: rpd.regularPrice,
              price: rpd.price!,
              salePrice: rpd.salePrice,
              averageRating: parseDouble(rpd.averageRating!),
              reviewCount: rpd.ratingCount!,
              images: rpd.images!
                  .map(
                    (e) => ProductImage(src: e.src!),
                  )
                  .toList());
          isDetals = true;
        });

        try {
          var data = await wc.getProductListOnly('${rpd.relatedIds!}');
          // var data = await wc.getProductList();
          setState(() {
            relatedIds = data;
            isRelatedIds = false;
          });
        } on DioException catch (e) {
          print('Error relatedIds ${e.response}');
        }
      } on Object catch (e, s) {
        print('Json To modal $e $s');
        rethrow;
      }
    } on DioException catch (e) {
      print('Eror ${e.response}');
    }
  }

  AddTocart() async {
    String? discount = products.regularPrice!.isNotEmpty
        ? calculateDiscount(
                parseDouble(products.regularPrice!),
                parseDouble(products.salePrice!.isNotEmpty
                    ? products.salePrice!
                    : products.price))
            .toString()
        : null;
    print('objects');
    await db.insertCartItem(CartItem(
        productId: rpd.id!.toString(),
        productName: rpd.name!,
        productImage: rpd.images!.first.src!,
        rating: parseDouble(rpd.averageRating!),
        reviewCount: rpd.ratingCount!,
        salePrice: int.parse(rpd.salePrice!),
        regularPrice: int.parse(rpd.regularPrice!),
        discount: int.parse(discount!),
        returnLabel: '14 Days return available',
        itemCount: 1));
    print('objects sssss');
  }

  buyNow() async {
    String? discount = products.regularPrice!.isNotEmpty
        ? calculateDiscount(
                parseDouble(products.regularPrice!),
                parseDouble(products.salePrice!.isNotEmpty
                    ? products.salePrice!
                    : products.price))
            .toString()
        : null;
    await db.insertCartItem(CartItem(
        productId: rpd.id!.toString(),
        productName: rpd.name!,
        productImage: rpd.images!.first.src!,
        rating: parseDouble(rpd.averageRating!),
        reviewCount: rpd.ratingCount!,
        salePrice: int.parse(rpd.salePrice!),
        regularPrice: int.parse(rpd.regularPrice!),
        discount: int.parse(discount!),
        returnLabel: '14 Days return available',
        itemCount: 1));
    Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.cartScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: CustomAppBar(
          title: products.name ?? 'Product Details',
          rightBtn: true,
          rightIconPath: ImageConstant.iconSearch,
          onRightBtnPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.searchScreen);
          },
        ),
        body: isDetals ?
         SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductCard(context),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: buildSlideItems(context)),
                      Container(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Description",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Html(
                          data: rpd.description!,
                        ),
                      ),
                      Container(
                        color: appTheme.blueGray50,
                        height: 5,
                      ),
                      // product meta data
                      rpd.metaData!.isNotEmpty
                          ? productMetaData()
                          : Container(),
                      // reletete products
                      rpd.relatedIds!.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 0),
                              color: appTheme.blueGray50,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Similar Products',
                                        style: CustomTextStyles
                                            .titleMediumErrorContainer),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: productsData())
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              // footer  btns
              Container(
                color: appTheme.whiteA700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        style: CustomButtonStyles.fillPrimaryWithotRoundBlack,
                        onPressed: AddTocart,
                        child: Text('Add To cart',
                            style: CustomTextStyles.titleMediumWhiteA700),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        style: CustomButtonStyles.fillPrimaryWithotRound,
                        onPressed: buyNow,
                        child: Text('Buy Now',
                            style: CustomTextStyles.titleMediumErrorContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      : Center(child: CircularProgressIndicator(),)
      ),
    );
  }

  Widget ProductCard(BuildContext context) {
    String? discount = products.regularPrice!.isNotEmpty
        ? calculateDiscount(
                parseDouble(products.regularPrice!),
                parseDouble(products.salePrice!.isNotEmpty
                    ? products.salePrice!
                    : products.price))
            .toString()
        : null;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Product Image
          Stack(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomImageView(
                  imagePath: imageSelected,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: appTheme.green700,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(6),
                      child: Text(
                        discount != null ? '$discount % OFF' : '',
                        style: TextStyle(
                          fontSize: 10,
                          color: appTheme.whiteA700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                SharedPreferenceHelper sp =
                                    SharedPreferenceHelper();
                                String? token = sp.getString('token');
                                late final WooCommerceApi apiWishlist =
                                    WooCommerceApi(WooCommerceApi.WishlistDio(
                                        token ?? ""));
                                try {
                                  Future<String> response =
                                      apiWishlist.addWWishlist(products.id);
                                  response.then(
                                    (value) {
                                      Map<String, dynamic> datas =
                                          jsonDecode(value);
                                      if (datas['id'] == 0) {
                                        // ToastMessage.show(context, 'User, something went wrong!');
                                        setState(() {
                                          wishlistCheck = true;
                                        });
                                      } else {
                                        ToastMessage.show(context,
                                            'Wishlist Added Successfully');
                                      }
                                    },
                                  );
                                } catch (e) {
                                  ToastMessage.show(
                                      context, "Wishlist add error: $e");
                                }
                              },
                              icon: CustomImageView(
                                  imagePath: ImageConstant.navWishlist,
                                  color: wishlistCheck!
                                      ? appTheme.redA70001
                                      : appTheme.gray400),
                            ),
                            IconButton(
                              onPressed: () async {
                                // await FlutterShare.share(
                                //     title: rpd.name!,
                                //     text: rpd.links!.self!.first.href,
                                //     linkUrl: '',
                                //     chooserTitle: '');

                                // Share.share('${rpd.name!} \n ${rpd.links!.self!.first.href}' );
                              },
                              icon: CustomImageView(
                                  imagePath: ImageConstant.IconShare),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),

          // Variant Images
          Center(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            imageSelected = products.images[index].src;
                          },
                        );
                      },
                      child: Image.network(
                        products.images[index].src,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            color: appTheme.blueGray50,
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    products.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Row(children: [
                  CustomRatingBar(
                    ignoreGestures: true,
                    initialRating: products.averageRating,
                    itemSize: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${products.reviewCount} Reviews)',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'jost',
                      fontSize: 14.0,
                      color: appTheme.orange500, // TextColorSecondary
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
                // Price and Discount
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      products.salePrice!.isNotEmpty
                          ? '$currencySymbol${products.salePrice!}'
                          : '$currencySymbol${products.price}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      products.regularPrice!.isNotEmpty
                          ? '$currencySymbol${products.regularPrice}'
                          : '',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF71757A),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      discount != null ? '$discount % OFF' : '',
                      style: TextStyle(
                        fontSize: 15,
                        color: appTheme.pinkA700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rpd.stockStatus!,
                      style: TextStyle(
                        fontSize: 15,
                        color: appTheme.green700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.iconRetrun,
                      height: 14,
                      width: 14,
                      color: appTheme.orange500,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '14 Days return available',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: appTheme.orange500,
                          fontSize: 14),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Free delivery',
                      style: TextStyle(
                        fontSize: 15,
                        color: appTheme.green700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: appTheme.blueGray50,
            height: 5,
          ),
          // variant
          rpd.attributes!.isNotEmpty
              ? _RowBuild('Select Variant')
              : Container(),
          rpd.attributes != null
              ? Column(
                  children: rpd.attributes!.map(
                    (e) {
                      return _buildSpecRow(e.name!, e.options!.first);
                    },
                  ).toList(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appTheme.gray50, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _veriantSelect();
                  });
            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.iconRightArrow,
                    // height: 10,
                    // width: 5,
                    color: appTheme.orange500,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _veriantSelect() {
    return Container(
        padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Color & Size',
                    style: CustomTextStyles.titleMediumErrorContainer),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: CustomImageView(imagePath: ImageConstant.iconClose))
              ],
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                rpd.attributes!.length,
                (index) {
                  var attr = rpd.attributes![index];
                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${attr.name!} :',
                          style: CustomTextStyles.bodyMediumErrorContainer15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: List.generate(
                            attr.options!.length,
                            (optionIndex) {
                              var opt = attr.options![optionIndex];
                              return GestureDetector(
                                onTap: () {
                                  if (attr.options != null &&
                                      attr.options!.length > optionIndex) {
                                    selectOption(index, optionIndex);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                    12,
                                    8,
                                    12,
                                    8,
                                  ),
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: selectedOptions.isNotEmpty
                                          ? selectedOptions[index] ==
                                                  optionIndex
                                              ? theme.primaryColor
                                              : Colors.transparent
                                          : Colors.transparent,
                                      border:
                                          Border.all(color: appTheme.indigo50)),
                                  child: Text(opt),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _RowBuild(String title) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Text(
            title,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
        ),
        SizedBox(height: 10.h),
        Divider(),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget buildSlideItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: appTheme.blueGray50),
      child: Row(children: [
        SlideItemShap(
            'Free Shipping',
            'For all orders over \$99',
            theme.primaryColor,
            CustomImageView(
              imagePath: ImageConstant.IconTrackSupport,
              color: appTheme.whiteA700,
              width: 24,
              height: 24,
              margin: EdgeInsets.all(15),
            )),
        SlideItemShap(
            'Secure Payment',
            'We ensure secure payment',
            appTheme.whiteA700,
            CustomImageView(
              imagePath: ImageConstant.iconSecuricon,
              color: theme.primaryColor,
              width: 24,
              height: 24,
              margin: EdgeInsets.all(15),
            )),
        SlideItemShap(
            'Money Back Guarantee',
            'Any back within 30 days',
            appTheme.whiteA700,
            CustomImageView(
              imagePath: ImageConstant.IconSaveMoney,
              color: theme.primaryColor,
              width: 24,
              height: 24,
              margin: EdgeInsets.all(15),
            )),
        SlideItemShap(
            'Customer Support',
            'Call or email us 24/7',
            appTheme.whiteA700,
            CustomImageView(
              imagePath: ImageConstant.IconTechnicalSupport,
              color: theme.primaryColor,
              width: 24,
              height: 24,
              margin: EdgeInsets.all(15),
            )),
        SlideItemShap(
            'Flexible Payment',
            'Pay with Multiple Credit Card',
            appTheme.whiteA700,
            CustomImageView(
              imagePath: ImageConstant.IconflexBl,
              color: theme.primaryColor,
              width: 24,
              height: 24,
              margin: EdgeInsets.all(15),
            )),
      ]),
    );
  }

  Widget SlideItemShap(
      String title, String subTitle, Color bgColor, CustomImageView imagePath) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          imagePath,
          Text(title, style: theme.textTheme.titleMedium),
          Text(subTitle, style: theme.textTheme.displayMedium),
        ],
      ),
    );
  }

  Widget productMetaData() {
    return Column(
      children: [
        _RowBuild('${rpd.name} Full Specs'),
        Container(
          color: appTheme.blueGray50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 15, left: 15, bottom: 12, top: 12),
          child: Text('GENERAL'),
        ),
        Column(
          children: rpd.metaData!.map(
            (e) {
              return metaSpecRow(e.key!, '${e.value}');
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget metaSpecRow(String key, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appTheme.gray50, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: Text(
              key,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text(
                  value.length > 10 ? value.substring(0,10) : value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      overflow: TextOverflow.fade,
                      fontSize: 15),
                ),
                CustomImageView(
                  imagePath: ImageConstant.iconRightArrow,
                  // height: 10,
                  // width: 5,
                  color: appTheme.orange500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productsData() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allow horizontal scrolling
      child: Row(
        children: !isRelatedIds
            ? relatedIds.map((item) {
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0), // Space between items
                  child: SizedBox(
                    width:
                        200.0, // Set a fixed width for each item (adjust as necessary)
                    child: ProductItemComponent(
                      bgColor: appTheme.whiteA700,
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
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductsScreen(
                              item: item,
                            ),
                          ),
                        );
                      },
                      onWishlistClick: () async {
                        SharedPreferenceHelper sp = SharedPreferenceHelper();
                        String? token = sp.getString('token');
                        late final WooCommerceApi apiWishlist = WooCommerceApi(
                            WooCommerceApi.WishlistDio(token ?? ""));
                        try {
                          Future<String> response =
                              apiWishlist.addWWishlist(item.id);
                          response.then(
                            (value) {
                              Map<String, dynamic> datas = jsonDecode(value);
                              if (datas['id'] == 0) {
                                ToastMessage.show(
                                    context, 'User, something went wrong!');
                              } else {
                                ToastMessage.show(
                                    context, 'Wishlist Added Successfully');
                              }
                            },
                          );
                        } catch (e) {
                          ToastMessage.show(context, "Wishlist add error: $e");
                        }
                      },
                    ),
                  ),
                );
              }).toList()
            : [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
      ),
    );
  }
}
