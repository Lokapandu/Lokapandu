import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';

class TourismSpotNotifier extends ChangeNotifier {
  final GetTourismSpotList _getTourismSpotList;
  final AnalyticsManager _analyticsManager;

  TourismSpotNotifier(this._getTourismSpotList, this._analyticsManager);

  List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  Failure? _error;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  int _page = 1;
  final int _pageSize = 6;

  List<TourismSpot> get tourismSpots => _tourismSpots;

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  bool get isLoading => _isLoading;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMoreData => _hasMoreData;

  Failure? get error => _error;

  bool get hasError => _error != null;

  bool get hasData => _tourismSpots.isNotEmpty;

  Timer? _debounce;

  Future<void> loadTourismSpots({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMoreData = true;
      _tourismSpots = [];
    }

    if (_isLoading || (!_hasMoreData && !refresh)) return;

    _isLoading = _page == 1;
    _isLoadingMore = _page > 1;
    _error = null;
    notifyListeners();

    try {
      _analyticsManager.startTrace('loadTourismSpots');
      // Menggunakan parameter paginasi yang tersedia di usecase
      final result = await _getTourismSpotList.execute(
        query: _searchQuery,
        category: _selectedCategory != 'Semua' ? _selectedCategory : null,
        page: _page,
        perPage: _pageSize,
      );
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
          if (spots.isEmpty) {
            _hasMoreData = false;
          } else {
            _tourismSpots.addAll(spots);
            _page++;
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
          }
          _error = null;
        },
      );
    } catch (e) {
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoading = false;
    _isLoadingMore = false;
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
    _page = 1;
    _hasMoreData = true;
    _tourismSpots = [];
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (query.isEmpty) {
      await loadTourismSpots(refresh: true);
      return;
    }

    try {
      _analyticsManager.trackUserAction(
        action: 'user_typing_query',
        parameters: {'query': query},
      );
      _analyticsManager.startTrace('searchTourismSpots');
      // Menggunakan parameter paginasi yang tersedia di usecase
      final result = await _getTourismSpotList.execute(
        query: query,
        page: _page,
        perPage: _pageSize,
      );
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
          if (spots.isEmpty) {
            _hasMoreData = false;
          } else {
            _tourismSpots = spots;
            _page = 2; // Set page ke 2 untuk next load
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
          }
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
      loadTourismSpots(refresh: true);
    } else {
      _analyticsManager.trackUserAction(
        action: 'user_filter_category',
        parameters: {'category': _selectedCategory},
      );
      filterByCategory(_selectedCategory);
    }
  }

  Future<void> loadMoreByCategory(String category) async {
    if (!_hasMoreData || _isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      // Menggunakan parameter paginasi yang tersedia di usecase
      final result = await _getTourismSpotList.execute(
        category: category,
        page: _page,
        perPage: _pageSize,
      );

      result.fold(
        (failure) {
          _error = failure;
        },
        (spots) {
          if (spots.isEmpty) {
            _hasMoreData = false;
          } else {
            _tourismSpots.addAll(spots);
            _page++;
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
          }
        },
      );
    } catch (e) {
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> filterByCategory(String category) async {
    _selectedCategory = category;
    _page = 1;
    _hasMoreData = true;
    _tourismSpots = [];

    if (category == 'Semua') {
      await loadTourismSpots(refresh: true);
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _analyticsManager.startTrace('filterTourismSpotsByCategory');
      // Menggunakan parameter paginasi yang tersedia di usecase
      final result = await _getTourismSpotList.execute(
        category: category,
        page: _page,
        perPage: _pageSize,
      );
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
          if (spots.isEmpty) {
            _hasMoreData = false;
          } else {
            _tourismSpots = spots;
            _page = 2; // Set page ke 2 untuk next load
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
          }
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
