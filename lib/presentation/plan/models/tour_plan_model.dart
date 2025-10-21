import 'package:flutter/material.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

class TourPlanModel {
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? notes;
  final TourismSpot? tourismSpot;

  TourPlanModel({
    required this.name,
    required this.startDate,
    required this.endDate,
    this.notes,
    this.tourismSpot,
  }) : startTime = startDate?.toTimeOfDay(),
       endTime = endDate?.toTimeOfDay();
}
