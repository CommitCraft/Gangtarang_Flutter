import 'package:collection/collection.dart';

class ShippingLine {
	String? methodId;
	String? methodTitle;
	String? total;

	ShippingLine({this.methodId, this.methodTitle, this.total});

	factory ShippingLine.fromJson(Map<String, Object?> json) => ShippingLine(
				methodId: json['method_id'] as String?,
				methodTitle: json['method_title'] as String?,
				total: json['total'] as String?,
			);

	Map<String, Object?> toJson() => {
				'method_id': methodId,
				'method_title': methodTitle,
				'total': total,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ShippingLine) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			methodId.hashCode ^
			methodTitle.hashCode ^
			total.hashCode;
}
