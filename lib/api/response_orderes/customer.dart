import 'package:collection/collection.dart';

class Customer {
	String? href;

	Customer({this.href});

	factory Customer.fromJson(Map<String, Object?> json) => Customer(
				href: json['href'] as String?,
			);

	Map<String, Object?> toJson() => {
				'href': href,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Customer) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => href.hashCode;
}
