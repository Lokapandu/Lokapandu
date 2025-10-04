
enum PlanItemType { activity, tour }

class PlanItem {
  final PlanItemType type;
  final String title;
  final String timeRange;
  final String? tourImageUrl;
  final String? tourLocation;

  const PlanItem({
    required this.type,
    required this.title,
    required this.timeRange,
    this.tourImageUrl,
    this.tourLocation,
  });
}
