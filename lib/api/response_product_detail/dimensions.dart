import 'dart:convert';

import 'package:collection/collection.dart';

class Dimensions {
	String? length;
	String? width;
	String? height;

	Dimensions({this.length, this.width, this.height});

	@override
	String toString() {
		return 'Dimensions(length: $length, width: $width, height: $height)';
	}

	factory Dimensions.fromMap(Map<String, Object?> data) => Dimensions(
				length: data['length'] as String?,
				width: data['width'] as String?,
				height: data['height'] as String?,
			);

	Map<String, Object?> toMap() => {
				'length': length,
				'width': width,
				'height': height,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Dimensions].
	factory Dimensions.fromJson(String data) {
		return Dimensions.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Dimensions] to a JSON string.
	String toJson() => json.encode(toMap());

	Dimensions copyWith({
		String? length,
		String? width,
		String? height,
	}) {
		return Dimensions(
			length: length ?? this.length,
			width: width ?? this.width,
			height: height ?? this.height,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Dimensions) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => length.hashCode ^ width.hashCode ^ height.hashCode;
}
