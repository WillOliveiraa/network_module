import 'package:core_module/core_module.dart';

import '../../../../core/failure/api_error_exception.dart';

abstract class RefreshTokenRepository {
  Future<Either<ApiErrorException, void>> refreshToken(UserDataModel user);
}
