import 'dart:convert';

import 'package:collection/collection.dart';

import 'attribute.dart';
import 'category.dart';
import 'dimensions.dart';
import 'image.dart';
import 'links.dart';
import 'meta_datum.dart';
import 'tag.dart';

class ResponseProductDetail {
	int? id;
	String? name;
	String? slug;
	String? permalink;
	String? dateCreated;
	String? dateCreatedGmt;
	String? dateModified;
	String? dateModifiedGmt;
	String? type;
	String? status;
	bool? featured;
	String? catalogVisibility;
	String? description;
	String? shortDescription;
	String? sku;
	String? price;
	String? regularPrice;
	String? salePrice;
	dynamic dateOnSaleFrom;
	dynamic dateOnSaleFromGmt;
	dynamic dateOnSaleTo;
	dynamic dateOnSaleToGmt;
	bool? onSale;
	bool? purchasable;
	int? totalSales;
	bool? virtual;
	bool? downloadable;
	List<dynamic>? downloads;
	int? downloadLimit;
	int? downloadExpiry;
	String? externalUrl;
	String? buttonText;
	String? taxStatus;
	String? taxClass;
	bool? manageStock;
	dynamic stockQuantity;
	String? backorders;
	bool? backordersAllowed;
	bool? backordered;
	dynamic lowStockAmount;
	bool? soldIndividually;
	String? weight;
	Dimensions? dimensions;
	bool? shippingRequired;
	bool? shippingTaxable;
	String? shippingClass;
	int? shippingClassId;
	bool? reviewsAllowed;
	String? averageRating;
	int? ratingCount;
	List<dynamic>? upsellIds;
	List<dynamic>? crossSellIds;
	int? parentId;
	String? purchaseNote;
	List<Category>? categories;
	List<Tag>? tags;
	List<Image>? images;
	List<Attribute>? attributes;
	List<dynamic>? defaultAttributes;
	List<dynamic>? variations;
	List<dynamic>? groupedProducts;
	int? menuOrder;
	String? priceHtml;
	List? relatedIds;
	List<MetaDatum>? metaData;
	String? stockStatus;
	bool? hasOptions;
	String? postPassword;
	String? globalUniqueId;
	Links? links;

	ResponseProductDetail({
		this.id, 
		this.name, 
		this.slug, 
		this.permalink, 
		this.dateCreated, 
		this.dateCreatedGmt, 
		this.dateModified, 
		this.dateModifiedGmt, 
		this.type, 
		this.status, 
		this.featured, 
		this.catalogVisibility, 
		this.description, 
		this.shortDescription, 
		this.sku, 
		this.price, 
		this.regularPrice, 
		this.salePrice, 
		this.dateOnSaleFrom, 
		this.dateOnSaleFromGmt, 
		this.dateOnSaleTo, 
		this.dateOnSaleToGmt, 
		this.onSale, 
		this.purchasable, 
		this.totalSales, 
		this.virtual, 
		this.downloadable, 
		this.downloads, 
		this.downloadLimit, 
		this.downloadExpiry, 
		this.externalUrl, 
		this.buttonText, 
		this.taxStatus, 
		this.taxClass, 
		this.manageStock, 
		this.stockQuantity, 
		this.backorders, 
		this.backordersAllowed, 
		this.backordered, 
		this.lowStockAmount, 
		this.soldIndividually, 
		this.weight, 
		this.dimensions, 
		this.shippingRequired, 
		this.shippingTaxable, 
		this.shippingClass, 
		this.shippingClassId, 
		this.reviewsAllowed, 
		this.averageRating, 
		this.ratingCount, 
		this.upsellIds, 
		this.crossSellIds, 
		this.parentId, 
		this.purchaseNote, 
		this.categories, 
		this.tags, 
		this.images, 
		this.attributes, 
		this.defaultAttributes, 
		this.variations, 
		this.groupedProducts, 
		this.menuOrder, 
		this.priceHtml, 
		this.relatedIds, 
		this.metaData, 
		this.stockStatus, 
		this.hasOptions, 
		this.postPassword, 
		this.globalUniqueId, 
		this.links, 
	});

	@override
	String toString() {
		return 'ResponseProductDetail(id: $id, name: $name, slug: $slug, permalink: $permalink, dateCreated: $dateCreated, dateCreatedGmt: $dateCreatedGmt, dateModified: $dateModified, dateModifiedGmt: $dateModifiedGmt, type: $type, status: $status, featured: $featured, catalogVisibility: $catalogVisibility, description: $description, shortDescription: $shortDescription, sku: $sku, price: $price, regularPrice: $regularPrice, salePrice: $salePrice, dateOnSaleFrom: $dateOnSaleFrom, dateOnSaleFromGmt: $dateOnSaleFromGmt, dateOnSaleTo: $dateOnSaleTo, dateOnSaleToGmt: $dateOnSaleToGmt, onSale: $onSale, purchasable: $purchasable, totalSales: $totalSales, virtual: $virtual, downloadable: $downloadable, downloads: $downloads, downloadLimit: $downloadLimit, downloadExpiry: $downloadExpiry, externalUrl: $externalUrl, buttonText: $buttonText, taxStatus: $taxStatus, taxClass: $taxClass, manageStock: $manageStock, stockQuantity: $stockQuantity, backorders: $backorders, backordersAllowed: $backordersAllowed, backordered: $backordered, lowStockAmount: $lowStockAmount, soldIndividually: $soldIndividually, weight: $weight, dimensions: $dimensions, shippingRequired: $shippingRequired, shippingTaxable: $shippingTaxable, shippingClass: $shippingClass, shippingClassId: $shippingClassId, reviewsAllowed: $reviewsAllowed, averageRating: $averageRating, ratingCount: $ratingCount, upsellIds: $upsellIds, crossSellIds: $crossSellIds, parentId: $parentId, purchaseNote: $purchaseNote, categories: $categories, tags: $tags, images: $images,  defaultAttributes: $defaultAttributes, variations: $variations, groupedProducts: $groupedProducts, menuOrder: $menuOrder, priceHtml: $priceHtml, metaData: $metaData, stockStatus: $stockStatus, hasOptions: $hasOptions, postPassword: $postPassword, globalUniqueId: $globalUniqueId, links: $links)';
	}

	factory ResponseProductDetail.fromMap(Map<String, Object?> data) {
		return ResponseProductDetail(
			id: data['id'] as int?,
			name: data['name'] as String?,
			slug: data['slug'] as String?,
			permalink: data['permalink'] as String?,
			dateCreated: data['date_created'] as String?,
			dateCreatedGmt: data['date_created_gmt'] as String?,
			dateModified: data['date_modified'] as String?,
			dateModifiedGmt: data['date_modified_gmt'] as String?,
			type: data['type'] as String?,
			status: data['status'] as String?,
			featured: data['featured'] as bool?,
			catalogVisibility: data['catalog_visibility'] as String?,
			description: data['description'] as String?,
			shortDescription: data['short_description'] as String?,
			sku: data['sku'] as String?,
			price: data['price'] as String?,
			regularPrice: data['regular_price'] as String?,
			salePrice: data['sale_price'] as String?,
			dateOnSaleFrom: data['date_on_sale_from'] as dynamic,
			dateOnSaleFromGmt: data['date_on_sale_from_gmt'] as dynamic,
			dateOnSaleTo: data['date_on_sale_to'] as dynamic,
			dateOnSaleToGmt: data['date_on_sale_to_gmt'] as dynamic,
			onSale: data['on_sale'] as bool?,
			purchasable: data['purchasable'] as bool?,
			totalSales: data['total_sales'] as int?,
			virtual: data['virtual'] as bool?,
			downloadable: data['downloadable'] as bool?,
			downloads: data['downloads'] as List<dynamic>?,
			downloadLimit: data['download_limit'] as int?,
			downloadExpiry: data['download_expiry'] as int?,
			externalUrl: data['external_url'] as String?,
			buttonText: data['button_text'] as String?,
			taxStatus: data['tax_status'] as String?,
			taxClass: data['tax_class'] as String?,
			manageStock: data['manage_stock'] as bool?,
			stockQuantity: data['stock_quantity'] as dynamic,
			backorders: data['backorders'] as String?,
			backordersAllowed: data['backorders_allowed'] as bool?,
			backordered: data['backordered'] as bool?,
			lowStockAmount: data['low_stock_amount'] as dynamic,
			soldIndividually: data['sold_individually'] as bool?,
			weight: data['weight'] as String?,
			dimensions: data['dimensions'] == null
						? null
						: Dimensions.fromMap(data['dimensions']! as Map<String, Object?>),
			shippingRequired: data['shipping_required'] as bool?,
			shippingTaxable: data['shipping_taxable'] as bool?,
			shippingClass: data['shipping_class'] as String?,
			shippingClassId: data['shipping_class_id'] as int?,
			reviewsAllowed: data['reviews_allowed'] as bool?,
			averageRating: data['average_rating'] as String?,
			ratingCount: data['rating_count'] as int?,
			upsellIds: data['upsell_ids'] as List<dynamic>?,
			crossSellIds: data['cross_sell_ids'] as List<dynamic>?,
			parentId: data['parent_id'] as int?,
			purchaseNote: data['purchase_note'] as String?,
			categories: (data['categories'] as List<dynamic>?)
						?.map((e) => Category.fromMap(e as Map<String, Object?>))
						.toList(),
			tags: (data['tags'] as List<dynamic>?)
						?.map((e) => Tag.fromMap(e as Map<String, Object?>))
						.toList(),
			images: (data['images'] as List<dynamic>?)
						?.map((e) => Image.fromMap(e as Map<String, Object?>))
						.toList(),
			attributes: (data['attributes'] as List<dynamic>?)
						?.map((e) => Attribute.fromMap(e as Map<String, Object?>))
						.toList(),
			defaultAttributes: data['default_attributes'] as List<dynamic>?,
			variations: data['variations'] as List<dynamic>?,
			groupedProducts: data['grouped_products'] as List<dynamic>?,
			menuOrder: data['menu_order'] as int?,
			priceHtml: data['price_html'] as String?,
			relatedIds: data['related_ids'] as List<dynamic>?,
			metaData: (data['meta_data'] as List<dynamic>?)
						?.map((e) => MetaDatum.fromMap(e as Map<String, Object?>))
						.toList(),
			stockStatus: data['stock_status'] as String?,
			hasOptions: data['has_options'] as bool?,
			postPassword: data['post_password'] as String?,
			globalUniqueId: data['global_unique_id'] as String?,
			links: data['_links'] == null
						? null
						: Links.fromMap(data['_links']! as Map<String, Object?>),
		);
	}



	Map<String, Object?> toMap() => {
				'id': id,
				'name': name,
				'slug': slug,
				'permalink': permalink,
				'date_created': dateCreated,
				'date_created_gmt': dateCreatedGmt,
				'date_modified': dateModified,
				'date_modified_gmt': dateModifiedGmt,
				'type': type,
				'status': status,
				'featured': featured,
				'catalog_visibility': catalogVisibility,
				'description': description,
				'short_description': shortDescription,
				'sku': sku,
				'price': price,
				'regular_price': regularPrice,
				'sale_price': salePrice,
				'date_on_sale_from': dateOnSaleFrom,
				'date_on_sale_from_gmt': dateOnSaleFromGmt,
				'date_on_sale_to': dateOnSaleTo,
				'date_on_sale_to_gmt': dateOnSaleToGmt,
				'on_sale': onSale,
				'purchasable': purchasable,
				'total_sales': totalSales,
				'virtual': virtual,
				'downloadable': downloadable,
				'downloads': downloads,
				'download_limit': downloadLimit,
				'download_expiry': downloadExpiry,
				'external_url': externalUrl,
				'button_text': buttonText,
				'tax_status': taxStatus,
				'tax_class': taxClass,
				'manage_stock': manageStock,
				'stock_quantity': stockQuantity,
				'backorders': backorders,
				'backorders_allowed': backordersAllowed,
				'backordered': backordered,
				'low_stock_amount': lowStockAmount,
				'sold_individually': soldIndividually,
				'weight': weight,
				'dimensions': dimensions?.toMap(),
				'shipping_required': shippingRequired,
				'shipping_taxable': shippingTaxable,
				'shipping_class': shippingClass,
				'shipping_class_id': shippingClassId,
				'reviews_allowed': reviewsAllowed,
				'average_rating': averageRating,
				'rating_count': ratingCount,
				'upsell_ids': upsellIds,
				'cross_sell_ids': crossSellIds,
				'parent_id': parentId,
				'purchase_note': purchaseNote,
				'categories': categories?.map((e) => e.toMap()).toList(),
				'tags': tags?.map((e) => e.toMap()).toList(),
				'images': images?.map((e) => e.toMap()).toList(),
				'attributes': attributes?.map((e) => e.toMap()).toList(),
				'default_attributes': defaultAttributes,
				'variations': variations,
				'grouped_products': groupedProducts,
				'menu_order': menuOrder,
				'price_html': priceHtml,
				'related_ids': relatedIds,
				'meta_data': metaData?.map((e) => e.toMap()).toList(),
				'stock_status': stockStatus,
				'has_options': hasOptions,
				'post_password': postPassword,
				'global_unique_id': globalUniqueId,
				'_links': links?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResponseProductDetail].
	factory ResponseProductDetail.fromJson(String data) {
		return ResponseProductDetail.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [ResponseProductDetail] to a JSON string.
	String toJson() => json.encode(toMap());

	ResponseProductDetail copyWith({
		int? id,
		String? name,
		String? slug,
		String? permalink,
		String? dateCreated,
		String? dateCreatedGmt,
		String? dateModified,
		String? dateModifiedGmt,
		String? type,
		String? status,
		bool? featured,
		String? catalogVisibility,
		String? description,
		String? shortDescription,
		String? sku,
		String? price,
		String? regularPrice,
		String? salePrice,
		dynamic dateOnSaleFrom,
		dynamic dateOnSaleFromGmt,
		dynamic dateOnSaleTo,
		dynamic dateOnSaleToGmt,
		bool? onSale,
		bool? purchasable,
		int? totalSales,
		bool? virtual,
		bool? downloadable,
		List<dynamic>? downloads,
		int? downloadLimit,
		int? downloadExpiry,
		String? externalUrl,
		String? buttonText,
		String? taxStatus,
		String? taxClass,
		bool? manageStock,
		dynamic stockQuantity,
		String? backorders,
		bool? backordersAllowed,
		bool? backordered,
		dynamic lowStockAmount,
		bool? soldIndividually,
		String? weight,
		Dimensions? dimensions,
		bool? shippingRequired,
		bool? shippingTaxable,
		String? shippingClass,
		int? shippingClassId,
		bool? reviewsAllowed,
		String? averageRating,
		int? ratingCount,
		List<dynamic>? upsellIds,
		List<dynamic>? crossSellIds,
		int? parentId,
		String? purchaseNote,
		List<Category>? categories,
		List<Tag>? tags,
		List<Image>? images,
		List<Attribute>? attributes,
		List<dynamic>? defaultAttributes,
		List<dynamic>? variations,
		List<dynamic>? groupedProducts,
		int? menuOrder,
		String? priceHtml,
		List<dynamic>? relatedIds,
		List<MetaDatum>? metaData,
		String? stockStatus,
		bool? hasOptions,
		String? postPassword,
		String? globalUniqueId,
		Links? links,
	}) {
		return ResponseProductDetail(
			id: id ?? this.id,
			name: name ?? this.name,
			slug: slug ?? this.slug,
			permalink: permalink ?? this.permalink,
			dateCreated: dateCreated ?? this.dateCreated,
			dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
			dateModified: dateModified ?? this.dateModified,
			dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
			type: type ?? this.type,
			status: status ?? this.status,
			featured: featured ?? this.featured,
			catalogVisibility: catalogVisibility ?? this.catalogVisibility,
			description: description ?? this.description,
			shortDescription: shortDescription ?? this.shortDescription,
			sku: sku ?? this.sku,
			price: price ?? this.price,
			regularPrice: regularPrice ?? this.regularPrice,
			salePrice: salePrice ?? this.salePrice,
			dateOnSaleFrom: dateOnSaleFrom ?? this.dateOnSaleFrom,
			dateOnSaleFromGmt: dateOnSaleFromGmt ?? this.dateOnSaleFromGmt,
			dateOnSaleTo: dateOnSaleTo ?? this.dateOnSaleTo,
			dateOnSaleToGmt: dateOnSaleToGmt ?? this.dateOnSaleToGmt,
			onSale: onSale ?? this.onSale,
			purchasable: purchasable ?? this.purchasable,
			totalSales: totalSales ?? this.totalSales,
			virtual: virtual ?? this.virtual,
			downloadable: downloadable ?? this.downloadable,
			downloads: downloads ?? this.downloads,
			downloadLimit: downloadLimit ?? this.downloadLimit,
			downloadExpiry: downloadExpiry ?? this.downloadExpiry,
			externalUrl: externalUrl ?? this.externalUrl,
			buttonText: buttonText ?? this.buttonText,
			taxStatus: taxStatus ?? this.taxStatus,
			taxClass: taxClass ?? this.taxClass,
			manageStock: manageStock ?? this.manageStock,
			stockQuantity: stockQuantity ?? this.stockQuantity,
			backorders: backorders ?? this.backorders,
			backordersAllowed: backordersAllowed ?? this.backordersAllowed,
			backordered: backordered ?? this.backordered,
			lowStockAmount: lowStockAmount ?? this.lowStockAmount,
			soldIndividually: soldIndividually ?? this.soldIndividually,
			weight: weight ?? this.weight,
			dimensions: dimensions ?? this.dimensions,
			shippingRequired: shippingRequired ?? this.shippingRequired,
			shippingTaxable: shippingTaxable ?? this.shippingTaxable,
			shippingClass: shippingClass ?? this.shippingClass,
			shippingClassId: shippingClassId ?? this.shippingClassId,
			reviewsAllowed: reviewsAllowed ?? this.reviewsAllowed,
			averageRating: averageRating ?? this.averageRating,
			ratingCount: ratingCount ?? this.ratingCount,
			upsellIds: upsellIds ?? this.upsellIds,
			crossSellIds: crossSellIds ?? this.crossSellIds,
			parentId: parentId ?? this.parentId,
			purchaseNote: purchaseNote ?? this.purchaseNote,
			categories: categories ?? this.categories,
			tags: tags ?? this.tags,
			images: images ?? this.images,
			attributes: attributes ?? this.attributes,
			defaultAttributes: defaultAttributes ?? this.defaultAttributes,
			variations: variations ?? this.variations,
			groupedProducts: groupedProducts ?? this.groupedProducts,
			menuOrder: menuOrder ?? this.menuOrder,
			priceHtml: priceHtml ?? this.priceHtml,
			relatedIds: relatedIds ?? this.relatedIds,
			metaData: metaData ?? this.metaData,
			stockStatus: stockStatus ?? this.stockStatus,
			hasOptions: hasOptions ?? this.hasOptions,
			postPassword: postPassword ?? this.postPassword,
			globalUniqueId: globalUniqueId ?? this.globalUniqueId,
			links: links ?? this.links,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ResponseProductDetail) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			name.hashCode ^
			slug.hashCode ^
			permalink.hashCode ^
			dateCreated.hashCode ^
			dateCreatedGmt.hashCode ^
			dateModified.hashCode ^
			dateModifiedGmt.hashCode ^
			type.hashCode ^
			status.hashCode ^
			featured.hashCode ^
			catalogVisibility.hashCode ^
			description.hashCode ^
			shortDescription.hashCode ^
			sku.hashCode ^
			price.hashCode ^
			regularPrice.hashCode ^
			salePrice.hashCode ^
			dateOnSaleFrom.hashCode ^
			dateOnSaleFromGmt.hashCode ^
			dateOnSaleTo.hashCode ^
			dateOnSaleToGmt.hashCode ^
			onSale.hashCode ^
			purchasable.hashCode ^
			totalSales.hashCode ^
			virtual.hashCode ^
			downloadable.hashCode ^
			downloads.hashCode ^
			downloadLimit.hashCode ^
			downloadExpiry.hashCode ^
			externalUrl.hashCode ^
			buttonText.hashCode ^
			taxStatus.hashCode ^
			taxClass.hashCode ^
			manageStock.hashCode ^
			stockQuantity.hashCode ^
			backorders.hashCode ^
			backordersAllowed.hashCode ^
			backordered.hashCode ^
			lowStockAmount.hashCode ^
			soldIndividually.hashCode ^
			weight.hashCode ^
			dimensions.hashCode ^
			shippingRequired.hashCode ^
			shippingTaxable.hashCode ^
			shippingClass.hashCode ^
			shippingClassId.hashCode ^
			reviewsAllowed.hashCode ^
			averageRating.hashCode ^
			ratingCount.hashCode ^
			upsellIds.hashCode ^
			crossSellIds.hashCode ^
			parentId.hashCode ^
			purchaseNote.hashCode ^
			categories.hashCode ^
			tags.hashCode ^
			images.hashCode ^
			attributes.hashCode ^
			defaultAttributes.hashCode ^
			variations.hashCode ^
			groupedProducts.hashCode ^
			menuOrder.hashCode ^
			priceHtml.hashCode ^
			relatedIds.hashCode ^
			metaData.hashCode ^
			stockStatus.hashCode ^
			hasOptions.hashCode ^
			postPassword.hashCode ^
			globalUniqueId.hashCode ^
			links.hashCode;
}
