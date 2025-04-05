import 'package:collection/collection.dart';

class Collection {
	String? href;

	Collection({this.href});

	factory Collection.fromJson(Map<String, Object?> json) => Collection(
				href: json['href'] as String?,
			);

	Map<String, Object?> toJson() => {
				'href': href,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Collection) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => href.hashCode;
}
