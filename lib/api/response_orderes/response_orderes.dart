import 'package:collection/collection.dart';

import 'billing.dart';
import 'line_item.dart';
import 'links.dart';
import 'shipping.dart';
import 'shipping_line.dart';

class ResponseOrderes {
	int? id;
	int? parentId;
	String? status;
	String? currency;
	String? version;
	bool? pricesIncludeTax;
	String? dateCreated;
	String? dateModified;
	String? discountTotal;
	String? discountTax;
	String? shippingTotal;
	String? shippingTax;
	String? cartTax;
	String? total;
	String? totalTax;
	int? customerId;
	String? orderKey;
	Billing? billing;
	Shipping? shipping;
	String? paymentMethod;
	String? paymentMethodTitle;
	String? transactionId;
	String? customerIpAddress;
	String? customerUserAgent;
	String? createdVia;
	String? customerNote;
	dynamic dateCompleted;
	dynamic datePaid;
	String? cartHash;
	String? number;
	List<dynamic>? metaData;
	List<LineItem>? lineItems;
	List<dynamic>? taxLines;
	List<ShippingLine>? shippingLines;
	List<dynamic>? feeLines;
	List<dynamic>? couponLines;
	List<dynamic>? refunds;
	String? paymentUrl;
	bool? isEditable;
	bool? needsPayment;
	bool? needsProcessing;
	String? dateCreatedGmt;
	String? dateModifiedGmt;
	dynamic dateCompletedGmt;
	dynamic datePaidGmt;
	String? currencySymbol;
	Links? links;

	ResponseOrderes({
		this.id, 
		this.parentId, 
		this.status, 
		this.currency, 
		this.version, 
		this.pricesIncludeTax, 
		this.dateCreated, 
		this.dateModified, 
		this.discountTotal, 
		this.discountTax, 
		this.shippingTotal, 
		this.shippingTax, 
		this.cartTax, 
		this.total, 
		this.totalTax, 
		this.customerId, 
		this.orderKey, 
		this.billing, 
		this.shipping, 
		this.paymentMethod, 
		this.paymentMethodTitle, 
		this.transactionId, 
		this.customerIpAddress, 
		this.customerUserAgent, 
		this.createdVia, 
		this.customerNote, 
		this.dateCompleted, 
		this.datePaid, 
		this.cartHash, 
		this.number, 
		this.metaData, 
		this.lineItems, 
		this.taxLines, 
		this.shippingLines, 
		this.feeLines, 
		this.couponLines, 
		this.refunds, 
		this.paymentUrl, 
		this.isEditable, 
		this.needsPayment, 
		this.needsProcessing, 
		this.dateCreatedGmt, 
		this.dateModifiedGmt, 
		this.dateCompletedGmt, 
		this.datePaidGmt, 
		this.currencySymbol, 
		this.links, 
	});

	factory ResponseOrderes.fromJson(Map<String, Object?> json) {
		return ResponseOrderes(
			id: json['id'] as int?,
			parentId: json['parent_id'] as int?,
			status: json['status'] as String?,
			currency: json['currency'] as String?,
			version: json['version'] as String?,
			pricesIncludeTax: json['prices_include_tax'] as bool?,
			dateCreated: json['date_created'] as String?,
			dateModified: json['date_modified'] as String?,
			discountTotal: json['discount_total'] as String?,
			discountTax: json['discount_tax'] as String?,
			shippingTotal: json['shipping_total'] as String?,
			shippingTax: json['shipping_tax'] as String?,
			cartTax: json['cart_tax'] as String?,
			total: json['total'] as String?,
			totalTax: json['total_tax'] as String?,
			customerId: json['customer_id'] as int?,
			orderKey: json['order_key'] as String?,
			billing: json['billing'] == null
						? null
						: Billing.fromJson(json['billing']! as Map<String, Object?>),
			shipping: json['shipping'] == null
						? null
						: Shipping.fromJson(json['shipping']! as Map<String, Object?>),
			paymentMethod: json['payment_method'] as String?,
			paymentMethodTitle: json['payment_method_title'] as String?,
			transactionId: json['transaction_id'] as String?,
			customerIpAddress: json['customer_ip_address'] as String?,
			customerUserAgent: json['customer_user_agent'] as String?,
			createdVia: json['created_via'] as String?,
			customerNote: json['customer_note'] as String?,
			dateCompleted: json['date_completed'] as dynamic,
			datePaid: json['date_paid'] as dynamic,
			cartHash: json['cart_hash'] as String?,
			number: json['number'] as String?,
			metaData: json['meta_data'] as List<dynamic>?,
			lineItems: (json['line_items'] as List<dynamic>?)
						?.map((e) => LineItem.fromJson(e as Map<String, Object?>))
						.toList(),
			taxLines: json['tax_lines'] as List<dynamic>?,
			shippingLines: (json['shipping_lines'] as List<dynamic>?)
						?.map((e) => ShippingLine.fromJson(e as Map<String, Object?>))
						.toList(),
			feeLines: json['fee_lines'] as List<dynamic>?,
			couponLines: json['coupon_lines'] as List<dynamic>?,
			refunds: json['refunds'] as List<dynamic>?,
			paymentUrl: json['payment_url'] as String?,
			isEditable: json['is_editable'] as bool?,
			needsPayment: json['needs_payment'] as bool?,
			needsProcessing: json['needs_processing'] as bool?,
			dateCreatedGmt: json['date_created_gmt'] as String?,
			dateModifiedGmt: json['date_modified_gmt'] as String?,
			dateCompletedGmt: json['date_completed_gmt'] as dynamic,
			datePaidGmt: json['date_paid_gmt'] as dynamic,
			currencySymbol: json['currency_symbol'] as String?,
			links: json['_links'] == null
						? null
						: Links.fromJson(json['_links']! as Map<String, Object?>),
		);
	}



	Map<String, Object?> toJson() => {
				'id': id,
				'parent_id': parentId,
				'status': status,
				'currency': currency,
				'version': version,
				'prices_include_tax': pricesIncludeTax,
				'date_created': dateCreated,
				'date_modified': dateModified,
				'discount_total': discountTotal,
				'discount_tax': discountTax,
				'shipping_total': shippingTotal,
				'shipping_tax': shippingTax,
				'cart_tax': cartTax,
				'total': total,
				'total_tax': totalTax,
				'customer_id': customerId,
				'order_key': orderKey,
				'billing': billing?.toJson(),
				'shipping': shipping?.toJson(),
				'payment_method': paymentMethod,
				'payment_method_title': paymentMethodTitle,
				'transaction_id': transactionId,
				'customer_ip_address': customerIpAddress,
				'customer_user_agent': customerUserAgent,
				'created_via': createdVia,
				'customer_note': customerNote,
				'date_completed': dateCompleted,
				'date_paid': datePaid,
				'cart_hash': cartHash,
				'number': number,
				'meta_data': metaData,
				'line_items': lineItems?.map((e) => e.toJson()).toList(),
				'tax_lines': taxLines,
				'shipping_lines': shippingLines?.map((e) => e.toJson()).toList(),
				'fee_lines': feeLines,
				'coupon_lines': couponLines,
				'refunds': refunds,
				'payment_url': paymentUrl,
				'is_editable': isEditable,
				'needs_payment': needsPayment,
				'needs_processing': needsProcessing,
				'date_created_gmt': dateCreatedGmt,
				'date_modified_gmt': dateModifiedGmt,
				'date_completed_gmt': dateCompletedGmt,
				'date_paid_gmt': datePaidGmt,
				'currency_symbol': currencySymbol,
				'_links': links?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ResponseOrderes) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			parentId.hashCode ^
			status.hashCode ^
			currency.hashCode ^
			version.hashCode ^
			pricesIncludeTax.hashCode ^
			dateCreated.hashCode ^
			dateModified.hashCode ^
			discountTotal.hashCode ^
			discountTax.hashCode ^
			shippingTotal.hashCode ^
			shippingTax.hashCode ^
			cartTax.hashCode ^
			total.hashCode ^
			totalTax.hashCode ^
			customerId.hashCode ^
			orderKey.hashCode ^
			billing.hashCode ^
			shipping.hashCode ^
			paymentMethod.hashCode ^
			paymentMethodTitle.hashCode ^
			transactionId.hashCode ^
			customerIpAddress.hashCode ^
			customerUserAgent.hashCode ^
			createdVia.hashCode ^
			customerNote.hashCode ^
			dateCompleted.hashCode ^
			datePaid.hashCode ^
			cartHash.hashCode ^
			number.hashCode ^
			metaData.hashCode ^
			lineItems.hashCode ^
			taxLines.hashCode ^
			shippingLines.hashCode ^
			feeLines.hashCode ^
			couponLines.hashCode ^
			refunds.hashCode ^
			paymentUrl.hashCode ^
			isEditable.hashCode ^
			needsPayment.hashCode ^
			needsProcessing.hashCode ^
			dateCreatedGmt.hashCode ^
			dateModifiedGmt.hashCode ^
			dateCompletedGmt.hashCode ^
			datePaidGmt.hashCode ^
			currencySymbol.hashCode ^
			links.hashCode;
}
