import 'dart:convert';

import 'package:collection/collection.dart';

class Image {
	int? id;
	String? dateCreated;
	String? dateCreatedGmt;
	String? dateModified;
	String? dateModifiedGmt;
	String? src;
	String? name;
	String? alt;

	Image({
		this.id, 
		this.dateCreated, 
		this.dateCreatedGmt, 
		this.dateModified, 
		this.dateModifiedGmt, 
		this.src, 
		this.name, 
		this.alt, 
	});

	@override
	String toString() {
		return 'Image(id: $id, dateCreated: $dateCreated, dateCreatedGmt: $dateCreatedGmt, dateModified: $dateModified, dateModifiedGmt: $dateModifiedGmt, src: $src, name: $name, alt: $alt)';
	}

	factory Image.fromMap(Map<String, Object?> data) => Image(
				id: data['id'] as int?,
				dateCreated: data['date_created'] as String?,
				dateCreatedGmt: data['date_created_gmt'] as String?,
				dateModified: data['date_modified'] as String?,
				dateModifiedGmt: data['date_modified_gmt'] as String?,
				src: data['src'] as String?,
				name: data['name'] as String?,
				alt: data['alt'] as String?,
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'date_created': dateCreated,
				'date_created_gmt': dateCreatedGmt,
				'date_modified': dateModified,
				'date_modified_gmt': dateModifiedGmt,
				'src': src,
				'name': name,
				'alt': alt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Image].
	factory Image.fromJson(String data) {
		return Image.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Image] to a JSON string.
	String toJson() => json.encode(toMap());

	Image copyWith({
		int? id,
		String? dateCreated,
		String? dateCreatedGmt,
		String? dateModified,
		String? dateModifiedGmt,
		String? src,
		String? name,
		String? alt,
	}) {
		return Image(
			id: id ?? this.id,
			dateCreated: dateCreated ?? this.dateCreated,
			dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
			dateModified: dateModified ?? this.dateModified,
			dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
			src: src ?? this.src,
			name: name ?? this.name,
			alt: alt ?? this.alt,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Image) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			dateCreated.hashCode ^
			dateCreatedGmt.hashCode ^
			dateModified.hashCode ^
			dateModifiedGmt.hashCode ^
			src.hashCode ^
			name.hashCode ^
			alt.hashCode;
}
