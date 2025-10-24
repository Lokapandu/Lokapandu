import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class ItineraryValidators {
  static const int _maxNameLength = 35;
  static const int _maxNotesLength = 250;
  static const int _bufferTimeMinutes = 1;

  final ItineraryRepository _repository;

  ItineraryValidators(this._repository);

  Either<Failure, Unit> validateTimeRange(
    DateTime startTime,
    DateTime endTime,
  ) {
    if (startTime.isAfter(endTime)) {
      return Left(
        InvalidTimeRangeFailure('Waktu mulai harus sebelum waktu selesai'),
      );
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateTimeFormat(
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  ) {
    if (startTime == null || endTime == null) {
      return Left(
        InvalidTimeFormatFailure(
          'Format waktu tidak valid. Silakan masukkan waktu yang valid',
        ),
      );
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateFutureTime(DateTime startTime) {
    final now = DateTime.now();
    if (startTime.isBefore(now)) {
      return Left(ValidationFailure('Waktu mulai harus di masa depan'));
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateFieldLengths({
    required String name,
    String? notes,
  }) {
    if (name.length > _maxNameLength) {
      return Left(
        ValidationFailure('Nama tidak boleh melebihi $_maxNameLength karakter'),
      );
    }

    if (notes != null && notes.length > _maxNotesLength) {
      return Left(
        ValidationFailure(
          'Catatan tidak boleh melebihi $_maxNotesLength karakter',
        ),
      );
    }

    return Right(unit);
  }

  Future<Either<Failure, Unit>> validateTourismSpotExists(
    int? tourismSpotId,
  ) async {
    if (tourismSpotId == null) {
      return Right(unit);
    }

    try {
      final result = await _repository.checkTourismSpotExists(tourismSpotId);

      return result.fold(
        (failure) => Left(failure),
        (exists) => exists
            ? Right(unit)
            : Left(ValidationFailure('Tempat wisata tidak ditemukan')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Validators");
      return Left(
        ServerFailure(
          'Kesalahan saat memvalidasi tempat wisata: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> checkSchedulingConflicts(
    String userId,
    DateTime startTime,
    DateTime endTime, [
    String? excludeItineraryId,
  ]) async {
    try {
      final result = await _repository.checkSchedulingConflicts(
        userId,
        startTime,
        endTime,
        excludeItineraryId,
      );

      return result.fold(
        (failure) => Left(failure),
        (hasConflict) => hasConflict
            ? Left(
                SchedulingConflictFailure(
                  'Tidak dapat menambahkan itinerary - terdeteksi konflik jadwal. '
                  'Pastikan ada jeda minimal $_bufferTimeMinutes menit antara itinerary',
                ),
              )
            : Right(unit),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Validators");
      return Left(
        ServerFailure(
          'Kesalahan saat memeriksa konflik jadwal: ${e.toString()}',
        ),
      );
    }
  }

  Either<Failure, Unit> validateRequiredFields(CreateItinerary itineraryInput) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Nama itinerary wajib diisi'));
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateNoteRequiredFields(
    CreateItineraryNote itineraryInput,
  ) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Nama itinerary wajib diisi'));
    } else if (itineraryInput.notes.trim().isEmpty) {
      return Left(MissingFieldFailure('Konten itinerary wajib diisi'));
    }
    return Right(unit);
  }
}
