import 'package:collection/collection.dart';

import 'billing.dart';
import 'line_item.dart';
import 'links.dart';
import 'meta_datum.dart';
import 'shipping.dart';
import 'shipping_line.dart';
import 'tax_line.dart';

class ResponseOrder {
	int? id;
	int? parentId;
	String? number;
	String? orderKey;
	String? createdVia;
	String? version;
	String? status;
	String? currency;
	String? dateCreated;
	String? dateCreatedGmt;
	String? dateModified;
	String? dateModifiedGmt;
	String? discountTotal;
	String? discountTax;
	String? shippingTotal;
	String? shippingTax;
	String? cartTax;
	String? total;
	String? totalTax;
	bool? pricesIncludeTax;
	int? customerId;
	String? customerIpAddress;
	String? customerUserAgent;
	String? customerNote;
	Billing? billing;
	Shipping? shipping;
	String? paymentMethod;
	String? paymentMethodTitle;
	String? transactionId;
	String? datePaid;
	String? datePaidGmt;
	dynamic dateCompleted;
	dynamic dateCompletedGmt;
	String? cartHash;
	List<MetaDatum>? metaData;
	List<LineItem>? lineItems;
	List<TaxLine>? taxLines;
	List<ShippingLine>? shippingLines;
	List<dynamic>? feeLines;
	List<dynamic>? couponLines;
	List<dynamic>? refunds;
	Links? links;

	ResponseOrder({
		this.id, 
		this.parentId, 
		this.number, 
		this.orderKey, 
		this.createdVia, 
		this.version, 
		this.status, 
		this.currency, 
		this.dateCreated, 
		this.dateCreatedGmt, 
		this.dateModified, 
		this.dateModifiedGmt, 
		this.discountTotal, 
		this.discountTax, 
		this.shippingTotal, 
		this.shippingTax, 
		this.cartTax, 
		this.total, 
		this.totalTax, 
		this.pricesIncludeTax, 
		this.customerId, 
		this.customerIpAddress, 
		this.customerUserAgent, 
		this.customerNote, 
		this.billing, 
		this.shipping, 
		this.paymentMethod, 
		this.paymentMethodTitle, 
		this.transactionId, 
		this.datePaid, 
		this.datePaidGmt, 
		this.dateCompleted, 
		this.dateCompletedGmt, 
		this.cartHash, 
		this.metaData, 
		this.lineItems, 
		this.taxLines, 
		this.shippingLines, 
		this.feeLines, 
		this.couponLines, 
		this.refunds, 
		this.links, 
	});

	factory ResponseOrder.fromJson(Map<String, Object?> json) => ResponseOrder(
				id: json['id'] as int?,
				parentId: json['parent_id'] as int?,
				number: json['number'] as String?,
				orderKey: json['order_key'] as String?,
				createdVia: json['created_via'] as String?,
				version: json['version'] as String?,
				status: json['status'] as String?,
				currency: json['currency'] as String?,
				dateCreated: json['date_created'] as String?,
				dateCreatedGmt: json['date_created_gmt'] as String?,
				dateModified: json['date_modified'] as String?,
				dateModifiedGmt: json['date_modified_gmt'] as String?,
				discountTotal: json['discount_total'] as String?,
				discountTax: json['discount_tax'] as String?,
				shippingTotal: json['shipping_total'] as String?,
				shippingTax: json['shipping_tax'] as String?,
				cartTax: json['cart_tax'] as String?,
				total: json['total'] as String?,
				totalTax: json['total_tax'] as String?,
				pricesIncludeTax: json['prices_include_tax'] as bool?,
				customerId: json['customer_id'] as int?,
				customerIpAddress: json['customer_ip_address'] as String?,
				customerUserAgent: json['customer_user_agent'] as String?,
				customerNote: json['customer_note'] as String?,
				billing: json['billing'] == null
						? null
						: Billing.fromJson(json['billing']! as Map<String, Object?>),
				shipping: json['shipping'] == null
						? null
						: Shipping.fromJson(json['shipping']! as Map<String, Object?>),
				paymentMethod: json['payment_method'] as String?,
				paymentMethodTitle: json['payment_method_title'] as String?,
				transactionId: json['transaction_id'] as String?,
				datePaid: json['date_paid'] as String?,
				datePaidGmt: json['date_paid_gmt'] as String?,
				dateCompleted: json['date_completed'] as dynamic,
				dateCompletedGmt: json['date_completed_gmt'] as dynamic,
				cartHash: json['cart_hash'] as String?,
				metaData: (json['meta_data'] as List<dynamic>?)
						?.map((e) => MetaDatum.fromJson(e as Map<String, Object?>))
						.toList(),
				lineItems: (json['line_items'] as List<dynamic>?)
						?.map((e) => LineItem.fromJson(e as Map<String, Object?>))
						.toList(),
				taxLines: (json['tax_lines'] as List<dynamic>?)
						?.map((e) => TaxLine.fromJson(e as Map<String, Object?>))
						.toList(),
				shippingLines: (json['shipping_lines'] as List<dynamic>?)
						?.map((e) => ShippingLine.fromJson(e as Map<String, Object?>))
						.toList(),
				feeLines: json['fee_lines'] as List<dynamic>?,
				couponLines: json['coupon_lines'] as List<dynamic>?,
				refunds: json['refunds'] as List<dynamic>?,
				links: json['_links'] == null
						? null
						: Links.fromJson(json['_links']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'parent_id': parentId,
				'number': number,
				'order_key': orderKey,
				'created_via': createdVia,
				'version': version,
				'status': status,
				'currency': currency,
				'date_created': dateCreated,
				'date_created_gmt': dateCreatedGmt,
				'date_modified': dateModified,
				'date_modified_gmt': dateModifiedGmt,
				'discount_total': discountTotal,
				'discount_tax': discountTax,
				'shipping_total': shippingTotal,
				'shipping_tax': shippingTax,
				'cart_tax': cartTax,
				'total': total,
				'total_tax': totalTax,
				'prices_include_tax': pricesIncludeTax,
				'customer_id': customerId,
				'customer_ip_address': customerIpAddress,
				'customer_user_agent': customerUserAgent,
				'customer_note': customerNote,
				'billing': billing?.toJson(),
				'shipping': shipping?.toJson(),
				'payment_method': paymentMethod,
				'payment_method_title': paymentMethodTitle,
				'transaction_id': transactionId,
				'date_paid': datePaid,
				'date_paid_gmt': datePaidGmt,
				'date_completed': dateCompleted,
				'date_completed_gmt': dateCompletedGmt,
				'cart_hash': cartHash,
				'meta_data': metaData?.map((e) => e.toJson()).toList(),
				'line_items': lineItems?.map((e) => e.toJson()).toList(),
				'tax_lines': taxLines?.map((e) => e.toJson()).toList(),
				'shipping_lines': shippingLines?.map((e) => e.toJson()).toList(),
				'fee_lines': feeLines,
				'coupon_lines': couponLines,
				'refunds': refunds,
				'_links': links?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ResponseOrder) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			parentId.hashCode ^
			number.hashCode ^
			orderKey.hashCode ^
			createdVia.hashCode ^
			version.hashCode ^
			status.hashCode ^
			currency.hashCode ^
			dateCreated.hashCode ^
			dateCreatedGmt.hashCode ^
			dateModified.hashCode ^
			dateModifiedGmt.hashCode ^
			discountTotal.hashCode ^
			discountTax.hashCode ^
			shippingTotal.hashCode ^
			shippingTax.hashCode ^
			cartTax.hashCode ^
			total.hashCode ^
			totalTax.hashCode ^
			pricesIncludeTax.hashCode ^
			customerId.hashCode ^
			customerIpAddress.hashCode ^
			customerUserAgent.hashCode ^
			customerNote.hashCode ^
			billing.hashCode ^
			shipping.hashCode ^
			paymentMethod.hashCode ^
			paymentMethodTitle.hashCode ^
			transactionId.hashCode ^
			datePaid.hashCode ^
			datePaidGmt.hashCode ^
			dateCompleted.hashCode ^
			dateCompletedGmt.hashCode ^
			cartHash.hashCode ^
			metaData.hashCode ^
			lineItems.hashCode ^
			taxLines.hashCode ^
			shippingLines.hashCode ^
			feeLines.hashCode ^
			couponLines.hashCode ^
			refunds.hashCode ^
			links.hashCode;
}
