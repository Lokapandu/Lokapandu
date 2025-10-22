import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/plan/models/tour_plan_model.dart';

class TourPlanEditorExtra {
  final TourPlanModel? editorModel;
  final TourismSpot? tourismSpot;

  const TourPlanEditorExtra({this.editorModel, this.tourismSpot});
}
