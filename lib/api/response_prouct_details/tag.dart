import 'package:collection/collection.dart';

class Tag {
	int? id;
	String? name;
	String? slug;

	Tag({this.id, this.name, this.slug});

	factory Tag.fromJson(Map<String, Object?> json) => Tag(
				id: json['id'] as int?,
				name: json['name'] as String?,
				slug: json['slug'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'name': name,
				'slug': slug,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Tag) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
