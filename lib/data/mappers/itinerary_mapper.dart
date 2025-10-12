import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

extension ItineraryEntityMapper on Itinerary {
  ItineraryModel toModel() => ItineraryModel(
    id: id,
    name: name,
    notes: notes,
    startTime: startTime,
    endTime: endTime,
    createdAt: createdAt,
    tourismSpotId: tourismSpot?.id,
  );
}

extension ItineraryModelMapper on ItineraryModel {
  Itinerary toEntity({TourismSpot? tourismSpot}) => Itinerary(
    id: id,
    name: name,
    notes: notes,
    startTime: startTime,
    endTime: endTime,
    createdAt: createdAt,
    tourismSpot: tourismSpot,
  );
}
