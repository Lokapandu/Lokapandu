import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_detail.dart';

class TourismSpotDetailNotifier extends ChangeNotifier {
  final GetTourismSpotDetail _getTourismSpotDetail;

  TourismSpotDetailNotifier(this._getTourismSpotDetail);

  TourismSpot? _tourismSpot;
  List<TourismImage> _tourismImages = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedImage = '';

  TourismSpot? get tourismSpot => _tourismSpot;

  List<TourismImage> get images => _tourismImages;

  String? get errorMessage => _errorMessage;
  String get selectedImage => _selectedImage;

  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  bool get hasData => _tourismSpot != null;

  Future<void> loadTourismSpotDetail(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _getTourismSpotDetail.execute(id);

      result.fold(
        (failure) {
          _handleFailure(failure);
        },
        (spot) {
          _tourismSpot = spot;
          _tourismImages = spot.images;
          if (_tourismImages.isNotEmpty) {
            _selectedImage = _tourismImages.first.imageUrl;
          }
          _errorMessage = null;
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectImage(String image) {
    _selectedImage = image;
    notifyListeners();
  }

  //TODO: Implement more end-user friendly error message. Keep this as is for now.
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
    loadTourismSpotDetail(_tourismSpot?.id ?? 0);
  }
}
