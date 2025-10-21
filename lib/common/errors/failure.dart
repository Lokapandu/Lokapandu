import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.client(String message) = ClientFailure;
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.connection(String message) = ConnectionFailure;
  const factory Failure.database(String message) = DatabaseFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.schedulingConflict(String message) =
      SchedulingConflictFailure;
  const factory Failure.invalidTimeRange(String message) =
      InvalidTimeRangeFailure;
  const factory Failure.missingField(String message) = MissingFieldFailure;
}
