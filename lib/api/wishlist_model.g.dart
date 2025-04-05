// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistResponse _$WishlistResponseFromJson(Map<String, dynamic> json) =>
    WishlistResponse(
      wishlist: Wishlist.fromJson(json['wishlist'] as Map<String, dynamic>),
      item: (json['item'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishlistResponseToJson(WishlistResponse instance) =>
    <String, dynamic>{
      'wishlist': instance.wishlist,
      'item': instance.item,
      'product': instance.product,
    };

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => Wishlist(
      id: (json['id'] as num).toInt(),
      privacy: json['privacy'],
      userId: json['user_id'] as String,
      sessionId: json['session_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      token: json['token'] as String,
      isDefault: json['is_default'] as String,
      dateAdded: DateAdded.fromJson(json['date_added'] as Map<String, dynamic>),
      expiration: json['expiration'],
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      'id': instance.id,
      'privacy': instance.privacy,
      'user_id': instance.userId,
      'session_id': instance.sessionId,
      'name': instance.name,
      'slug': instance.slug,
      'token': instance.token,
      'is_default': instance.isDefault,
      'date_added': instance.dateAdded,
      'expiration': instance.expiration,
    };

DateAdded _$DateAddedFromJson(Map<String, dynamic> json) => DateAdded(
      date: json['date'] as String,
      timezoneType: (json['timezone_type'] as num).toInt(),
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$DateAddedToJson(DateAdded instance) => <String, dynamic>{
      'date': instance.date,
      'timezone_type': instance.timezoneType,
      'timezone': instance.timezone,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      prodId: json['prod_id'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'prod_id': instance.prodId,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      price: json['price'] as String,
      regularPrice: json['regular_price'] as String,
      salePrice: json['sale_price'] as String,
      onSale: json['on_sale'] as bool,
      averageRating: _stringToDouble(json['average_rating'] as String),
      ratingCount: _stringToInt(json['rating_count'] as String),
      title: json['title'] as String,
      type: json['type'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'regular_price': instance.regularPrice,
      'sale_price': instance.salePrice,
      'on_sale': instance.onSale,
      'average_rating': instance.averageRating,
      'rating_count': instance.ratingCount,
      'title': instance.title,
      'type': instance.type,
      'image': instance.image,
    };
