// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invited_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitedUsers _$InvitedUsersFromJson(Map<String, dynamic> json) => InvitedUsers(
      id: json['_id'] as String,
      by: json['by'] as String,
      role: $enumDecode(_$RoleEnumMap, json['roles']),
      spaceId: json['spaceId'] as String,
      addedBy: json['addedBy'] as String,
      status: $enumDecodeNullable(_$InvitedUserStatusEnumMap, json['status']) ??
          InvitedUserStatus.pending,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$InvitedUsersToJson(InvitedUsers instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'by': instance.by,
      'roles': _$RoleEnumMap[instance.role]!,
      'spaceId': instance.spaceId,
      'addedBy': instance.addedBy,
      'status': _$InvitedUserStatusEnumMap[instance.status]!,
      'active': instance.active,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.collaborator: 'collaborator',
  Role.viewer: 'viewer',
};

const _$InvitedUserStatusEnumMap = {
  InvitedUserStatus.pending: 'pending',
  InvitedUserStatus.joined: 'joined',
  InvitedUserStatus.rejected: 'rejected',
};
