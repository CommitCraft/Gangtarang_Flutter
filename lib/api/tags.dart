import 'package:json_annotation/json_annotation.dart';

part 'tags.g.dart';

@JsonSerializable()
class TagItem {
  final int? id;
  final String? name;
  final String? slug;

  TagItem({this.id, this.name, this.slug});

  factory TagItem.fromJson(Map<String, dynamic> json) => _$TagItemFromJson(json);

  Map<String, dynamic> toJson() => _$TagItemToJson(this);
}
