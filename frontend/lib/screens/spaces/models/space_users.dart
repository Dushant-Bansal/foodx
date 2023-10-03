import 'package:food_x/screens/spaces/models/user_id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'invited_users.dart';
import 'space.dart';

part 'space_users.g.dart';

@JsonSerializable()
class SpaceUsers {
  const SpaceUsers({
    required this.id,
    required this.uid,
    required this.role,
    this.isLeave = false,
    this.status = SpaceStatus.active,
    this.active = true,
  });

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'userId')
  final UserId uid;

  @JsonKey(name: 'roles')
  final Role role;

  @JsonKey(defaultValue: false)
  final bool isLeave;

  @JsonKey(defaultValue: SpaceStatus.active)
  final SpaceStatus status;

  @JsonKey(defaultValue: true)
  final bool active;

  factory SpaceUsers.fromJson(Map<String, dynamic> json) =>
      _$SpaceUsersFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceUsersToJson(this);
}
