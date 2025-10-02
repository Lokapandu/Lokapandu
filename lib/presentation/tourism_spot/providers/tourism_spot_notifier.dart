import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_list.dart';
import 'package:lokapandu/domain/usecases/search_tourism_spots.dart';

class TourismSpotNotifier extends ChangeNotifier {
  final GetTourismSpotList _getTourismSpotList;
  final SearchTourismSpots _searchTourismSpots;

  TourismSpotNotifier(this._getTourismSpotList, this._searchTourismSpots);

  List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TourismSpot> get tourismSpots => _tourismSpots;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  bool get hasData => _tourismSpots.isNotEmpty;

  Timer? _debounce;

  Future<void> loadTourismSpots() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _getTourismSpotList.execute();

      result.fold(
        (failure) {
          _handleFailure(failure);
        },
        (spots) {
          _tourismSpots = spots;
          _errorMessage = null;
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (query.isEmpty) {
      await loadTourismSpots();
      return;
    }

    try {
      final result = await _searchTourismSpots.execute(query);
      result.fold(
        (failure) {
          _handleFailure(failure);
        },
        (spots) {
          _tourismSpots = spots;
          _errorMessage = null;
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    failure.when(
      server: (message) => _errorMessage = 'Server Error: $message',
      connection: (message) => _errorMessage = 'Connection Error: $message',
      database: (message) => _errorMessage = 'Database Error: $message',
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void refresh() {
    loadTourismSpots();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}