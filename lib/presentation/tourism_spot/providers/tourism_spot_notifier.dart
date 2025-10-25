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
          final prevCount = _tourismSpots.length;
          if (spots.isEmpty) {
            _hasMoreData = false;
            _analyticsManager.trackEvent(
              eventName: 'data_pagination',
              parameters: {
                'action': 'no_more_data',
                'page': _page,
                'total_items': _tourismSpots.length,
              },
            );
          } else {
            _tourismSpots.addAll(spots);
            _page++;
            // Selalu anggap masih ada data lagi kecuali server mengembalikan data kosong
            _hasMoreData = true;
            _analyticsManager.trackEvent(
              eventName: 'data_pagination',
              parameters: {
                'action': 'load_data',
                'page': _page - 1,
                'items_loaded': spots.length,
                'prev_count': prevCount,
                'new_count': _tourismSpots.length,
                'has_more_data': _hasMoreData,
              },
            );
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
            _analyticsManager.trackEvent(
              eventName: 'search_results',
              parameters: {
                'query': query,
                'results_count': 0,
                'has_results': false,
              },
            );
          } else {
            _tourismSpots = spots;
            _page = 2; // Set page ke 2 untuk next load
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
            _analyticsManager.trackEvent(
              eventName: 'search_results',
              parameters: {
                'query': query,
                'results_count': spots.length,
                'has_results': true,
                'has_more_data': _hasMoreData,
              },
            );
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
          _analyticsManager.trackError(
            error: '${failure.runtimeType}',
            description: failure.message,
          );
        },
        (spots) {
          final prevCount = _tourismSpots.length;
          if (spots.isEmpty) {
            _hasMoreData = false;
            _analyticsManager.trackEvent(
              eventName: 'load_more_by_category',
              parameters: {
                'category': category,
                'page': _page,
                'action': 'no_more_data',
                'total_items': _tourismSpots.length,
              },
            );
          } else {
            _tourismSpots.addAll(spots);
            _page++;
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
            _analyticsManager.trackEvent(
              eventName: 'load_more_by_category',
              parameters: {
                'category': category,
                'page': _page - 1,
                'items_loaded': spots.length,
                'prev_count': prevCount,
                'new_count': _tourismSpots.length,
                'has_more_data': _hasMoreData,
              },
            );
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
            _analyticsManager.trackEvent(
              eventName: 'filter_by_category_results',
              parameters: {
                'category': category,
                'results_count': 0,
                'has_results': false,
              },
            );
          } else {
            _tourismSpots = spots;
            _page = 2; // Set page ke 2 untuk next load
            // Jika jumlah data yang diterima kurang dari pageSize, berarti tidak ada data lagi
            if (spots.length < _pageSize) {
              _hasMoreData = false;
            }
            _analyticsManager.trackEvent(
              eventName: 'filter_by_category_results',
              parameters: {
                'category': category,
                'results_count': spots.length,
                'has_results': true,
                'has_more_data': _hasMoreData,
                'page': 1,
              },
            );
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
