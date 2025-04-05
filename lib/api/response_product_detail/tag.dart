import 'dart:convert';

import 'package:collection/collection.dart';

class Tag {
	int? id;
	String? name;
	String? slug;

	Tag({this.id, this.name, this.slug});

	@override
	String toString() => 'Tag(id: $id, name: $name, slug: $slug)';

	factory Tag.fromMap(Map<String, Object?> data) => Tag(
				id: data['id'] as int?,
				name: data['name'] as String?,
				slug: data['slug'] as String?,
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'name': name,
				'slug': slug,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tag].
	factory Tag.fromJson(String data) {
		return Tag.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Tag] to a JSON string.
	String toJson() => json.encode(toMap());

	Tag copyWith({
		int? id,
		String? name,
		String? slug,
	}) {
		return Tag(
			id: id ?? this.id,
			name: name ?? this.name,
			slug: slug ?? this.slug,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Tag) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
