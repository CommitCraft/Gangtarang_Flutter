import 'dart:convert';

import 'package:collection/collection.dart';

class Category {
	int? id;
	String? name;
	String? slug;

	Category({this.id, this.name, this.slug});

	@override
	String toString() => 'Category(id: $id, name: $name, slug: $slug)';

	factory Category.fromMap(Map<String, Object?> data) => Category(
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
  /// Parses the string and returns the resulting Json object as [Category].
	factory Category.fromJson(String data) {
		return Category.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
	String toJson() => json.encode(toMap());

	Category copyWith({
		int? id,
		String? name,
		String? slug,
	}) {
		return Category(
			id: id ?? this.id,
			name: name ?? this.name,
			slug: slug ?? this.slug,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Category) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
