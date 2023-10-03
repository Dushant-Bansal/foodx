import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum Status {
  active,
  expired;

  String get name => toString().split('.').last;
}

enum Mode { scanner, manual }

@JsonSerializable()
class Product {
  const Product(
      {required this.id,
      required this.uid,
      required this.name,
      required this.image,
      required this.mfgDate,
      required this.expDate,
      this.description,
      this.status = Status.active,
      this.active = true,
      this.mode = Mode.scanner,
      this.isShop = false,
      this.stock = 1,
      this.price = 0,
      this.isSpace = false,
      this.spaceId,
      this.barcode,
      required this.createdAt,
      required this.updatedAt})
      : assert(!isSpace || spaceId != null);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'userId')
  final String uid;

  final String name;
  final String image;

  @DateTimeConvertor()
  final DateTime mfgDate;

  @DateTimeConvertor()
  final DateTime expDate;

  final String? description;

  @JsonKey(defaultValue: Status.active)
  final Status status;

  @JsonKey(defaultValue: true)
  final bool active;

  @JsonKey(defaultValue: Mode.scanner)
  final Mode mode;

  final bool isShop;

  @JsonKey(defaultValue: 1)
  final int stock;

  @JsonKey(defaultValue: 0)
  final int price;

  @JsonKey(defaultValue: false)
  final bool isSpace;

  final String? spaceId;
  final String? barcode;

  @DateTimeConvertor()
  final DateTime createdAt;

  @DateTimeConvertor()
  final DateTime updatedAt;

  Product copyWith({
    String? id,
    String? uid,
    String? name,
    String? image,
    DateTime? mfgDate,
    DateTime? expDate,
    String? description,
    Status? status,
    bool? active,
    Mode? mode,
    bool? isShop,
    int? stock,
    int? price,
    bool? isSpace,
    String? spaceId,
    String? barcode,
  }) {
    return Product(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      image: image ?? this.image,
      mfgDate: mfgDate ?? this.mfgDate,
      expDate: expDate ?? this.expDate,
      description: description ?? this.description,
      status: status ?? this.status,
      active: active ?? this.active,
      mode: mode ?? this.mode,
      isShop: isShop ?? this.isShop,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      isSpace: isSpace ?? this.isSpace,
      spaceId: spaceId ?? this.spaceId,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  String get getLeftDays {
    final days = expDate.difference(mfgDate).inDays;
    if (days.isNegative) return 'Already Expired';
    return days == 0 ? 'Today' : '$days ${days == 1 ? 'day' : 'days'}';
  }

  String get mfgDateString => DateFormat('dd/MM/yyyy').format(mfgDate);
  String get expDateString => DateFormat('dd/MM/yyyy').format(expDate);
}

class DateTimeConvertor implements JsonConverter<DateTime, String> {
  const DateTimeConvertor();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toString();
}
