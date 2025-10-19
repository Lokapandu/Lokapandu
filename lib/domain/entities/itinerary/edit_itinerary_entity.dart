import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_itinerary_entity.freezed.dart';

@freezed
abstract class EditItinerary with _$EditItinerary {
  const factory EditItinerary({
    required String id,
    String? name,
    String? notes,
    DateTime? startTime,
    DateTime? endTime,
    int? tourismSpot,
  }) = _EditItinerary;
}
