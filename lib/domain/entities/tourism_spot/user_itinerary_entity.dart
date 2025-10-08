import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_itinerary_entity.freezed.dart';

@freezed
abstract class UserItinerary with _$UserItinerary {
  const factory UserItinerary({
    required int id,
    required String userId,
    required String itinerariesId,
    required DateTime createdAt,
  }) = _UserItinerary;
}