import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';

Future<Either<Failure, E>> executeApiCall<E>(
    Future<E> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result);
    } on FormatException catch (e) {
      dev.log(e.toString(), name: 'Weather Repository');
      return Left(ServerFailure('Server Error: ${e.toString()}'));
    } on ConnectionException catch (e) {
      dev.log(e.toString(), name: 'Weather Repository');
      return Left(ConnectionFailure('Connection Error: ${e.toString()}'));
    } catch (e) {
      dev.log(e.toString(), name: 'Weather Repository');
      return Left(ServerFailure('Unexpected Error: ${e.toString()}'));
    }
  }