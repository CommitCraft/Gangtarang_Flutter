import 'package:json_annotation/json_annotation.dart';

part 'categories_items.g.dart';

@JsonSerializable()
class CategoriesItems {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;
  final String display;
  final Image? image;


  CategoriesItems({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    required this.image,
   
  });

  factory CategoriesItems.fromJson(Map<String, dynamic> json) => _$CategoriesItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesItemsToJson(this);
}

@JsonSerializable()
class Image {
  final String? src;


  Image({
    required this.src,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Links {
  final List<HrefLink> self;
  final List<HrefLink> collection;

  Links({
    required this.self,
    required this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class HrefLink {
  final String href;

  HrefLink({
    required this.href,
  });

  factory HrefLink.fromJson(Map<String, dynamic> json) => _$HrefLinkFromJson(json);

  Map<String, dynamic> toJson() => _$HrefLinkToJson(this);
}
