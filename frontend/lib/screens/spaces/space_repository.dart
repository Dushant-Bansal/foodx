import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/spaces/models/invited_users.dart';
import 'package:food_x/screens/spaces/models/space.dart';
import 'package:food_x/services/base_repostitory.dart';

class SpaceRepository with BaseRepository {
  SpaceRepository._();

  static SpaceRepository get instance => _instance;
  static final _instance = SpaceRepository._();

  Future<Space> createSpace({
    required String name,
    String? description,
  }) async {
    final response = await dio.post(
      '/space',
      data: {'name': name, 'description': description},
    );

    return Space.fromJson(response.data['data']);
  }

  Future<List<Space>> getSpaces() async {
    final response = await dio.get('/space');

    return (response.data['data']['data'] as List)
        .map((e) => Space.fromJson(e))
        .toList();
  }

  Future<List<InvitedUsers>> getInvitedUsers(String id) async {
    final response = await dio.get(
      '/invitedUser',
      queryParameters: {'spaceId': id},
    );

    return (response.data['data']['data'] as List)
        .map((e) => InvitedUsers.fromJson(e))
        .toList();
  }

  Future<InvitedUsers> inviteUser({
    required String id,
    required String email,
    required String role,
    required String url,
  }) async {
    final response = await dio.post(
      '/invitedUser',
      data: {'spaceId': id, 'by': email, 'roles': role, 'url': url},
    );

    return InvitedUsers.fromJson(response.data['data']);
  }

  Future<List<Space>> getSpaceUsers(String id) async {
    final response = await dio.get('/space');

    return (response.data['data']['data'] as List)
        .map((e) => Space.fromJson(e))
        .toList();
  }

  Future<Product> updateProduct({
    required String spaceId,
    required String productId,
  }) async {
    final response = await dio
        .put('/spaceUser/product/$productId', data: {'spaceId': spaceId});

    return Product.fromJson(response.data['data']);
  }

  Future<void> addUser({required String spaceId, required String role}) async {
    await dio.post('/spaceUser', data: {'spaceId': spaceId, 'roles': role});
  }
}
