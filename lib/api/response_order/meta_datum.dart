import 'package:collection/collection.dart';

class MetaDatum {
	int? id;
	String? key;
	String? value;

	MetaDatum({this.id, this.key, this.value});

	factory MetaDatum.fromJson(Map<String, Object?> json) => MetaDatum(
				id: json['id'] as int?,
				key: json['key'] as String?,
				value: json['value'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'key': key,
				'value': value,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! MetaDatum) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ key.hashCode ^ value.hashCode;
}
