import 'dart:convert';

import 'package:collection/collection.dart';

class Collection {
	String? href;

	Collection({this.href});

	@override
	String toString() => 'Collection(href: $href)';

	factory Collection.fromMap(Map<String, Object?> data) => Collection(
				href: data['href'] as String?,
			);

	Map<String, Object?> toMap() => {
				'href': href,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Collection].
	factory Collection.fromJson(String data) {
		return Collection.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Collection] to a JSON string.
	String toJson() => json.encode(toMap());

	Collection copyWith({
		String? href,
	}) {
		return Collection(
			href: href ?? this.href,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Collection) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => href.hashCode;
}
