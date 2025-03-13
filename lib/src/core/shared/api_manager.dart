import 'package:core_module/core_module.dart';
import 'package:dependencies_module/external/dio.dart';
import 'package:utils_module/utils_module.dart';

import '../../features/auth/infra/models/network_response_model.dart';
import '../failure/api_error_exception.dart';

class ApiManager {
  final logger = Logging();

  ApiErrorException handleApiError(DioException err) {
    final response = err.response;
    final data = response?.data as Map<String, dynamic>;

    final errors =
        List.from(
          data['errors'] ?? [],
        ).map((e) => ErrorResponse(message: e)).toList();

    if (err.type == DioExceptionType.cancel) {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.requestOptions.uri.toString() ?? '',
        message: 'Request canceled',
        code: 'RequestCanceled',
        headers: response?.headers.map ?? {},
        errors: errors,
      );
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.requestOptions.uri.toString() ?? '',
        message: 'Request Timeout',
        code: 'RequestTimeout',
        headers: response?.headers.map ?? {},
        errors: errors,
      );
    }

    if (response?.statusMessage == 'TransactionStepIsClosed') {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.realUri.toString() ?? '',
        message: response?.statusMessage ?? '',
        code: 'TransactionStepIsClosed',
        headers: response?.headers.map ?? {},
        errors: errors,
      );
    }

    if (err.type == DioExceptionType.badResponse) {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.requestOptions.uri.toString() ?? '',
        message: response?.statusMessage ?? 'Bad Response',
        code: 'BadResponse',
        headers: response?.headers.map ?? {},
        errors: errors,
      );
    }

    return ApiErrorException(
      statusCode: 999,
      url: err.requestOptions.uri.toString(),
      message: err.message ?? '',
      code: err.type.name,
      headers: response?.headers.map ?? {},
      errors: errors,
    );
  }

  Map<String, dynamic> requestHeaders({
    Map<String, dynamic>? requestHeaders,
    String? contentType,
  }) {
    Map<String, dynamic> headers = {
      "Content-Type": (contentType == null) ? "application/json" : contentType,
    };

    if (requestHeaders != null) {
      requestHeaders.forEach((key, value) {
        headers.putIfAbsent(key, () => value);
      });
    }

    return headers;
  }

  Left<ApiErrorException, NetworkResponseModel> unhandledException(T) {
    final result = ApiErrorException(
      statusCode: 0,
      url: '',
      message: 'Invalid request: ${T.toString()}',
      code: '',
      headers: {},
    );

    logger.showLog(
      message: FormatString.formatJsonToString(result.toJson()),
      logType: LogType.error,
      shouldDebug: FlavorConfig.instance.values.debug,
    );

    return Left(result);
  }
}
