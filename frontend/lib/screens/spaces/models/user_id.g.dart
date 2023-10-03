// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserId _$UserIdFromJson(Map<String, dynamic> json) => UserId(
      id: json['_id'] as String,
      name: json['name'] as String,
      uid: json['userName'] as String,
      email: json['email'] as String,
      isLeave: json['isLeave'] as bool? ?? false,
    );

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'userName': instance.uid,
      'email': instance.email,
      'isLeave': instance.isLeave,
    };
