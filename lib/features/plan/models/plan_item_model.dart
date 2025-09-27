// File: lib/features/plan/models/plan_item_model.dart

enum PlanItemType { activity, tour }

class PlanItem {
  final PlanItemType type;
  final String title;
  final String timeRange;
  final String? tourImageUrl; // Hanya untuk tipe 'tour'
  final String? tourLocation; // Hanya untuk tipe 'tour'

  const PlanItem({
    required this.type,
    required this.title,
    required this.timeRange,
    this.tourImageUrl,
    this.tourLocation,
  });
}
