class AuthTokenEntity {
  final String accessToken;
  final String expireTime;

  const AuthTokenEntity({
    required this.accessToken,
    required this.expireTime,
  });
}
