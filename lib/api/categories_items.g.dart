// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesItems _$CategoriesItemsFromJson(Map<String, dynamic> json) =>
    CategoriesItems(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      parent: (json['parent'] as num).toInt(),
      description: json['description'] as String,
      display: json['display'] as String,
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesItemsToJson(CategoriesItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'parent': instance.parent,
      'description': instance.description,
      'display': instance.display,
      'image': instance.image,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      src: json['src'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'src': instance.src,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      self: (json['self'] as List<dynamic>)
          .map((e) => HrefLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      collection: (json['collection'] as List<dynamic>)
          .map((e) => HrefLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
      'collection': instance.collection,
    };

HrefLink _$HrefLinkFromJson(Map<String, dynamic> json) => HrefLink(
      href: json['href'] as String,
    );

Map<String, dynamic> _$HrefLinkToJson(HrefLink instance) => <String, dynamic>{
      'href': instance.href,
    };
