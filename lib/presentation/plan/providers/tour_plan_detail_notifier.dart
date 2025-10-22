import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/usecases/itineraries/delete_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itinerary_by_id.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';

class TourPlanDetailNotifier extends ChangeNotifier {
  final GetUserItineraryById _useCase;
  final DeleteUserItineraries _deleteUseCase;
  final AnalyticsManager _manager;

  TourPlanDetailNotifier(this._useCase, this._manager, this._deleteUseCase);

  bool _isLoading = false;
  String? _errorMessage;
  TourPlanModel? _model;
  bool _hasRemoved = false;

  TourPlanModel? get model => _model;

  bool get isLoading => _isLoading;

  bool get hasData => _model != null;

  bool get hasTourism => _model?.tourismSpot != null;

  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  bool get hasRemoved => _hasRemoved;

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
        _model = TourPlanModel.fromItinerary(data);
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

  Future<void> removeItinerary(String id) async {
    _isLoading = true;
    notifyListeners();

    final result = await _deleteUseCase.execute(id);
    result.fold(
      (failure) {
        _manager.trackError(
          error: failure.runtimeType.toString(),
          description: failure.message,
          parameters: {
            'id': id,
            'type': 'removeItinerary',
            'provider': 'TourPlanDetailNotifier',
            'stackTrace': StackTrace.current,
          },
        );
        _handleFailure(failure);
      },
      (_) {
        _model = null;
        _errorMessage = null;
        _hasRemoved = true;
        _manager.trackEvent(
          eventName: 'itinerary_removed',
          parameters: {'id': id, 'provider': 'TourPlanDetailNotifier'},
        );
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
