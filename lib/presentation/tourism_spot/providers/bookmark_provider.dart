import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

class BookmarkProvider extends ChangeNotifier {

  final List<TourismSpot> _bookmarkedSpots = [];

  List<TourismSpot> get bookmarkedSpots => _bookmarkedSpots;

  bool isBookmarked(TourismSpot spot) {
    return _bookmarkedSpots.any((item) => item.id == spot.id);
  }

  void toggleBookmark(TourismSpot spot) {
    if (isBookmarked(spot)) {
      _bookmarkedSpots.removeWhere((item) => item.id == spot.id);
    } else {
      _bookmarkedSpots.add(spot);
    }
    notifyListeners();
  }
}
