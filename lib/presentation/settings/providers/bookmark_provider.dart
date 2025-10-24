import 'package:flutter/material.dart';
import 'package:lokapandu/data/datasources/services/bookmark_database.dart';

import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

class BookmarkProvider extends ChangeNotifier {
  final BookmarkDatabaseService _service;

  BookmarkProvider(this._service);

  String _message = "";
  String get message => _message;
  List<TourismSpot>? _bookmarkedSpots;
  List<TourismSpot>? get bookmarkedSpots => _bookmarkedSpots;
  TourismSpot? _tourism;
  TourismSpot? get tourism => _tourism;

  Future<void> loadAllTourismValue() async {
    try {
      _bookmarkedSpots = await _service.getBookmarkedSpots();
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> saveTourismValue(TourismSpot value) async {
    try {
      final result = await _service.addBookmark(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  Future<void> loadTourismValueById(int id) async {
    try {
      _tourism = await _service.getBookmarkedSpotById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeTourismValueById(int id) async {
    try {
      await _service.removeBookmark(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(int id) {
    final isSameBookmark = _tourism?.id == id;
    return isSameBookmark;
  }
}
