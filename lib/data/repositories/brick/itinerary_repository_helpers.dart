part of 'itinerary_repository_brick_impl.dart';

const int _maxNameLength = 35;
const int _maxNotesLength = 250;
const int _bufferTimeMinutes = 1;

/// Validates if the time range is valid (start time before end time)
Either<Failure, Unit> _validateTimeRange(DateTime startTime, DateTime endTime) {
  if (startTime.isAfter(endTime)) {
    return Left(InvalidTimeRangeFailure('Start time must be before end time'));
  }
  return Right(unit);
}

/// Validates if the start time is in the future
Either<Failure, Unit> _validateFutureTime(DateTime startTime) {
  final now = DateTime.now();
  if (startTime.isBefore(now)) {
    return Left(ValidationFailure('Start time must be in the future'));
  }
  return Right(unit);
}

/// Validates the length of name and notes fields
Either<Failure, Unit> _validateFieldLengths({
  required String name,
  String? notes,
}) {
  if (name.length > _maxNameLength) {
    return Left(
      ValidationFailure('Name must not exceed $_maxNameLength characters'),
    );
  }

  if (notes != null && notes.length > _maxNotesLength) {
    return Left(
      ValidationFailure('Notes must not exceed $_maxNotesLength characters'),
    );
  }

  return Right(unit);
}

/// Validates if tourism spot exists in database
Future<Either<Failure, Unit>> _validateTourismSpotExists(
  int? tourismSpotId,
) async {
  if (tourismSpotId == null) {
    return Right(unit);
  }

  try {
    final tourismSpotResult = await Repository().getAll<TourismSpotModel>(
      query: Query.where('id', tourismSpotId),
    );

    if (tourismSpotResult == null || tourismSpotResult.isEmpty) {
      return Left(ValidationFailure('Tourism spot not found'));
    }

    return Right(unit);
  } catch (e) {
    developer.log(e.toString(), name: "Itinerary Repository");
    return Left(
      ServerFailure('Error validating tourism spot: ${e.toString()}'),
    );
  }
}

/// Validates if there are any scheduling conflicts with existing itineraries
/// Includes buffer time to prevent back-to-back scheduling
Future<Either<Failure, Unit>> _checkSchedulingConflicts(
  String userId,
  DateTime startTime,
  DateTime endTime, [
  String? excludeItineraryId,
]) async {
  try {
    // Get all user itineraries
    final userItineraryResults = await Repository().getAll<UserItineraryModel>(
      query: Query.where('userId', userId),
      policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
    );

    if (userItineraryResults == null || userItineraryResults.isEmpty) {
      return Right(unit);
    }

    final itineraryIds = userItineraryResults
        .map((e) => e.itinerariesId)
        .toList();

    if (itineraryIds.isEmpty) {
      return Right(unit);
    }

    final itineraries = <ItineraryModel>[];

    for (final id in itineraryIds) {
      final result = await Repository().getAll<ItineraryModel>(
        query: Query.where('id', id),
      );
      if (result != null && result.isNotEmpty) {
        itineraries.add(result.first);
      }
    }

    developer.log(
      "Total itineraries fetched: ${itineraries.length}",
      name: "Itinerary Repository",
    );

    if (itineraries.isEmpty) {
      return Right(unit);
    }

    // Add buffer time to the new itinerary
    final bufferedStartTime = startTime.subtract(
      Duration(minutes: _bufferTimeMinutes),
    );
    final bufferedEndTime = endTime.add(Duration(minutes: _bufferTimeMinutes));

    for (final itinerary in itineraries) {
      // Skip the current itinerary if we're updating
      if (excludeItineraryId != null && itinerary.id == excludeItineraryId) {
        continue;
      }

      // Check for overlap with buffer time
      // Conflict if: (bufferedStart < existingEnd) AND (bufferedEnd > existingStart)
      if (bufferedStartTime.isBefore(itinerary.endTime) &&
          bufferedEndTime.isAfter(itinerary.startTime)) {
        return Left(
          SchedulingConflictFailure(
            'Cannot add itinerary - scheduling conflict detected. '
            'Please ensure at least $_bufferTimeMinutes minutes gap between itineraries',
          ),
        );
      }
    }

    return Right(unit);
  } catch (e) {
    developer.log(e.toString(), name: "Itinerary Repository");
    return Left(
      ServerFailure('Error checking scheduling conflicts: ${e.toString()}'),
    );
  }
}

/// Validates required fields for itinerary creation
Either<Failure, Unit> _validateRequiredFields(CreateItinerary itineraryInput) {
  if (itineraryInput.name.trim().isEmpty) {
    return Left(MissingFieldFailure('Itinerary name is required'));
  }
  return Right(unit);
}

/// Validates required fields for itinerary note creation
Either<Failure, Unit> _validateNoteRequiredFields(
  CreateItineraryNote itineraryInput,
) {
  if (itineraryInput.name.trim().isEmpty) {
    return Left(MissingFieldFailure('Itinerary name is required'));
  } else if (itineraryInput.notes.trim().isEmpty) {
    return Left(MissingFieldFailure('Itinerary content is required'));
  }
  return Right(unit);
}

Future<List<Itinerary>> _toEntitiesWithRelations(
  List<ItineraryModel> itineraries,
) async {
  final itineraryEntitiesFutures = itineraries.map((itinerary) async {
    TourismSpot? tourismSpotEntity;
    if (itinerary.tourismSpotId != null) {
      final tourismSpotResult = await Repository().getAll<TourismSpotModel>(
        query: Query.where('id', itinerary.tourismSpotId),
        policy: OfflineFirstGetPolicy.awaitRemote,
      );

      if (tourismSpotResult != null && tourismSpotResult.isNotEmpty) {
        final tourismSpotModel = tourismSpotResult.first;

        // Fetch associated images
        final tourismImageResults = await Repository()
            .getAll<TourismImageModel>(
              query: Query.where('tourismSpotId', tourismSpotModel.id),
              policy: OfflineFirstGetPolicy.awaitRemote,
            );

        final tourismImageEntities = tourismImageResults?.toEntityList() ?? [];

        // Map spot with images
        tourismSpotEntity = tourismSpotModel.toEntity(
          images: tourismImageEntities,
        );
      }
    }

    // Map itinerary
    return itinerary.toEntity(tourismSpot: tourismSpotEntity);
  }).toList();

  return Future.wait(itineraryEntitiesFutures);
}
