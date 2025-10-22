import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';

Future<Either<Failure, E>> executeApiCall<E>(
  Future<E> Function() call, {
  String? name,
}) async {
  try {
    final result = await call();
    return Right(result);
  } on DataParsingException catch (e, st) {
    dev.log(e.toString(), stackTrace: st, name: name ?? 'api_call_handler');
    return Left(ParsingFailure('$e'));
  } on FormatException catch (e, st) {
    dev.log(e.toString(), stackTrace: st, name: name ?? 'api_call_handler');
    return Left(ServerFailure('$e'));
  } on ConnectionException catch (e, st) {
    dev.log(e.toString(), stackTrace: st, name: name ?? 'api_call_handler');
    return Left(ConnectionFailure('$e'));
  } catch (e, st) {
    dev.log(e.toString(), stackTrace: st, name: name ?? 'api_call_handler');
    return Left(ServerFailure('Unexpected Error: ${e.toString()}'));
  }
}
