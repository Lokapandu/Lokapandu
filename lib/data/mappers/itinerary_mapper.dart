import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

extension ItineraryEntityMapper on Itinerary {
  ItineraryModel toModel() => ItineraryModel(
    id: id,
    name: name,
    notes: notes,
    startTime: startTime.toIso8601String(),
    endTime: endTime.toIso8601String(),
    createdAt: createdAt,
    tourismSpotId: tourismSpot?.id,
  );
}

extension ItineraryModelMapper on ItineraryModel {
  Itinerary toEntity({TourismSpot? tourismSpot}) => Itinerary(
    id: id,
    name: name,
    notes: notes,
    startTime: DateTime.parse(startTime),
    endTime: DateTime.parse(endTime),
    createdAt: createdAt,
    tourismSpot: tourismSpot,
  );
}
