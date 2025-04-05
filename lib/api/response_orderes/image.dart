import 'package:collection/collection.dart';

class Image {
	String? id;
	String? src;

	Image({this.id, this.src});

	factory Image.fromJson(Map<String, Object?> json) => Image(
				id: json['id'] as String?,
				src: json['src'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'src': src,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Image) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ src.hashCode;
}
