import 'package:collection/collection.dart';

class Attribute {
	int? id;
	String? name;
	String? slug;
	int? position;
	bool? visible;
	bool? variation;
	List<String>? options;

	Attribute({
		this.id, 
		this.name, 
		this.slug, 
		this.position, 
		this.visible, 
		this.variation, 
		this.options, 
	});

	factory Attribute.fromJson(Map<String, Object?> json) => Attribute(
				id: json['id'] as int?,
				name: json['name'] as String?,
				slug: json['slug'] as String?,
				position: json['position'] as int?,
				visible: json['visible'] as bool?,
				variation: json['variation'] as bool?,
				options: json['options'] as List<String>?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'name': name,
				'slug': slug,
				'position': position,
				'visible': visible,
				'variation': variation,
				'options': options,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Attribute) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
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
