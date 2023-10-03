// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      id: json['_id'] as String,
      uid: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      active: json['active'] as bool? ?? true,
      status: $enumDecodeNullable(_$SpaceStatusEnumMap, json['status']) ??
          SpaceStatus.active,
      spaceUsers: (json['spaceUsers'] as List<dynamic>?)
              ?.map((e) => SpaceUsers.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'active': instance.active,
      'status': _$SpaceStatusEnumMap[instance.status]!,
      'spaceUsers': instance.spaceUsers,
    };

const _$SpaceStatusEnumMap = {
  SpaceStatus.active: 'active',
  SpaceStatus.inactive: 'inactive',
};
