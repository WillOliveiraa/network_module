import '../../domain/entities/cancel_request.dart';
import '../../infra/models/network_request_model.dart';
import '../../infra/models/network_response_model.dart';

abstract class NetworkClientRespository {
  Future<NetworkResponseModel> get<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> post<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> put<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> delete<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> patch<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> request<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });

  Future<NetworkResponseModel> postFileUpload<T>({
    required NetworkRequestModel payload,
    CancelRequest? cancelRequest,
  });
}
