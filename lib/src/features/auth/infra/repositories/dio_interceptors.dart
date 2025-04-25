import 'dart:convert';

import 'package:core_module/core_module.dart';
import 'package:dependencies_module/external/dio.dart';
import 'package:utils_module/utils_module.dart';

import '../../../../core/failure/api_error_exception.dart';
import '../../../../core/shared/api_manager.dart';
import '../models/network_request_model.dart';
import '../models/network_response_model.dart';

class DioInterceptors extends Interceptor {
  final _logger = Logging();
  final ApiManager _apiManager = ApiManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = _apiManager.requestHeaders(
      requestHeaders: options.headers,
    );

    NetworkRequestModel result = NetworkRequestModel(
      method: options.method,
      endpoint: options.path,
      body: options.data,
      queryParameters: options.queryParameters,
      headers: options.headers,
    );

    final map = result.toMap()..addAll({'baseUrl': options.baseUrl});

    _logger.showLog(
      message: FormatString.formatJsonToString(jsonEncode(map)),
      logType: LogType.info,
      shouldDebug: FlavorConfig.instance.values.debug,
      payloadMethod: options.method,
    );

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final NetworkResponseModel result = NetworkResponseModel(
      statusCode: response.statusCode ?? 999,
      url: response.requestOptions.uri.toString(),
      body: response.data,
    );

    _logger.showLog(
      message: FormatString.formatJsonToString(result.toJson()),
      logType: LogType.info,
      shouldDebug: FlavorConfig.instance.values.debug,
    );

    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    ApiErrorException errorException;

    final responseError = err.response;

    String getMessage() {
      const defaultMessage = 'Não foi possível fazer a requisição!';
      if (responseError == null) {
        return defaultMessage;
      }
      return responseError.statusMessage ?? defaultMessage;
    }

    errorException = ApiErrorException(
      statusCode: responseError?.statusCode ?? 999,
      url: err.requestOptions.uri.toString(),
      message: getMessage(),
      code: 'Uknown',
      headers: {},
    );

    if (err.type == DioExceptionType.cancel) {
      errorException = ApiErrorException(
        statusCode: responseError?.statusCode ?? 999,
        url: err.requestOptions.uri.toString(),
        message: 'Request canceled',
        code: 'RequestCanceled',
        headers: {},
      );
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      errorException = ApiErrorException(
        statusCode: responseError?.statusCode ?? 999,
        url: err.requestOptions.uri.toString(),
        message: 'Request Timeout',
        headers: {},
        code: 'RequestTimeout',
      );
    }

    _logger.showLog(
      message: FormatString.formatJsonToString(errorException.toJson()),
      logType: LogType.error,
      shouldDebug: FlavorConfig.instance.values.debug,
    );

    handler.next(err);
  }
}
