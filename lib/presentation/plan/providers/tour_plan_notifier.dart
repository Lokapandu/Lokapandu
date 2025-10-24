import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itineraries.dart';
import 'package:lokapandu/presentation/plan/models/plan_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TourPlanNotifier extends ChangeNotifier {
  final GetUserItineraries _useCase;
  final AnalyticsManager _analyticsManager;

  TourPlanNotifier(this._useCase, this._analyticsManager);

  List<PlanItem> _planItems = [];
  DateTime? _selectedDate;
  String? _errorMessage;
  bool _isLoading = false;

  List<PlanItem> get planItems => _planItems;

  bool get isLoading => _isLoading;

  DateTime? get selectedDate => _selectedDate;

  String? get errorMessage => _errorMessage;

  bool get hasError => _errorMessage != null;

  bool get hasData => _planItems.isNotEmpty;

  setSelectedDate(DateTime? date) {
    _selectedDate = date;
    fetchItineraries();
  }

  void reset() {
    _planItems = [];
    _errorMessage = null;
    _isLoading = false;
  }

  Future<void> fetchItineraries() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _analyticsManager.trackError(error: 'User is not logged in');
      _errorMessage = 'User is not logged in';
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await _analyticsManager.startTrace('fetchItineraries');
      final result = await _useCase.execute(
        user.id,
        filterByDate: _selectedDate?.toIso8601String(),
      );
      await _analyticsManager.stopTrace('fetchItineraries');
      result.fold(
        (failure) {
          _analyticsManager.trackError(
            error: failure.runtimeType.toString(),
            description: failure.message,
            parameters: {
              'provider': 'TourPlanNotifier',
              'stackTrace': StackTrace.current,
            },
          );
          _handleFailure(failure);
        },
        (itineraries) {
          _planItems = itineraries.map((e) => e.toPlanItem()).toList()
            ..sort((a, b) => a.date.compareTo(b.date));
          _analyticsManager.trackEvent(
            eventName: 'fetch_itineraries',
            parameters: {
              'itineraries_count': _planItems.length,
              'provider': 'TourPlanNotifier',
            },
          );
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    }

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

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
