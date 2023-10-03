import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/services/base_repostitory.dart';

class ShopRepository with BaseRepository {
  ShopRepository._();

  static ShopRepository get instance => _instance;
  static final _instance = ShopRepository._();

  Future<List<Product>> getProducts() async {
    final response =
        await dio.get('/product', queryParameters: {'isShop': true});

    return (response.data['data']['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }
}
