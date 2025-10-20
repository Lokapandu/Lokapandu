import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';

enum PlanItemType { tour, note, activity } // <-- 'activity' ditambahkan

class PlanItem {
  final String title;
  final DateTime date;
  final String timeRange;
  final PlanItemType type;
  final String? tourImageUrl;
  final String? tourLocation;

  const PlanItem({
    required this.title,
    required this.date,
    required this.timeRange,
    required this.type,
    this.tourImageUrl,
    this.tourLocation,
  });
}

extension PlanItemFromItinerary on Itinerary {
  PlanItem toPlanItem() {
    final startMinute = startTime.minute < 10
        ? startTime.minute * 10
        : startTime.minute;
    final endMinute = endTime.minute < 10
        ? endTime.minute * 10
        : endTime.minute;
    final timeRange =
        '${startTime.hour}:$startMinute - ${endTime.hour}:$endMinute';
    final tourImageUrl = tourismSpot?.images.first.imageUrl;
    return PlanItem(
      title: name,
      date: startTime,
      timeRange: timeRange,
      type: tourImageUrl != null ? PlanItemType.tour : PlanItemType.activity,
      tourImageUrl: tourImageUrl,
      tourLocation: tourismSpot?.address,
    );
  }
}
