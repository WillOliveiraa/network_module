import 'package:core_module/core_module.dart';
import 'package:dependencies_module/external/dio.dart';

import '../../../../core/shared/authorized_paths.dart';

class DioTokenInterceptor extends Interceptor {
  final AuthenticatorProvider _authenticatorProvider;

  DioTokenInterceptor(this._authenticatorProvider);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _setAccessToken(options);
    handler.next(options);
  }

  Future<void> _setAccessToken(RequestOptions options) async {
    final hasAuthorizedPath = authorizedPaths.any(
      (path) => options.path.contains(path),
    );

    if (!hasAuthorizedPath) {
      final userData = await _authenticatorProvider.getActiveUserData();
      options.headers.putIfAbsent(
        'Authorization',
        () => userData?.accessToken.accessToken,
      );
    }
  }
}
