import 'package:collection/collection.dart';

import 'tax.dart';

class LineItem {
	int? id;
	String? name;
	String? image;
	int? productId;
	int? variationId;
	int? quantity;
	String? taxClass;
	String? subtotal;
	String? subtotalTax;
	String? total;
	String? totalTax;
	List<Tax>? taxes;
	List<dynamic>? metaData;
	String? sku;
	int? price;

	LineItem({
		this.id, 
		this.name, 
		this.image, 
		this.productId, 
		this.variationId, 
		this.quantity, 
		this.taxClass, 
		this.subtotal, 
		this.subtotalTax, 
		this.total, 
		this.totalTax, 
		this.taxes, 
		this.metaData, 
		this.sku, 
		this.price, 
	});

	factory LineItem.fromJson(Map<String, Object?> json) => LineItem(
				id: json['id'] as int?,
				name: json['name'] as String?,
				image: json['image'] as String?,
				productId: json['product_id'] as int?,
				variationId: json['variation_id'] as int?,
				quantity: json['quantity'] as int?,
				taxClass: json['tax_class'] as String?,
				subtotal: json['subtotal'] as String?,
				subtotalTax: json['subtotal_tax'] as String?,
				total: json['total'] as String?,
				totalTax: json['total_tax'] as String?,
				taxes: (json['taxes'] as List<dynamic>?)
						?.map((e) => Tax.fromJson(e as Map<String, Object?>))
						.toList(),
				metaData: json['meta_data'] as List<dynamic>?,
				sku: json['sku'] as String?,
				price: json['price'] as int?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'name': name,
				'image': image,
				'product_id': productId,
				'variation_id': variationId,
				'quantity': quantity,
				'tax_class': taxClass,
				'subtotal': subtotal,
				'subtotal_tax': subtotalTax,
				'total': total,
				'total_tax': totalTax,
				'taxes': taxes?.map((e) => e.toJson()).toList(),
				'meta_data': metaData,
				'sku': sku,
				'price': price,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! LineItem) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			name.hashCode ^
			image.hashCode ^
			productId.hashCode ^
			variationId.hashCode ^
			quantity.hashCode ^
			taxClass.hashCode ^
			subtotal.hashCode ^
			subtotalTax.hashCode ^
			total.hashCode ^
			totalTax.hashCode ^
			taxes.hashCode ^
			metaData.hashCode ^
			sku.hashCode ^
			price.hashCode;
}
