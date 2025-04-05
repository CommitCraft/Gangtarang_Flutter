import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Products {
  final int id; 
  final String name;
  @JsonKey(name: 'regular_price')
  final String? regularPrice;
  final String price;
  @JsonKey(name: 'sale_price')
  final String? salePrice;
  @JsonKey(name: 'average_rating', fromJson: _stringToDouble)
  final double averageRating;
  @JsonKey(name: 'rating_count')
  final int reviewCount;
  final List<ProductImage> images;

  Products({
    required this.id,
    required this.name,
    required this.regularPrice,
    required this.price,
    required this.salePrice,
    required this.averageRating,
    required this.reviewCount,
    required this.images,
  });

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

// Custom function to parse string to double
double _stringToDouble(String str) => double.tryParse(str) ?? 0.0;

@JsonSerializable()
class ProductImage {
  final String src;

  ProductImage({required this.src});

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
