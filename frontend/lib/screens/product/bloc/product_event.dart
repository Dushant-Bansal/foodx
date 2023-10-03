part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductScan extends ProductEvent {
  const ProductScan(this.barcode);

  final String barcode;
}

class ProductAdd extends ProductEvent {
  ProductAdd({
    required this.name,
    required this.image,
    required this.imageLink,
    required this.manufactured,
    required this.expiry,
    this.description,
    this.stock,
    this.price,
    required this.mode,
  });

  final String name;
  final File? image;
  final String imageLink;
  final String manufactured;
  final String expiry;
  final String? description;
  final int? stock;
  final int? price;
  final Mode mode;
}
