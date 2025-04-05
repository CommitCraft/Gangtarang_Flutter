// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toInt(),
      regularPrice: (json['regularPrice'] as num).toInt(),
      discount: (json['discount'] as num).toInt(),
      returnLabel: json['returnLabel'] as String,
      itemCount: (json['itemCount'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'salePrice': instance.salePrice,
      'regularPrice': instance.regularPrice,
      'discount': instance.discount,
      'returnLabel': instance.returnLabel,
      'itemCount': instance.itemCount,
    };
