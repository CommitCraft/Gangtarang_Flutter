// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      regularPrice: json['regular_price'] as String?,
      price: json['price'] as String,
      salePrice: json['sale_price'] as String?,
      averageRating: _stringToDouble(json['average_rating'] as String),
      reviewCount: (json['rating_count'] as num).toInt(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'regular_price': instance.regularPrice,
      'price': instance.price,
      'sale_price': instance.salePrice,
      'average_rating': instance.averageRating,
      'rating_count': instance.reviewCount,
      'images': instance.images,
    };

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      src: json['src'] as String,
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'src': instance.src,
    };
