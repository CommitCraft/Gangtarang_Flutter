import 'dart:convert';

import 'package:collection/collection.dart';

class Attribute {
	int? id;
	String? name;
	String? slug;
	int? position;
	bool? visible;
	bool? variation;
	List? options;

	Attribute({
		this.id, 
		this.name, 
		this.slug, 
		this.position, 
		this.visible, 
		this.variation, 
		this.options, 
	});

	@override
	String toString() {
		return 'Attribute(id: $id, name: $name, slug: $slug, position: $position, visible: $visible, variation: $variation, options: $options)';
	}

	factory Attribute.fromMap(Map<String, Object?> data) => Attribute(
				id: data['id'] as int?,
				name: data['name'] as String?,
				slug: data['slug'] as String?,
				position: data['position'] as int?,
				visible: data['visible'] as bool?,
				variation: data['variation'] as bool?,
				options: data['options'] as List?,
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'name': name,
				'slug': slug,
				'position': position,
				'visible': visible,
				'variation': variation,
				'options': options,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attribute].
	factory Attribute.fromJson(String data) {
		return Attribute.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Attribute] to a JSON string.
	String toJson() => json.encode(toMap());

	Attribute copyWith({
		int? id,
		String? name,
		String? slug,
		int? position,
		bool? visible,
		bool? variation,
		List<String>? options,
	}) {
		return Attribute(
			id: id ?? this.id,
			name: name ?? this.name,
			slug: slug ?? this.slug,
			position: position ?? this.position,
			visible: visible ?? this.visible,
			variation: variation ?? this.variation,
			options: options ?? this.options,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Attribute) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			name.hashCode ^
			slug.hashCode ^
			position.hashCode ^
			visible.hashCode ^
			variation.hashCode ^
			options.hashCode;
}
