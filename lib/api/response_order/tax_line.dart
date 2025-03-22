import 'package:collection/collection.dart';

class TaxLine {
	int? id;
	String? rateCode;
	int? rateId;
	String? label;
	bool? compound;
	String? taxTotal;
	String? shippingTaxTotal;
	List<dynamic>? metaData;

	TaxLine({
		this.id, 
		this.rateCode, 
		this.rateId, 
		this.label, 
		this.compound, 
		this.taxTotal, 
		this.shippingTaxTotal, 
		this.metaData, 
	});

	factory TaxLine.fromJson(Map<String, Object?> json) => TaxLine(
				id: json['id'] as int?,
				rateCode: json['rate_code'] as String?,
				rateId: json['rate_id'] as int?,
				label: json['label'] as String?,
				compound: json['compound'] as bool?,
				taxTotal: json['tax_total'] as String?,
				shippingTaxTotal: json['shipping_tax_total'] as String?,
				metaData: json['meta_data'] as List<dynamic>?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'rate_code': rateCode,
				'rate_id': rateId,
				'label': label,
				'compound': compound,
				'tax_total': taxTotal,
				'shipping_tax_total': shippingTaxTotal,
				'meta_data': metaData,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! TaxLine) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			rateCode.hashCode ^
			rateId.hashCode ^
			label.hashCode ^
			compound.hashCode ^
			taxTotal.hashCode ^
			shippingTaxTotal.hashCode ^
			metaData.hashCode;
}
