import 'package:json_annotation/json_annotation.dart';

part 'invited_users.g.dart';

enum Role { admin, collaborator, viewer }

extension RoleX on Role {
  bool get isAdmin => this == Role.admin;
}

enum InvitedUserStatus { pending, joined, rejected }

@JsonSerializable()
class InvitedUsers {
  const InvitedUsers({
    required this.id,
    required this.by,
    required this.role,
    required this.spaceId,
    required this.addedBy,
    this.status = InvitedUserStatus.pending,
    this.active = false,
  });

  @JsonKey(name: '_id')
  final String id;

  final String by;

  @JsonKey(name: 'roles')
  final Role role;

  final String spaceId;
  final String addedBy;

  @JsonKey(defaultValue: InvitedUserStatus.pending)
  final InvitedUserStatus status;

  @JsonKey(defaultValue: true)
  final bool active;

  factory InvitedUsers.fromJson(Map<String, dynamic> json) =>
      _$InvitedUsersFromJson(json);

  Map<String, dynamic> toJson() => _$InvitedUsersToJson(this);
}
