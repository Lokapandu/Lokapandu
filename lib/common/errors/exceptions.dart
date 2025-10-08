class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);

  @override
  String toString() => 'ConnectionException: $message';
}

class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class SupabaseException implements Exception {
  final String message;
  final String? code;

  const SupabaseException(this.message, {this.code});

  @override
  String toString() =>
      'SupabaseException: $message${code != null ? ' (Code: $code)' : ''}';
}

class DataParsingException implements Exception {
  final String message;
  final dynamic originalData;

  const DataParsingException(this.message, {this.originalData});

  @override
  String toString() => 'DataParsingException: $message';
}

class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

class SchedulingConflictException implements Exception {
  final String message;

  const SchedulingConflictException(this.message);

  @override
  String toString() => 'SchedulingConflictException: $message';
}

class InvalidTimeRangeException implements Exception {
  final String message;

  const InvalidTimeRangeException(this.message);

  @override
  String toString() => 'InvalidTimeRangeException: $message';
}

class MissingFieldException implements Exception {
  final String message;

  const MissingFieldException(this.message);

  @override
  String toString() => 'MissingFieldException: $message';
}
