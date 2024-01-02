class ServerException implements Exception {
  final String? message;

  ServerException({this.message});

  @override
  String toString() {
    return 'Exception: $message';
  }
}

class NoDataYetException implements Exception {
  final String message;

  NoDataYetException({required this.message});

   @override
  String toString() {
    return message;
  }

}

class OfflineException implements Exception {}

class EmptyCacheException implements Exception {}
