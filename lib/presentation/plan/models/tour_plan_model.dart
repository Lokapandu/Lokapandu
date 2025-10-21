import 'package:flutter/material.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

class TourPlanModel {
  final String? id;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? notes;
  final TourismSpot? tourismSpot;

  TourPlanModel({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.notes,
    this.tourismSpot,
  }) : startTime = startDate?.toTimeOfDay(),
       endTime = endDate?.toTimeOfDay();

  @override
  String toString() {
    return 'TourPlanModel(id: $id, name: $name, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, notes: $notes, tourismSpot: $tourismSpot)';
  }
}

extension TourPlanModelFromItinerary on Itinerary {
  TourPlanModel toTourPlanModel() {
    return TourPlanModel(
      id: id,
      name: name,
      startDate: startTime,
      endDate: endTime,
      notes: notes,
      tourismSpot: tourismSpot,
    );
  }
}
