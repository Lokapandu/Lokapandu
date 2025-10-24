import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';

enum PlanItemType { tour, note, activity } // <-- 'activity' ditambahkan

class PlanItem {
  final String id;
  final String title;
  final DateTime date;
  final String timeRange;
  final PlanItemType type;
  final TourismSpot? tourismSpot;
  final TourPlanModel tourPlanModel;

  const PlanItem({
    required this.id,
    required this.title,
    required this.date,
    required this.timeRange,
    required this.type,
    this.tourismSpot,
    required this.tourPlanModel,
  });
}

extension PlanItemFromItinerary on Itinerary {
  PlanItem toPlanItem() {
    final startMinute = startTime.minute < 10
        ? '0${startTime.minute}'
        : startTime.minute.toString();
    final endMinute = endTime.minute < 10
        ? '0${endTime.minute}'
        : endTime.minute.toString();
    final timeRange =
        '${startTime.hour}:$startMinute - ${endTime.hour}:$endMinute';
    final tourImageUrl = tourismSpot?.images.first.imageUrl;
    return PlanItem(
      id: id,
      title: name,
      date: startTime,
      timeRange: timeRange,
      type: tourImageUrl != null ? PlanItemType.tour : PlanItemType.activity,
      tourismSpot: tourismSpot,
      tourPlanModel: TourPlanModel(
        id: id,
        name: name,
        startDate: startTime,
        endDate: endTime,
        notes: notes,
        tourismSpot: tourismSpot,
      ),
    );
  }
}
