import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/services/base_repostitory.dart';

class ProductRepository with BaseRepository {
  ProductRepository._();

  static ProductRepository get instance => _instance;
  static final _instance = ProductRepository._();

  Future<Map<String, dynamic>> getProductDetailsViaScanning({
    required String barcode,
  }) async {
    final response = await barcodeDio.get(
      '/products',
      queryParameters: {
        'barcode': barcode,
        'formatted': 'y',
        'key': 'hlrplsk06dltw2drvxd4refss6jtpd',
      },
    );

    return (response.data["products"] as List).first;
  }

  Future<Product> addProduct({
    required String name,
    String? description,
    required String image,
    required String mfgDate,
    required String expDate,
    int? stock,
    int? price,
    String? barcode,
    required Mode mode,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'image': image,
      'mfgDate': mfgDate.split('/').reversed.join('-'),
      'expDate': expDate.split('/').reversed.join('-'),
      'stock': stock,
      'price': price,
      'barcode': barcode,
      'mode': describeEnum(mode),
    };
    data.removeWhere((key, value) => value == null);
    final response = await dio.post('/product', data: data);
    return Product.fromJson(response.data['data']);
  }

  Future<String> upload(File file, {void Function(int, int)? progress}) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });

    final response = await dio.post(
      '/uploader',
      data: formData,
      onSendProgress: (count, total) => progress,
    );
    return response.data['data'];
  }

  Future<void> update(Product product) async {
    await dio.put('/product/${product.id}', data: product.toJson());
  }

  Future<void> delete(String id) async {
    await dio.delete('/product/$id');
  }
}
