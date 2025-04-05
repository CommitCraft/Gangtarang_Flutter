import 'dart:convert';

import 'package:collection/collection.dart';

import 'collection.dart';
import 'self.dart';

class Links {
	List<Self>? self;
	List<Collection>? collection;

	Links({this.self, this.collection});

	@override
	String toString() => 'Links(self: $self, collection: $collection)';

	factory Links.fromMap(Map<String, Object?> data) => Links(
				self: (data['self'] as List<dynamic>?)
						?.map((e) => Self.fromMap(e as Map<String, Object?>))
						.toList(),
				collection: (data['collection'] as List<dynamic>?)
						?.map((e) => Collection.fromMap(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toMap() => {
				'self': self?.map((e) => e.toMap()).toList(),
				'collection': collection?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Links].
	factory Links.fromJson(String data) {
		return Links.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Links] to a JSON string.
	String toJson() => json.encode(toMap());

	Links copyWith({
		List<Self>? self,
		List<Collection>? collection,
	}) {
		return Links(
			self: self ?? this.self,
			collection: collection ?? this.collection,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Links) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => self.hashCode ^ collection.hashCode;
}
