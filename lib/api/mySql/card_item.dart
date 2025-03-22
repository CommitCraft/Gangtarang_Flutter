import 'package:collection/collection.dart';

class Cards {
	String? cardNo;
	String? name;
	String? expire;
	String? cvv;
	String? type;
	String? bg;

	Cards({
		this.cardNo, 
		this.name, 
		this.expire, 
		this.cvv, 
		this.type, 
		this.bg, 
	});

	factory Cards.fromJson(Map<String, Object?> json) => Cards(
				cardNo: json['cardNo'] as String?,
				name: json['name'] as String?,
				expire: json['expire'] as String?,
				cvv: json['cvv'] as String?,
				type: json['type'] as String?,
				bg: json['bg'] as String?,
			);

	Map<String, Object?> toJson() => {
				'cardNo': cardNo,
				'name': name,
				'expire': expire,
				'cvv': cvv,
				'type': type,
				'bg': bg,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Cards) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			cardNo.hashCode ^
			name.hashCode ^
			expire.hashCode ^
			cvv.hashCode ^
			type.hashCode ^
			bg.hashCode;
}
