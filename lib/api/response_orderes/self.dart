import 'package:collection/collection.dart';

class Self {
	String? href;

	Self({this.href});

	factory Self.fromJson(Map<String, Object?> json) => Self(
				href: json['href'] as String?,
			);

	Map<String, Object?> toJson() => {
				'href': href,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Self) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => href.hashCode;
}
