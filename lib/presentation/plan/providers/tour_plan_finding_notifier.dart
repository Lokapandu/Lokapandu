import 'package:flutter/material.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';

class TourPlanFindingNotifier extends ChangeNotifier {
  final GetTourismSpotList useCase;

  TourPlanFindingNotifier(this.useCase);
}
