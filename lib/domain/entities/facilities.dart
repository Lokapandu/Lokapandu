import 'package:freezed_annotation/freezed_annotation.dart';

part 'facilities.freezed.dart';

@freezed
abstract class Facilities with _$Facilities {
  const factory Facilities({required String name, required String id}) =
      _Facilities;
}
