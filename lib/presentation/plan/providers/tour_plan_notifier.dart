import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itineraries.dart';
import 'package:lokapandu/presentation/plan/models/plan_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TourPlanNotifier extends ChangeNotifier {
  final GetUserItineraries _useCase;
  final AnalyticsManager _analyticsManager;

  TourPlanNotifier(this._useCase, this._analyticsManager);

  List<PlanItem> _planItems = [];
  List<PlanItem> get planItems => _planItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchItineraries() async {
    _isLoading = true;
    notifyListeners();

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _analyticsManager.trackError(error: 'User is not logged in');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final result = await _useCase.execute(user.id);
    result.fold(
      (failure) {
        _analyticsManager.trackError(error: failure.message);
        _isLoading = false;
        notifyListeners();
      },
      (itineraries) {
        _planItems = itineraries.map((e) => e.toPlanItem()).toList()
          ..sort((a, b) => a.date.compareTo(b.date));
        _analyticsManager.trackEvent(
          eventName: 'fetch_itineraries',
          parameters: {'itineraries_count': _planItems.length},
        );
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
