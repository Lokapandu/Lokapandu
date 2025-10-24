import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';

class TourPlanFindingNotifier extends ChangeNotifier {
  final GetTourismSpotList useCase;
  final AnalyticsManager _analyticsManager;

  TourPlanFindingNotifier(this.useCase, this._analyticsManager);

  List<TourismSpot> _searchResults = [];

  List<TourismSpot> get searchResults => _searchResults;
  TourismSpot? _selectedSpot;

  TourismSpot? get selectedSpot => _selectedSpot;

  set selectedSpot(TourismSpot? spot) {
    _selectedSpot = spot;
    notifyListeners();
  }

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  Future<void> get({String? query, void Function(String?)? onError}) async {
    _isSearching = true;
    notifyListeners();

    await _analyticsManager.startTrace('searchTourismSpot');
    final result = await useCase.execute(query: query);
    await _analyticsManager.stopTrace('searchTourismSpot');
    
    _searchResults = result.fold((failure) {
      _analyticsManager.trackError(
        error: failure.message,
        parameters: {
          'query': query ?? 'empty',
          'provider': 'TourPlanFindingNotifier',
          'stackTrace': StackTrace.current,
        },
      );
      onError?.call(failure.message);
      return [];
    }, (spots) => spots);
    _analyticsManager.trackEvent(
      eventName: 'search_tourism_spot',
      parameters: {
        'query': query ?? 'empty',
        'provider': 'TourPlanFindingNotifier',
      },
    );
    notifyListeners();

    _isSearching = false;
    notifyListeners();
  }
}
