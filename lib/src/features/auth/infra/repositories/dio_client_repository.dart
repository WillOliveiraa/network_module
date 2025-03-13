import 'package:core_module/core_module.dart';
import 'package:dependencies_module/external/curl_logger_dio_interceptor.dart';
import 'package:dependencies_module/external/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/shared/api_manager.dart';
import '../../application/repositories/network_client_repository.dart';
import '../../domain/entities/cancel_request.dart';
import '../models/network_request_model.dart';
import '../models/network_response_model.dart';
import 'dio_interceptors.dart';

class DioClientRepository implements NetworkClientRespository {
  final ApiManager _apiManager = ApiManager();
  final Dio _dio = Dio();

  DioClientRepository({List<Interceptor>? interceptors}) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }

    _dio
      ..interceptors.add(DioInterceptors())
      ..options.baseUrl = FlavorConfig.instance.values.baseUrl ?? ''
      ..options.connectTimeout = Duration(milliseconds: 60000)
      ..options.receiveTimeout = Duration(microseconds: 60000);

    if (kDebugMode) {
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }

    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) => client..badCertificateCallback = (_, __, ___) => true;
  }

  @override
  Future<NetworkResponseModel> get<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .get(
            payload.endpoint,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> post<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .post(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> delete<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .delete(
            payload.endpoint,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> put<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .put(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> patch<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .patch(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> request<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      return await _dio
          .request(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers, method: payload.method),
            cancelToken: cancelRequest?.cancelToken,
          )
          .then(_setDioResponse);
    } on DioException catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  NetworkResponseModel _setDioResponse(Response response) {
    return NetworkResponseModel(
      statusCode: response.statusCode,
      url: response.requestOptions.uri.toString(),
      body: response.data['data'],
      method: response.requestOptions.method.toUpperCase(),
      headers: response.data['header'],
    );
  }
}
