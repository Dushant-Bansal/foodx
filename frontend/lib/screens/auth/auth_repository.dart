import 'package:dio/dio.dart';
import 'package:food_x/services/base_repostitory.dart';
import 'package:food_x/services/token_storage.dart';

class AuthRepository with BaseRepository {
  AuthRepository._();

  static AuthRepository get instance => _instance;
  static final _instance = AuthRepository._();

  Future<bool> loginViaGoogle({
    required String userId,
    required String email,
    required String name,
  }) async {
    final response = await dio.post(
      '/user/login',
      options: Options(extra: {'requiresAuth': false}),
      data: {'userName': userId, 'email': email, 'name': name, 'mode': 'Oauth'},
    );

    return await TokenStorage.setToken(
      accessToken: response.data['data']['accessToken'],
      refreshToken: response.data['data']['refreshToken'],
    );
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/user/onBoarding',
      options: Options(extra: {'requiresAuth': false}),
      data: {'name': name, 'email': email, 'password': password},
    );

    return await TokenStorage.setToken(
      accessToken: response.data['data']['accessToken'],
      refreshToken: response.data['data']['refreshToken'],
    );
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/user/login',
      options: Options(extra: {'requiresAuth': false}),
      data: {'email': email, 'password': password, 'mode': 'email'},
    );

    return await TokenStorage.setToken(
      accessToken: response.data['data']['accessToken'],
      refreshToken: response.data['data']['refreshToken'],
    );
  }

  Future<void> logout() async {
    final response = await dio.delete('/user/logout');
    if (response.statusCode == 200) {
      await TokenStorage.deleteToken(accessToken: true, refreshToken: true);
    }
  }
}
