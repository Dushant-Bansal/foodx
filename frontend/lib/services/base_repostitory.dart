import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/auth/bloc/auth_bloc.dart';
import 'package:food_x/styles/snack_bar.dart';
import 'token_storage.dart';

class CustomDioOptions extends Options {
  static const _defaultShowErrorSnackBar = true;
  static const _showErrorSnackBarKey = 'showErrorSnackBar';

  static const _defaultRequiresAuthKey = true;
  static const _requiresAuthKey = 'requiresAuth';

  static bool showErrorSnackBar(Map<String, dynamic>? extra) =>
      extra?[_showErrorSnackBarKey] ?? _defaultShowErrorSnackBar;

  static bool requiresAuth(Map<String, dynamic>? extra) =>
      extra?[_requiresAuthKey] ?? _defaultRequiresAuthKey;

  CustomDioOptions({
    bool showErrorSnackBar = _defaultShowErrorSnackBar,
    bool requiresAuth = _defaultRequiresAuthKey,
  }) : super(
          extra: {
            _showErrorSnackBarKey: showErrorSnackBar,
            _requiresAuthKey: requiresAuth,
          },
        );
}

final _dio = Dio(
  BaseOptions(
    baseUrl: 'https://foodx-b5ty.onrender.com',
    headers: {'Content-Type': 'application/json'},
  ),
)..interceptors.addAll(
    [
      AuthInterceptor(),
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        requestBody: true,
        responseBody: true,
      ) // Must be Last
    ],
  );

mixin BaseRepository {
  @protected
  Dio get dio => _dio;

  @protected
  Dio get barcodeDio => Dio(
        BaseOptions(
          baseUrl: 'https://api.barcodelookup.com/v3',
          headers: {'Content-Type': 'application/json'},
        ),
      )..interceptors.addAll(
          [
            LogInterceptor(
              requestHeader: false,
              responseHeader: false,
              requestBody: true,
              responseBody: true,
            ) // Must be Last
          ],
        );
}

class AuthInterceptor extends QueuedInterceptor with BaseRepository {
  final String path = '/refreshToken';

  Map<int, String> error = {
    401: 'Invalid Refresh Token!',
    500: 'Access Denied: Invalid token',
  };

  void logout() {
    try {
      BlocProvider.of<AuthBloc>(
        scaffoldMessengerKey.currentContext!,
        listen: false,
      ).add(const AuthSignOut(forced: true));
      showErrorSnackBar('Session expired. Please log in again.');
    } catch (_) {
      showErrorSnackBar('An error has occurred. Please try logging out.');
    }
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await TokenStorage.getAccessToken();
    final requiresAuth = CustomDioOptions.requiresAuth(options.extra);

    if (requiresAuth) {
      if (accessToken != null) {
        options.headers
            .putIfAbsent('Authorization', () => 'Bearer $accessToken');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final int? code = err.response?.statusCode;
    String message = '';
    final RequestOptions options = err.requestOptions;

    try {
      message = (err.response?.data as Map)['message'];
      if (CustomDioOptions.showErrorSnackBar(options.extra)) {
        showErrorSnackBar(message);
      }
    } catch (_) {}

    try {
      if (error[code] == message) {
        final refreshToken = await TokenStorage.getRefreshToken();
        if (refreshToken != null) {
          final response = await dio.get(
            path,
            options: Options(
              headers: {'Authorization': 'Bearer $refreshToken'},
              extra: CustomDioOptions(requiresAuth: false).extra,
            ),
          );

          final String accessToken = response.data["data"]["accessToken"];
          await TokenStorage.setToken(accessToken: accessToken);

          return handler.resolve(await retry(options));
        } else {
          logout();
        }
      }
    } catch (e) {
      if (e is DioException) {
        final code = err.response?.statusCode;
        final message = err.response?.data['message'];
        if (error[code] == message) logout();
      }
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> retry(RequestOptions options) {
    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      cancelToken: options.cancelToken,
      options: Options(
        method: options.method,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: options.extra,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType,
        validateStatus: options.validateStatus,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
        persistentConnection: options.persistentConnection,
        requestEncoder: options.requestEncoder,
        responseDecoder: options.responseDecoder,
        listFormat: options.listFormat,
      ),
      onSendProgress: options.onSendProgress,
      onReceiveProgress: options.onReceiveProgress,
    );
  }
}
