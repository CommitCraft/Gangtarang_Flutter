import 'dart:convert';

import 'package:collection/collection.dart';

class MetaDatum {
	int? id;
	String? key;
	dynamic value;

	MetaDatum({this.id, this.key, this.value});

	@override
	String toString() => 'MetaDatum(id: $id, key: $key, value: $value)';

	factory MetaDatum.fromMap(Map<String, Object?> data) => MetaDatum(
				id: data['id'] as int?,
				key: data['key'] as String?,
				value: data['value'] as dynamic,
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'key': key,
				'value': value,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MetaDatum].
	factory MetaDatum.fromJson(String data) {
		return MetaDatum.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [MetaDatum] to a JSON string.
	String toJson() => json.encode(toMap());

	MetaDatum copyWith({
		int? id,
		String? key,
		List<dynamic>? value,
	}) {
		return MetaDatum(
			id: id ?? this.id,
			key: key ?? this.key,
			value: value ?? this.value,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! MetaDatum) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => id.hashCode ^ key.hashCode ^ value.hashCode;
}
