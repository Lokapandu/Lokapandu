import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/datasources/weather_remote_data_source.dart';
import 'package:lokapandu/data/mappers/api_weather_to_current_condition.dart';
import 'package:lokapandu/data/models/weather/weather_model.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';
import 'package:lokapandu/domain/repositories/weather_repository.dart';
import 'dart:developer' as dev;

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource dataSource;

  WeatherRepositoryImpl({required this.dataSource});

  Future<Either<Failure, Weather>> _executeApiCall(
    Future<WeatherModel> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result.toCurrentConditionEntity());
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

  @override
  Future<Either<Failure, Weather>> getCurrentWeather({
    required String latLon,
  }) async {
    return _executeApiCall(() => dataSource.getCurrentWeather(latLon));
  }
}
