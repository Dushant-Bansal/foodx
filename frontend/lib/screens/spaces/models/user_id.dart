import 'package:json_annotation/json_annotation.dart';

part 'user_id.g.dart';

@JsonSerializable()
class UserId {
  const UserId({
    required this.id,
    required this.name,
    required this.uid,
    required this.email,
    this.isLeave = false,
  });

  @JsonKey(name: '_id')
  final String id;

  final String name;

  @JsonKey(name: 'userName')
  final String uid;

  final String email;

  @JsonKey(defaultValue: false)
  final bool isLeave;

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdToJson(this);
}
