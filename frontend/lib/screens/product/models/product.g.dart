// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      uid: json['userId'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      mfgDate: const DateTimeConvertor().fromJson(json['mfgDate'] as String),
      expDate: const DateTimeConvertor().fromJson(json['expDate'] as String),
      description: json['description'] as String?,
      status:
          $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.active,
      active: json['active'] as bool? ?? true,
      mode: $enumDecodeNullable(_$ModeEnumMap, json['mode']) ?? Mode.scanner,
      isShop: json['isShop'] as bool? ?? false,
      stock: json['stock'] as int? ?? 1,
      price: json['price'] as int? ?? 0,
      isSpace: json['isSpace'] as bool? ?? false,
      spaceId: json['spaceId'] as String?,
      barcode: json['barcode'] as String?,
      createdAt:
          const DateTimeConvertor().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConvertor().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.uid,
      'name': instance.name,
      'image': instance.image,
      'mfgDate': const DateTimeConvertor().toJson(instance.mfgDate),
      'expDate': const DateTimeConvertor().toJson(instance.expDate),
      'description': instance.description,
      'status': _$StatusEnumMap[instance.status]!,
      'active': instance.active,
      'mode': _$ModeEnumMap[instance.mode]!,
      'isShop': instance.isShop,
      'stock': instance.stock,
      'price': instance.price,
      'isSpace': instance.isSpace,
      'spaceId': instance.spaceId,
      'barcode': instance.barcode,
      'createdAt': const DateTimeConvertor().toJson(instance.createdAt),
      'updatedAt': const DateTimeConvertor().toJson(instance.updatedAt),
    };

const _$StatusEnumMap = {
  Status.active: 'active',
  Status.expired: 'expired',
};

const _$ModeEnumMap = {
  Mode.scanner: 'scanner',
  Mode.manual: 'manual',
};
