import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';

enum PlanItemType { tour, note, activity } // <-- 'activity' ditambahkan

class PlanItem {
  final String title;
  final String timeRange;
  final PlanItemType type;
  final String? tourImageUrl;
  final String? tourLocation;

  const PlanItem({
    required this.title,
    required this.timeRange,
    required this.type,
    this.tourImageUrl,
    this.tourLocation,
  });
}

extension PlanItemFromItinerary on Itinerary {
  PlanItem toPlanItem() {
    final timeRange =
        '${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}';
    final tourImageUrl = tourismSpot?.images.first.imageUrl;
    return PlanItem(
      title: name,
      timeRange: timeRange,
      type: tourImageUrl != null ? PlanItemType.tour : PlanItemType.activity,
      tourImageUrl: tourImageUrl,
      tourLocation: tourismSpot?.address,
    );
  }
}
