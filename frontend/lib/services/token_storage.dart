import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_x/styles/snack_bar.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _accessTokenKey = 'accessTokenKey';
  static const String _refreshTokenKey = 'refreshTokenKey';

  static Future<bool> setToken({
    String? accessToken,
    String? refreshToken,
  }) async {
    try {
      if (accessToken != null) {
        await _storage.write(key: _accessTokenKey, value: accessToken);
      }

      if (refreshToken != null) {
        await _storage.write(key: _refreshTokenKey, value: refreshToken);
      }
      return true;
    } catch (_) {
      showErrorSnackBar('Unable to update token');
      return false;
    }
  }

  static Future<bool> deleteToken({
    bool accessToken = false,
    bool refreshToken = false,
  }) async {
    try {
      if (accessToken) {
        await _storage.delete(key: _accessTokenKey);
      }

      if (refreshToken) {
        await _storage.delete(key: _refreshTokenKey);
      }
      return true;
    } catch (_) {
      showErrorSnackBar('Unable to delete token');
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }
}
