import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';

class TourismSpotNotifier extends ChangeNotifier {
  final GetTourismSpotList _useCase;
  final AnalyticsManager _analytics;

  TourismSpotNotifier(this._useCase, this._analytics);

  // === STATE VARIABLES ===
  final List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  Failure? _error;
  int _page = 1;
  final int _pageSize = 10;
  int _totalCount = 0;

  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Taman Budaya & Bersejarah',
    'Pantai & Pesisir',
    'Pusat Seni & Belanja',
    'Wisata Alam',
    'Kafe & Resto',
  ];
  Timer? _debounce;

  // === GETTERS ===
  List<TourismSpot> get tourismSpots => _tourismSpots;

  bool get isLoading => _isLoading;

  bool get hasMoreData => _hasMoreData;

  Failure? get error => _error;

  bool get isEmpty => _tourismSpots.isEmpty && !_isLoading;

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  List<String> get categories => _categories;

  int get totalCount => _totalCount;

  set searchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;

      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _resetAndReload();
      });
    }
  }

  set category(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _resetAndReload();
    }
  }

  void _resetAndReload() {
    _tourismSpots.clear();
    _page = 0;
    _hasMoreData = true;
    _error = null;
    _totalCount = 0;
    notifyListeners();
    loadMoreItems();
  }

  Future<void> loadMoreItems() async {
    print("=== LOAD MORE ITEMS DIPANGGIL ===");
    print("Status sebelum: isLoading=$_isLoading, hasMoreData=$_hasMoreData, page=$_page");
    
    if (_isLoading || !_hasMoreData) {
      print("Batal memuat: isLoading=$_isLoading, hasMoreData=$_hasMoreData");
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();
    print("Memulai pemuatan data: page=$_page, perPage=$_pageSize");

    try {
      print("Memanggil API dengan: page=$_page, perPage=$_pageSize, query=$_searchQuery, category=$_selectedCategory");
      final response = await _useCase.execute(
        page: _page,
        perPage: _pageSize,
        query: _searchQuery.isNotEmpty ? _searchQuery : null,
        category: _selectedCategory,
      );

      if (_page == 0) {
        print("Halaman 0, menghitung total data");
        final response = await _useCase.countTourismSpot(
          query: _searchQuery.isNotEmpty ? _searchQuery : null,
          category: _selectedCategory,
        );
        response.fold(
          (failure) {
            print("Error saat menghitung total: ${failure.message}");
            throw failure;
          }, 
          (data) {
            _totalCount = data;
            print("Total count dari API: $_totalCount");
          }
        );
      }

      var length = 0;
      var oldLength = _tourismSpots.length;
      
      response.fold(
        (failure) {
          print("Error saat memuat data: ${failure.message}");
          throw failure;
        }, 
        (data) {
          print("Data diterima dari API: ${data.length} item");
          if (data.isEmpty) {
            print("PERINGATAN: Data kosong diterima dari API!");
          } else {
            print("Item pertama: ${data.first.name}");
          }
          
          _tourismSpots.addAll(data);
          length = data.length;
        }
      );
      
      print("Jumlah data sebelum: $oldLength, sesudah: ${_tourismSpots.length}, baru ditambahkan: $length");
      
      _page++;
      if (length < _pageSize) {
        _hasMoreData = false;
        print("hasMoreData diatur ke false karena data kurang dari pageSize");
      }
      // Atau cek berdasarkan total count
      if (_tourismSpots.length >= _totalCount) {
        _hasMoreData = false;
        print("hasMoreData diatur ke false karena total data >= totalCount");
      }
      
      print("Data loaded: total=${_tourismSpots.length}, hasMore=${_hasMoreData}, page=${_page}");
    } catch (e) {
      print("ERROR TERJADI: $e");
      _error = ServerFailure('Kesalahan tak terduga: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
      print("=== LOAD MORE ITEMS SELESAI ===");
    }
  }

  Future<void> refreshData() async {
    _tourismSpots.clear();
    _page = 0;
    _hasMoreData = true;
    _error = null;
    _totalCount = 0;
    notifyListeners();
    _analytics.trackEvent(eventName: 'tourism_spot_notifier_refreshing_data');
    await loadMoreItems();
  }

  // Clear error state
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
