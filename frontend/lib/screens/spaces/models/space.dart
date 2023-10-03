import 'package:food_x/screens/spaces/models/space_users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'space.g.dart';

enum SpaceStatus { active, inactive }

@JsonSerializable()
class Space {
  const Space({
    required this.id,
    required this.uid,
    required this.name,
    this.description,
    this.active = true,
    this.status = SpaceStatus.active,
    this.spaceUsers = const [],
  });

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'userId')
  final String uid;

  final String name;
  final String? description;

  @JsonKey(defaultValue: true)
  final bool active;

  @JsonKey(defaultValue: SpaceStatus.active)
  final SpaceStatus status;

  @JsonKey(defaultValue: [])
  final List<SpaceUsers> spaceUsers;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);
}
