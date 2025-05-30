import 'package:collection/collection.dart';

class Billing {
	String? firstName;
	String? lastName;
	String? company;
	String? address1;
	String? address2;
	String? city;
	String? state;
	String? postcode;
	String? country;
	String? email;
	String? phone;

	Billing({
		this.firstName, 
		this.lastName, 
		this.company, 
		this.address1, 
		this.address2, 
		this.city, 
		this.state, 
		this.postcode, 
		this.country, 
		this.email, 
		this.phone, 
	});

	factory Billing.fromJson(Map<String, Object?> json) => Billing(
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				company: json['company'] as String?,
				address1: json['address_1'] as String?,
				address2: json['address_2'] as String?,
				city: json['city'] as String?,
				state: json['state'] as String?,
				postcode: json['postcode'] as String?,
				country: json['country'] as String?,
				email: json['email'] as String?,
				phone: json['phone'] as String?,
			);

	Map<String, Object?> toJson() => {
				'first_name': firstName,
				'last_name': lastName,
				'company': company,
				'address_1': address1,
				'address_2': address2,
				'city': city,
				'state': state,
				'postcode': postcode,
				'country': country,
				'email': email,
				'phone': phone,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Billing) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			firstName.hashCode ^
			lastName.hashCode ^
			company.hashCode ^
			address1.hashCode ^
			address2.hashCode ^
			city.hashCode ^
			state.hashCode ^
			postcode.hashCode ^
			country.hashCode ^
			email.hashCode ^
			phone.hashCode;
}
