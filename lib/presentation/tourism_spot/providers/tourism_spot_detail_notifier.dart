import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_image_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_detail.dart';

class TourismSpotDetailNotifier extends ChangeNotifier {
  final GetTourismSpotDetail _getTourismSpotDetail;
  final AnalyticsManager _analyticsManager;

  TourismSpotDetailNotifier(this._getTourismSpotDetail, this._analyticsManager);

  TourismSpot? _tourismSpot;
  List<TourismImage> _tourismImages = [];
  bool _isLoading = false;
  Failure? _error;
  String _selectedImage = '';

  TourismSpot? get tourismSpot => _tourismSpot;

  List<TourismImage> get images => _tourismImages;

  String get selectedImage => _selectedImage;

  bool get isLoading => _isLoading;
  Failure? get error => _error;
  // bool get hasError => _errorMessage != null;
  bool get hasError => _error != null;
  bool get hasData => _tourismSpot != null;

  Future<void> loadTourismSpotDetail(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _getTourismSpotDetail.execute(id);

      result.fold(
        (failure) {
          _analyticsManager.trackError(
            error: '${failure.runtimeType}',
            description: failure.message,
          );
          _error = failure;
        },
        (spot) {
          _tourismSpot = spot;
          _tourismImages = spot.images;
          if (_tourismImages.isNotEmpty) {
            _selectedImage = _tourismImages.first.imageUrl;
          }
          _error = null;
        },
      );
    } catch (e) {
      _analyticsManager.trackError(
        error: 'ServerFailure',
        description: 'Unexpected error: ${e.toString()}',
      );
      _error = ServerFailure('Kesalahan tak terduga');
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectImage(String image) {
    _selectedImage = image;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void refresh() {
    loadTourismSpotDetail(_tourismSpot?.id ?? 0);
  }
}
