import 'package:collection/collection.dart';

class Dimensions {
	String? length;
	String? width;
	String? height;

	Dimensions({this.length, this.width, this.height});

	factory Dimensions.fromJson(Map<String, Object?> json) => Dimensions(
				length: json['length'] as String?,
				width: json['width'] as String?,
				height: json['height'] as String?,
			);

	Map<String, Object?> toJson() => {
				'length': length,
				'width': width,
				'height': height,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Dimensions) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => length.hashCode ^ width.hashCode ^ height.hashCode;
}
