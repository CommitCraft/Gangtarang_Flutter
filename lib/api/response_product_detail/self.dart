import 'dart:convert';

import 'package:collection/collection.dart';

class Self {
	String? href;

	Self({this.href});

	@override
	String toString() => 'Self(href: $href)';

	factory Self.fromMap(Map<String, Object?> data) => Self(
				href: data['href'] as String?,
			);

	Map<String, Object?> toMap() => {
				'href': href,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Self].
	factory Self.fromJson(String data) {
		return Self.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Self] to a JSON string.
	String toJson() => json.encode(toMap());

	Self copyWith({
		String? href,
	}) {
		return Self(
			href: href ?? this.href,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Self) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => href.hashCode;
}
