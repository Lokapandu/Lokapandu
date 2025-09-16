// model ini akan berhubungan langsung dengan supabase table tourism_spot
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/data/models/tourism_spot/ts_model/tourism_spot_model.dart';
part 'tourism_spot_response.freezed.dart';
part 'tourism_spot_response.g.dart';

@freezed
abstract class TourismSpotResponse with _$TourismSpotResponse {
  const factory TourismSpotResponse({required List<TourismSpotModel> models}) =
      _TourismSpotResponse;

  factory TourismSpotResponse.fromJson(Map<String, dynamic> json) =>
      _$TourismSpotResponseFromJson(json);
}
