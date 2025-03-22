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

	factory Image.fromJson(Map<String, Object?> json) => Image(
				id: json['id'] as int?,
				dateCreated: json['date_created'] as String?,
				dateCreatedGmt: json['date_created_gmt'] as String?,
				dateModified: json['date_modified'] as String?,
				dateModifiedGmt: json['date_modified_gmt'] as String?,
				src: json['src'] as String?,
				name: json['name'] as String?,
				alt: json['alt'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'date_created': dateCreated,
				'date_created_gmt': dateCreatedGmt,
				'date_modified': dateModified,
				'date_modified_gmt': dateModifiedGmt,
				'src': src,
				'name': name,
				'alt': alt,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Image) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
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
