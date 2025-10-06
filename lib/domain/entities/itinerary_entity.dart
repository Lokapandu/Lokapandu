import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
part 'itinerary_entity.freezed.dart';

@freezed
abstract class Itinerary with _$Itinerary {
  const factory Itinerary({
    required int id,
    required String name,
    String? notes,
    required DateTime startTime,
    required DateTime endTime,
    required DateTime createdAt,

    TourismSpot? tourismSpot,
  }) = _Itinerary;
}
