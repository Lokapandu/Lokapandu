import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_itinerary_entity.freezed.dart';

@freezed
abstract class CreateItinerary with _$CreateItinerary {
  const factory CreateItinerary({
    required String name,
    String? notes,
    required DateTime startTime,
    required DateTime endTime,
    required int tourismSpot,
    required String userId,
  }) = _CreateItinerary;
}
