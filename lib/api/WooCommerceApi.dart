import 'dart:convert';

import 'package:amazmart/api/categories_items.dart';
import 'package:amazmart/api/config.dart';
import 'package:amazmart/api/coupons/coupons.dart';
import 'package:amazmart/api/customer.dart';
import 'package:amazmart/api/customer_response.dart';
import 'package:amazmart/api/orders/orders.dart';
import 'package:amazmart/api/product.dart';
import 'package:amazmart/api/response_orderes/response_orderes.dart';
import 'package:amazmart/api/system_status/system_status.dart';
import 'package:amazmart/api/tags.dart';
import 'package:amazmart/api/write_review.dart';
import 'package:amazmart/api/write_review_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:amazmart/api/wishlist_model.dart';



part 'WooCommerceApi.g.dart';

@RestApi(baseUrl: Config.baseUrl)
abstract class WooCommerceApi {
  factory WooCommerceApi(Dio dio, {String baseUrl}) = _WooCommerceApi;
  // Authentication setup
  static Dio createDio() {
    final dio = Dio();
    String consumerKey = Config.consumerKey;
    String consumerSecret = Config.consumerSecret;
    debugPrint("Token ::: ${ base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}");
    dio.options.headers['Authorization'] =
        'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
    return dio;
  }

  // Authentication setup
  static Dio WishlistDio(String token) {
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    return dio;
  }

  @GET("/wc/v3/customers/{id}")
  Future<Customer> getUserInfo(
    @Path("id") int id,
  );

@GET("/wc/v3/system_status")
Future<SystemStatus> getSystem_status();

  @PUT("/wc/v3/customers/{id}")
  Future<CustomerResponse> updateCustomer(
    @Path("id") int id,
    @Body() Customer customer,
  );

  // Orders
  @GET("/wc/v3/orders")
  Future<List<ResponseOrderes>> getOrderList(@Query('customer') int cid);

  @POST("/wc/v3/orders")
  @Header("Content-Type: application/json")
  Future<Orders> createOrder(@Body() Orders orders,);


  // Coupons
  @GET("/wc/v3/coupons")
  Future<List<Coupons>> getCoupons();

  // Products
  @GET("/wc/v3/products")
  Future<List<Products>> getProductList(@Query('category') int? catId, @Query('orderby')
  String? orderby , @Query('order') String? order , @Query('page') int? page );
  // Products only
  @GET("/wc/v3/products")
  Future<List<Products>> getProductListOnly(@Query('include') String ids);
  // Search Product only
  @GET("/wc/v3/products")
  Future<List<Products>> SearchProductListOnly(@Query('search') String searchText);

  @GET("/wc/v3/products/{id}")
  Future<String> getProductDetails(@Path("id") int id);

  // // Product Reviews
  // @GET("/wc/v3/products/reviews")
  // Future<List<ProductReview>> getProductReviews();

  @POST("/wc/v3/products/reviews")
  @Header("Content-Type: application/json")
  Future<WriteReviewResponse> createProductReview(@Body() WriteReview review);

  // Categories
  @GET("/wc/v3/products/categories")
  Future<List<CategoriesItems>> getCategories(@Query('parent') int parent);

  // Tags
  @GET("/wc/v3/products/tags")
  Future<List<TagItem>> getTags();

//wishlist
  @GET("/yith/wishlist/v1/wishlists")
  Future<List<WishlistResponse>> getWishlistList();

  @POST("/yith/wishlist/v1/wishlists/0/product/{pid}")
  Future<String> addWWishlist(@Path("pid") int pid);

 @DELETE("/yith/wishlist/v1/wishlists/{wid}/product/{pid}")
  @Header("Content-Type: application/json")
  Future<String> removeWishlist(@Path("wid") int wid, @Path("pid") int pid);
}
