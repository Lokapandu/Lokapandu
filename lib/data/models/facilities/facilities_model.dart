import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/facilities.dart';
part 'facilities_model.freezed.dart';
part 'facilities_model.g.dart';

@freezed
abstract class FacilitiesModel with _$FacilitiesModel {
  const factory FacilitiesModel({required String id, required String name}) =
      _FacilitiesModel;

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) =>
      _$FacilitiesModelFromJson(json);
}

extension FacilitiesModelX on FacilitiesModel {
  Facilities toEntity() => Facilities(id: id, name: name);
}
