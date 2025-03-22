import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final String productId;
  final String productName;
  final String productImage;
  final double rating;
  final int reviewCount;
  final int salePrice;
  final int regularPrice;
  final int discount;
  final String returnLabel;
  final int itemCount;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.rating,
    required this.reviewCount,
    required this.salePrice,
    required this.regularPrice,
    required this.discount,
    required this.returnLabel,
    required this.itemCount,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
