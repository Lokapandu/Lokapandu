import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itinerary_by_id.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';

class TourPlanDetailNotifier extends ChangeNotifier {
  final GetUserItineraryById _useCase;
  final AnalyticsManager _manager;

  TourPlanDetailNotifier(this._useCase, this._manager);

  bool _isLoading = false;
  String? _errorMessage;
  TourPlanModel? _model;
  TourPlanModel? get model => _model;

  bool get isLoading => _isLoading;
  bool get hasData => _model != null;
  bool get hasTourism => _model?.tourismSpot != null;
  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  Future<void> fetchItinerary(String id) async {
    _isLoading = true;
    notifyListeners();

    final result = await _useCase.execute(id);
    result.fold(
      (failure) {
        _manager.trackError(
          error: failure.runtimeType.toString(),
          description: failure.message,
          parameters: {
            'id': id,
            'type': 'fetchItinerary',
            'provider': 'TourPlanDetailNotifier',
          },
        );
        _handleFailure(failure);
      },
      (Itinerary data) {
        _model = data.toTourPlanModel();
        _errorMessage = null;
        _manager.trackEvent(
          eventName: 'fetch_itinerary',
          parameters: {'id': id, 'provider': 'TourPlanDetailNotifier'},
        );
        dev.log('Data: $data');
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    failure.maybeWhen(
      server: (message) => _errorMessage = 'Server Error: $message',
      connection: (message) => _errorMessage = 'Connection Error: $message',
      database: (message) => _errorMessage = 'Database Error: $message',
      orElse: () => _errorMessage = 'Unknown Error',
    );
  }
}
