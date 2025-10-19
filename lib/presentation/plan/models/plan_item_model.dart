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
