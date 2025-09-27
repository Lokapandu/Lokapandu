import 'package:flutter/material.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_list.dart';

class TourismSpotNotifier extends ChangeNotifier {
  final GetTourismSpotList _getTourismSpotList;

  TourismSpotNotifier(this._getTourismSpotList);

  List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TourismSpot> get tourismSpots => _tourismSpots;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasData => _tourismSpots.isNotEmpty;

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
    loadTourismSpots();
  }
}
