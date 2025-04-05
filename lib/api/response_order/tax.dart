import 'package:collection/collection.dart';

class Tax {
	int? id;
	String? total;
	String? subtotal;

	Tax({this.id, this.total, this.subtotal});

	factory Tax.fromJson(Map<String, Object?> json) => Tax(
				id: json['id'] as int?,
				total: json['total'] as String?,
				subtotal: json['subtotal'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'total': total,
				'subtotal': subtotal,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Tax) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ total.hashCode ^ subtotal.hashCode;
}
