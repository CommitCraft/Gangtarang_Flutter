import 'package:collection/collection.dart';

class Shipping {
	String? firstName;
	String? lastName;
	String? address1;
	String? address2;
	String? city;
	String? state;
	String? postcode;
	String? country;

	Shipping({
		this.firstName, 
		this.lastName, 
		this.address1, 
		this.address2, 
		this.city, 
		this.state, 
		this.postcode, 
		this.country, 
	});

	factory Shipping.fromJson(Map<String, Object?> json) => Shipping(
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				address1: json['address_1'] as String?,
				address2: json['address_2'] as String?,
				city: json['city'] as String?,
				state: json['state'] as String?,
				postcode: json['postcode'] as String?,
				country: json['country'] as String?,
			);

	Map<String, Object?> toJson() => {
				'first_name': firstName,
				'last_name': lastName,
				'address_1': address1,
				'address_2': address2,
				'city': city,
				'state': state,
				'postcode': postcode,
				'country': country,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Shipping) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			firstName.hashCode ^
			lastName.hashCode ^
			address1.hashCode ^
			address2.hashCode ^
			city.hashCode ^
			state.hashCode ^
			postcode.hashCode ^
			country.hashCode;
}
