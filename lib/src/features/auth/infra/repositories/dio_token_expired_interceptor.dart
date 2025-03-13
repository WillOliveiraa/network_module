import 'package:core_module/core_module.dart';
import 'package:dependencies_module/external/dio.dart';

import '../../../../core/shared/authorized_paths.dart';

class DioTokenExpiredInterceptor extends QueuedInterceptor {
  final AuthenticatorProvider _authenticatorProvider;

  DioTokenExpiredInterceptor(this._authenticatorProvider);

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final status = response.data['header']?['status'];

    final hasAuthorizedPath = authorizedPaths.any(
      (path) => response.requestOptions.path.contains(path),
    );

    final hasUser = await _authenticatorProvider.getActiveUserData();

    final logoutUser =
        !hasAuthorizedPath &&
        hasUser != null &&
        status == 'AuthenticationRequired';

    if (logoutUser) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: Response(
            requestOptions: response.requestOptions,
            statusCode: 401,
            statusMessage: 'Token is not authorized',
          ),
        ),
      );

      _authenticatorProvider.logoutAllUsers();
    } else {
      handler.next(response);
    }
  }
}
