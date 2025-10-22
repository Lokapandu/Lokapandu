class ServerException implements Exception {
  final String message;
  final dynamic stacktrace;

  const ServerException(this.message, {this.stacktrace});

  @override
  String toString() => 'ServerException: $message, stacktrace: $stacktrace';
}

class ConnectionException implements Exception {
  final String message;
  final dynamic stacktrace;

  const ConnectionException(this.message, {this.stacktrace});

  @override
  String toString() => 'ConnectionException: $message, stacktrace: $stacktrace';
}

class DatabaseException implements Exception {
  final String message;
  final dynamic stacktrace;

  const DatabaseException(this.message, {this.stacktrace});

  @override
  String toString() => 'DatabaseException: $message, stacktrace: $stacktrace';
}

class SupabaseException implements Exception {
  final String message;
  final String? code;
  final dynamic stacktrace;

  const SupabaseException(this.message, {this.code, this.stacktrace});

  @override
  String toString() =>
      'SupabaseException: $message${code != null ? ' (Code: $code)' : ''}, stacktrace: $stacktrace';
}

class DataParsingException implements Exception {
  final String message;
  final dynamic originalData;
  final dynamic stackTrace;

  const DataParsingException(
    this.message, {
    this.originalData,
    this.stackTrace,
  });

  @override
  String toString() =>
      'DataParsingException: $message, originalData: $originalData, stackTrace: $stackTrace';
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
