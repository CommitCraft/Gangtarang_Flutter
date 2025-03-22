import 'package:collection/collection.dart';

import 'billing.dart';
import 'line_item.dart';
import 'shipping.dart';
import 'shipping_line.dart';

class Orders {
	String? paymentMethod;
	String? paymentMethodTitle;
	int? customer_id;
	bool? setPaid;
	Billing? billing;
	Shipping? shipping;
	List<LineItem>? lineItems;
	List<ShippingLine>? shippingLines;

	Orders({
		this.paymentMethod, 
		this.paymentMethodTitle, 
		this.customer_id, 
		this.setPaid, 
		this.billing, 
		this.shipping, 
		this.lineItems, 
		this.shippingLines, 
	});

	factory Orders.fromJson(Map<String, Object?> json) => Orders(
				paymentMethod: json['payment_method'] as String?,
				paymentMethodTitle: json['payment_method_title'] as String?,
				customer_id: json['customer_id'] as int?,
				setPaid: json['set_paid'] as bool?,
				billing: json['billing'] == null
						? null
						: Billing.fromJson(json['billing']! as Map<String, Object?>),
				shipping: json['shipping'] == null
						? null
						: Shipping.fromJson(json['shipping']! as Map<String, Object?>),
				lineItems: (json['line_items'] as List<dynamic>?)
						?.map((e) => LineItem.fromJson(e as Map<String, Object?>))
						.toList(),
				shippingLines: (json['shipping_lines'] as List<dynamic>?)
						?.map((e) => ShippingLine.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'payment_method': paymentMethod,
				'payment_method_title': paymentMethodTitle,
				'customer_id': customer_id,
				'set_paid': setPaid,
				'billing': billing?.toJson(),
				'shipping': shipping?.toJson(),
				'line_items': lineItems?.map((e) => e.toJson()).toList(),
				'shipping_lines': shippingLines?.map((e) => e.toJson()).toList(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Orders) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			paymentMethod.hashCode ^
			paymentMethodTitle.hashCode ^
			customer_id.hashCode ^
			setPaid.hashCode ^
			billing.hashCode ^
			shipping.hashCode ^
			lineItems.hashCode ^
			shippingLines.hashCode;
}
