import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spots_by_category.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/search_tourism_spots.dart';

class TourismSpotNotifier extends ChangeNotifier {
  final GetTourismSpotList _getTourismSpotList;
  final SearchTourismSpots _searchTourismSpots;
  final GetTourismSpotsByCategory _getTourismSpotsByCategory;
  final AnalyticsManager _analyticsManager;

  TourismSpotNotifier(
    this._getTourismSpotList,
    this._searchTourismSpots,
    this._getTourismSpotsByCategory,
    this._analyticsManager,
  );

  List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;
  Failure? _error;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  List<TourismSpot> get tourismSpots => _tourismSpots;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  Failure? get error => _error;
  bool get hasError => _error != null;

  bool get hasData => _tourismSpots.isNotEmpty;

  Timer? _debounce;

  Future<void> loadTourismSpots() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _analyticsManager.startTrace('loadTourismSpots');
      final result = await _getTourismSpotList.execute();
      _analyticsManager.setTraceMetric(
        'loadTourismSpots',
        'spotsCount',
        _tourismSpots.length,
      );
      _analyticsManager.stopTrace('loadTourismSpots');

      result.fold(
        (failure) {
          _analyticsManager.trackError(
            error: '${failure.runtimeType}',
            description: failure.message,
          );
          _error = failure;
        },
        (spots) {
          _tourismSpots = spots;
          _error = null;
        },
      );
    } catch (e) {
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (query.isEmpty) {
      await loadTourismSpots();
      return;
    }

    try {
      _analyticsManager.trackUserAction(
        action: 'user_typing_query',
        parameters: {'query': query},
      );
      _analyticsManager.startTrace('searchTourismSpots');
      final result = await _searchTourismSpots.execute(query);
      _analyticsManager.setTraceMetric(
        'searchTourismSpots',
        'spotsCount',
        _tourismSpots.length,
      );
      _analyticsManager.stopTrace('searchTourismSpots');
      result.fold(
        (failure) {
          _analyticsManager.trackError(
            error: '${failure.runtimeType}',
            description: failure.message,
          );
          _error = failure;
        },
        (spots) {
          _tourismSpots = spots;
          _error = null;
        },
      );
    } catch (e) {
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void refresh() {
    _analyticsManager.trackUserAction(action: 'user_refresh');
    if (_selectedCategory == 'Semua') {
      loadTourismSpots();
    } else {
      _analyticsManager.trackUserAction(
        action: 'user_filter_category',
        parameters: {'category': _selectedCategory},
      );
      filterByCategory(_selectedCategory);
    }
  }

  Future<void> filterByCategory(String category) async {
    _selectedCategory = category;

    if (category == 'Semua') {
      await loadTourismSpots();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _analyticsManager.startTrace('filterTourismSpotsByCategory');
      final result = await _getTourismSpotsByCategory.execute(category);
      _analyticsManager.setTraceAttribute(
        'filterTourismSpotsByCategory',
        'category',
        category,
      );
      _analyticsManager.setTraceMetric(
        'filterTourismSpotsByCategory',
        'spotsCount',
        _tourismSpots.length,
      );
      _analyticsManager.stopTrace('filterTourismSpotsByCategory');
      result.fold(
        (failure) {
          _analyticsManager.trackError(
            error: '${failure.runtimeType}',
            description: failure.message,
          );
          _error = failure;
        },
        (spots) {
          _tourismSpots = spots;
          _error = null;
        },
      );
    } catch (e) {
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
