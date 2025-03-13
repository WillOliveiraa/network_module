import 'package:core_module/core_module.dart';

import '../../features/auth/application/repositories/network_client_repository.dart';
import '../../features/auth/application/usecases/network_service_usecase.dart';
import '../../features/auth/infra/repositories/dio_client_repository.dart';
import '../../features/auth/infra/repositories/dio_token_expired_interceptor.dart';
import '../../features/auth/infra/repositories/dio_token_interceptor.dart';

class NetworkInject {
  static void injectDependencies() {
    DependenciesInjector.registerFactory<DioTokenInterceptor>(
      () => DioTokenInterceptor(
        DependenciesInjector.get<AuthenticatorProvider>(),
      ),
    );

    DependenciesInjector.registerFactory<DioTokenExpiredInterceptor>(
      () => DioTokenExpiredInterceptor(
        DependenciesInjector.get<AuthenticatorProvider>(),
      ),
    );

    DependenciesInjector.registerLazySingleton<NetworkClientRespository>(
      () => DioClientRepository(
        interceptors: [DependenciesInjector.get<DioTokenInterceptor>()],
      ),
    );

    DependenciesInjector.registerFactory<NetworkServiceUsecase>(
      () => NetworkServiceUsecase(
        DependenciesInjector.get<NetworkClientRespository>(),
      ),
    );
  }
}
