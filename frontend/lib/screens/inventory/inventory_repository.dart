import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/services/base_repostitory.dart';

class InventoryRepository with BaseRepository {
  InventoryRepository._();

  static InventoryRepository get instance => _instance;
  static final _instance = InventoryRepository._();

  Future<List<Product>> getProducts({
    bool? isShop,
    Status? status,
    String? name,
    String? id,
    bool? isSpace,
    String? spaceId,
  }) async {
    Map<String, dynamic> params = {
      'isShop': isShop,
      'status': status?.name,
      'name': name,
      'id': id,
      'isSpace': isSpace,
      'spaceId': spaceId,
    };
    params.removeWhere((key, value) => value == null);

    final response = await dio.get('/product', queryParameters: params);

    return (response.data['data']['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }
}
