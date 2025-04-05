import 'package:collection/collection.dart';

class LineItem {
	int? productId;
	int? quantity;
	int? variationId;

	LineItem({this.productId, this.quantity, this.variationId});

	factory LineItem.fromJson(Map<String, Object?> json) => LineItem(
				productId: json['product_id'] as int?,
				quantity: json['quantity'] as int?,
				variationId: json['variation_id'] as int?,
			);

	Map<String, Object?> toJson() => {
				'product_id': productId,
				'quantity': quantity,
				'variation_id': variationId,
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
			productId.hashCode ^
			quantity.hashCode ^
			variationId.hashCode;
}
