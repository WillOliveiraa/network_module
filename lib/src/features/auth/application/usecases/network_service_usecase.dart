import 'package:core_module/core_module.dart';

import '../../../../core/failure/api_error_exception.dart';
import '../../../../core/shared/api_manager.dart';
import '../../domain/entities/cancel_request.dart';
import '../../infra/models/network_request_model.dart';
import '../../infra/models/network_response_model.dart';
import '../repositories/network_client_repository.dart';

class NetworkServiceUsecase {
  final NetworkClientRespository _clientRepository;
  late final ApiManager _apiManager;

  NetworkServiceUsecase(this._clientRepository, [ApiManager? apiManager]) {
    _apiManager = apiManager ?? ApiManager();
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> getRequest({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      final response = await _clientRepository.get(
        payload: payload,
        cancelRequest: cancelRequest,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> postRequest({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      final response = await _clientRepository.post(
        payload: payload,
        cancelRequest: cancelRequest,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> deleteRequest({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      final response = await _clientRepository.delete(
        payload: payload,
        cancelRequest: cancelRequest,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> putRequest({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      final response = await _clientRepository.put(
        payload: payload,
        cancelRequest: cancelRequest,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> patchRequest({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  }) async {
    try {
      final response = await _clientRepository.patch(
        payload: payload,
        cancelRequest: cancelRequest,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }
}
