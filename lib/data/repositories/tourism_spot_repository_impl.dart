import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/models/tourism_spot/ts_model/tourism_spot_model.dart';
import 'package:lokapandu/domain/entities/tourism_spot.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class TourismSpotRepositoryImpl implements TourismSpotRepository {
  final TourismSpotRemoteDataSource remoteDataSource;
  TourismSpotRepositoryImpl({required this.remoteDataSource});

  // TODO: make network bound resource
  @override
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots() async {
    try {
      final result = await remoteDataSource.getTourismSpots();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(''));
    }
  }
}
