import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.connection(String message) = ConnectionFailure;
  const factory Failure.database(String message) = DatabaseFailure;
}
