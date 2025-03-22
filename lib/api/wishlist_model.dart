import 'package:json_annotation/json_annotation.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistResponse {
  final Wishlist wishlist;
  final List<Item> item;
  final List<Product>? product;

  WishlistResponse({
    required this.wishlist,
    required this.item,
    required this.product,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) => _$WishlistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistResponseToJson(this);
}

@JsonSerializable()
class Wishlist {
  final int id;
  final dynamic privacy;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'session_id')
  final String sessionId;
  final String name;
  final String slug;
  final String token;
  @JsonKey(name: 'is_default')
  final String isDefault;
  @JsonKey(name: 'date_added')
  final DateAdded dateAdded;
  final dynamic expiration;
  // final List<dynamic> metaData;

  Wishlist({
    required this.id,
    required this.privacy,
    required this.userId,
    required this.sessionId,
    required this.name,
    required this.slug,
    required this.token,
    required this.isDefault,
    required this.dateAdded,
    required this.expiration,
    // required this.metaData,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}

@JsonSerializable()
class DateAdded {
  final String date;
  @JsonKey(name: 'timezone_type')
  final int timezoneType;
  final String timezone;

  DateAdded({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory DateAdded.fromJson(Map<String, dynamic> json) => _$DateAddedFromJson(json);

  Map<String, dynamic> toJson() => _$DateAddedToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'prod_id')
  final String prodId;

  Item({required this.prodId});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Product {
  final String id;
  final String price;
  @JsonKey(name: 'regular_price')
  final String regularPrice;
  @JsonKey(name: 'sale_price')
  final String salePrice;
  @JsonKey(name: 'on_sale')
  final bool onSale;
  @JsonKey(name: 'average_rating', fromJson: _stringToDouble)
  final double averageRating;
  @JsonKey(name: 'rating_count', fromJson: _stringToInt)
  final int ratingCount;
  final String title;
  final String type;
  final String image;

  Product({
    required this.id,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.averageRating,
    required this.ratingCount,
    required this.title,
    required this.type,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// Custom functions to parse string to double and int
double _stringToDouble(String str) => double.tryParse(str) ?? 0.0;

int _stringToInt(String str) => int.tryParse(str) ?? 0;

