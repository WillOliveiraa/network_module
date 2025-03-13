import 'package:dependencies_module/external/dio.dart';

class CancelRequest {
  late CancelToken cancelToken;

  CancelRequest() : cancelToken = CancelToken();

  void cancel() {
    if (cancelToken.isCancelled) return;

    cancelToken.cancel('request cancellation');
    cancelToken = CancelToken();
  }
}
