import 'package:collection/collection.dart';

class Category {
	int? id;
	String? name;
	String? slug;

	Category({this.id, this.name, this.slug});

	factory Category.fromJson(Map<String, Object?> json) => Category(
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
		if (other is! Category) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
