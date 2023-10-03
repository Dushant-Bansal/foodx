// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceUsers _$SpaceUsersFromJson(Map<String, dynamic> json) => SpaceUsers(
      id: json['_id'] as String,
      uid: UserId.fromJson(json['userId'] as Map<String, dynamic>),
      role: $enumDecode(_$RoleEnumMap, json['roles']),
      isLeave: json['isLeave'] as bool? ?? false,
      status: $enumDecodeNullable(_$SpaceStatusEnumMap, json['status']) ??
          SpaceStatus.active,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$SpaceUsersToJson(SpaceUsers instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.uid,
      'roles': _$RoleEnumMap[instance.role]!,
      'isLeave': instance.isLeave,
      'status': _$SpaceStatusEnumMap[instance.status]!,
      'active': instance.active,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.collaborator: 'collaborator',
  Role.viewer: 'viewer',
};

const _$SpaceStatusEnumMap = {
  SpaceStatus.active: 'active',
  SpaceStatus.inactive: 'inactive',
};
