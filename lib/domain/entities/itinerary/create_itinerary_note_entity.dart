import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_itinerary_note_entity.freezed.dart';

@freezed
abstract class CreateItineraryNote with _$CreateItineraryNote {
  const factory CreateItineraryNote({
    required String name,
    required String notes,
    required DateTime startTime,
    required DateTime endTime,
  }) = _CreateItineraryNote;
}
