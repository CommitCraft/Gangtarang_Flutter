import 'package:collection/collection.dart';

import 'collection.dart';
import 'customer.dart';
import 'self.dart';

class Links {
	List<Self>? self;
	List<Collection>? collection;
	List<Customer>? customer;

	Links({this.self, this.collection, this.customer});

	factory Links.fromJson(Map<String, Object?> json) => Links(
				self: (json['self'] as List<dynamic>?)
						?.map((e) => Self.fromJson(e as Map<String, Object?>))
						.toList(),
				collection: (json['collection'] as List<dynamic>?)
						?.map((e) => Collection.fromJson(e as Map<String, Object?>))
						.toList(),
				customer: (json['customer'] as List<dynamic>?)
						?.map((e) => Customer.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'self': self?.map((e) => e.toJson()).toList(),
				'collection': collection?.map((e) => e.toJson()).toList(),
				'customer': customer?.map((e) => e.toJson()).toList(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Links) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => self.hashCode ^ collection.hashCode ^ customer.hashCode;
}
