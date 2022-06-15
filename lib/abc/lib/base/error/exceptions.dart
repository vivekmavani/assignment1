class ServerException implements Exception {
  const ServerException({
    this.code,
    this.message,
  });

  final int? code;
  final String? message;
}

class CacheException implements Exception {}
