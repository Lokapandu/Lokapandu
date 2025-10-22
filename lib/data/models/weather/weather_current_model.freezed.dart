// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_current_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherCurrentModel {

@JsonKey(name: "last_updated_epoch") int get lastUpdatedEpoch;@JsonKey(name: "last_updated") String get lastUpdated;@JsonKey(name: "temp_c") double get tempC;@JsonKey(name: "temp_f") double get tempF;@JsonKey(name: "is_day") int get isDay;@JsonKey(name: "condition") WeatherCurrentConditionModel get condition;@JsonKey(name: "wind_mph") double get windMph;@JsonKey(name: "wind_kph") double get windKph;@JsonKey(name: "wind_degree") int get windDegree;@JsonKey(name: "wind_dir") String get windDir;@JsonKey(name: "pressure_mb") int get pressureMb;@JsonKey(name: "pressure_in") double get pressureIn;@JsonKey(name: "precip_mm") int get precipMm;@JsonKey(name: "precip_in") int get precipIn;@JsonKey(name: "humidity") int get humidity;@JsonKey(name: "cloud") int get cloud;@JsonKey(name: "feelslike_c") double get feelslikeC;@JsonKey(name: "feelslike_f") int get feelslikeF;@JsonKey(name: "windchill_c") double get windchillC;@JsonKey(name: "windchill_f") double get windchillF;@JsonKey(name: "heatindex_c") double get heatindexC;@JsonKey(name: "heatindex_f") int get heatindexF;@JsonKey(name: "dewpoint_c") double get dewpointC;@JsonKey(name: "dewpoint_f") double get dewpointF;@JsonKey(name: "vis_km") int get visKm;@JsonKey(name: "vis_miles") int get visMiles;@JsonKey(name: "uv") double get uv;@JsonKey(name: "gust_mph") double get gustMph;@JsonKey(name: "gust_kph") double get gustKph;
/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCurrentModelCopyWith<WeatherCurrentModel> get copyWith => _$WeatherCurrentModelCopyWithImpl<WeatherCurrentModel>(this as WeatherCurrentModel, _$identity);

  /// Serializes this WeatherCurrentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherCurrentModel&&(identical(other.lastUpdatedEpoch, lastUpdatedEpoch) || other.lastUpdatedEpoch == lastUpdatedEpoch)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.tempC, tempC) || other.tempC == tempC)&&(identical(other.tempF, tempF) || other.tempF == tempF)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.windMph, windMph) || other.windMph == windMph)&&(identical(other.windKph, windKph) || other.windKph == windKph)&&(identical(other.windDegree, windDegree) || other.windDegree == windDegree)&&(identical(other.windDir, windDir) || other.windDir == windDir)&&(identical(other.pressureMb, pressureMb) || other.pressureMb == pressureMb)&&(identical(other.pressureIn, pressureIn) || other.pressureIn == pressureIn)&&(identical(other.precipMm, precipMm) || other.precipMm == precipMm)&&(identical(other.precipIn, precipIn) || other.precipIn == precipIn)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.cloud, cloud) || other.cloud == cloud)&&(identical(other.feelslikeC, feelslikeC) || other.feelslikeC == feelslikeC)&&(identical(other.feelslikeF, feelslikeF) || other.feelslikeF == feelslikeF)&&(identical(other.windchillC, windchillC) || other.windchillC == windchillC)&&(identical(other.windchillF, windchillF) || other.windchillF == windchillF)&&(identical(other.heatindexC, heatindexC) || other.heatindexC == heatindexC)&&(identical(other.heatindexF, heatindexF) || other.heatindexF == heatindexF)&&(identical(other.dewpointC, dewpointC) || other.dewpointC == dewpointC)&&(identical(other.dewpointF, dewpointF) || other.dewpointF == dewpointF)&&(identical(other.visKm, visKm) || other.visKm == visKm)&&(identical(other.visMiles, visMiles) || other.visMiles == visMiles)&&(identical(other.uv, uv) || other.uv == uv)&&(identical(other.gustMph, gustMph) || other.gustMph == gustMph)&&(identical(other.gustKph, gustKph) || other.gustKph == gustKph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,lastUpdatedEpoch,lastUpdated,tempC,tempF,isDay,condition,windMph,windKph,windDegree,windDir,pressureMb,pressureIn,precipMm,precipIn,humidity,cloud,feelslikeC,feelslikeF,windchillC,windchillF,heatindexC,heatindexF,dewpointC,dewpointF,visKm,visMiles,uv,gustMph,gustKph]);

@override
String toString() {
  return 'WeatherCurrentModel(lastUpdatedEpoch: $lastUpdatedEpoch, lastUpdated: $lastUpdated, tempC: $tempC, tempF: $tempF, isDay: $isDay, condition: $condition, windMph: $windMph, windKph: $windKph, windDegree: $windDegree, windDir: $windDir, pressureMb: $pressureMb, pressureIn: $pressureIn, precipMm: $precipMm, precipIn: $precipIn, humidity: $humidity, cloud: $cloud, feelslikeC: $feelslikeC, feelslikeF: $feelslikeF, windchillC: $windchillC, windchillF: $windchillF, heatindexC: $heatindexC, heatindexF: $heatindexF, dewpointC: $dewpointC, dewpointF: $dewpointF, visKm: $visKm, visMiles: $visMiles, uv: $uv, gustMph: $gustMph, gustKph: $gustKph)';
}


}

/// @nodoc
abstract mixin class $WeatherCurrentModelCopyWith<$Res>  {
  factory $WeatherCurrentModelCopyWith(WeatherCurrentModel value, $Res Function(WeatherCurrentModel) _then) = _$WeatherCurrentModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "last_updated_epoch") int lastUpdatedEpoch,@JsonKey(name: "last_updated") String lastUpdated,@JsonKey(name: "temp_c") double tempC,@JsonKey(name: "temp_f") double tempF,@JsonKey(name: "is_day") int isDay,@JsonKey(name: "condition") WeatherCurrentConditionModel condition,@JsonKey(name: "wind_mph") double windMph,@JsonKey(name: "wind_kph") double windKph,@JsonKey(name: "wind_degree") int windDegree,@JsonKey(name: "wind_dir") String windDir,@JsonKey(name: "pressure_mb") int pressureMb,@JsonKey(name: "pressure_in") double pressureIn,@JsonKey(name: "precip_mm") int precipMm,@JsonKey(name: "precip_in") int precipIn,@JsonKey(name: "humidity") int humidity,@JsonKey(name: "cloud") int cloud,@JsonKey(name: "feelslike_c") double feelslikeC,@JsonKey(name: "feelslike_f") int feelslikeF,@JsonKey(name: "windchill_c") double windchillC,@JsonKey(name: "windchill_f") double windchillF,@JsonKey(name: "heatindex_c") double heatindexC,@JsonKey(name: "heatindex_f") int heatindexF,@JsonKey(name: "dewpoint_c") double dewpointC,@JsonKey(name: "dewpoint_f") double dewpointF,@JsonKey(name: "vis_km") int visKm,@JsonKey(name: "vis_miles") int visMiles,@JsonKey(name: "uv") double uv,@JsonKey(name: "gust_mph") double gustMph,@JsonKey(name: "gust_kph") double gustKph
});


$WeatherCurrentConditionModelCopyWith<$Res> get condition;

}
/// @nodoc
class _$WeatherCurrentModelCopyWithImpl<$Res>
    implements $WeatherCurrentModelCopyWith<$Res> {
  _$WeatherCurrentModelCopyWithImpl(this._self, this._then);

  final WeatherCurrentModel _self;
  final $Res Function(WeatherCurrentModel) _then;

/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdatedEpoch = null,Object? lastUpdated = null,Object? tempC = null,Object? tempF = null,Object? isDay = null,Object? condition = null,Object? windMph = null,Object? windKph = null,Object? windDegree = null,Object? windDir = null,Object? pressureMb = null,Object? pressureIn = null,Object? precipMm = null,Object? precipIn = null,Object? humidity = null,Object? cloud = null,Object? feelslikeC = null,Object? feelslikeF = null,Object? windchillC = null,Object? windchillF = null,Object? heatindexC = null,Object? heatindexF = null,Object? dewpointC = null,Object? dewpointF = null,Object? visKm = null,Object? visMiles = null,Object? uv = null,Object? gustMph = null,Object? gustKph = null,}) {
  return _then(_self.copyWith(
lastUpdatedEpoch: null == lastUpdatedEpoch ? _self.lastUpdatedEpoch : lastUpdatedEpoch // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,tempC: null == tempC ? _self.tempC : tempC // ignore: cast_nullable_to_non_nullable
as double,tempF: null == tempF ? _self.tempF : tempF // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCurrentConditionModel,windMph: null == windMph ? _self.windMph : windMph // ignore: cast_nullable_to_non_nullable
as double,windKph: null == windKph ? _self.windKph : windKph // ignore: cast_nullable_to_non_nullable
as double,windDegree: null == windDegree ? _self.windDegree : windDegree // ignore: cast_nullable_to_non_nullable
as int,windDir: null == windDir ? _self.windDir : windDir // ignore: cast_nullable_to_non_nullable
as String,pressureMb: null == pressureMb ? _self.pressureMb : pressureMb // ignore: cast_nullable_to_non_nullable
as int,pressureIn: null == pressureIn ? _self.pressureIn : pressureIn // ignore: cast_nullable_to_non_nullable
as double,precipMm: null == precipMm ? _self.precipMm : precipMm // ignore: cast_nullable_to_non_nullable
as int,precipIn: null == precipIn ? _self.precipIn : precipIn // ignore: cast_nullable_to_non_nullable
as int,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,cloud: null == cloud ? _self.cloud : cloud // ignore: cast_nullable_to_non_nullable
as int,feelslikeC: null == feelslikeC ? _self.feelslikeC : feelslikeC // ignore: cast_nullable_to_non_nullable
as double,feelslikeF: null == feelslikeF ? _self.feelslikeF : feelslikeF // ignore: cast_nullable_to_non_nullable
as int,windchillC: null == windchillC ? _self.windchillC : windchillC // ignore: cast_nullable_to_non_nullable
as double,windchillF: null == windchillF ? _self.windchillF : windchillF // ignore: cast_nullable_to_non_nullable
as double,heatindexC: null == heatindexC ? _self.heatindexC : heatindexC // ignore: cast_nullable_to_non_nullable
as double,heatindexF: null == heatindexF ? _self.heatindexF : heatindexF // ignore: cast_nullable_to_non_nullable
as int,dewpointC: null == dewpointC ? _self.dewpointC : dewpointC // ignore: cast_nullable_to_non_nullable
as double,dewpointF: null == dewpointF ? _self.dewpointF : dewpointF // ignore: cast_nullable_to_non_nullable
as double,visKm: null == visKm ? _self.visKm : visKm // ignore: cast_nullable_to_non_nullable
as int,visMiles: null == visMiles ? _self.visMiles : visMiles // ignore: cast_nullable_to_non_nullable
as int,uv: null == uv ? _self.uv : uv // ignore: cast_nullable_to_non_nullable
as double,gustMph: null == gustMph ? _self.gustMph : gustMph // ignore: cast_nullable_to_non_nullable
as double,gustKph: null == gustKph ? _self.gustKph : gustKph // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherCurrentConditionModelCopyWith<$Res> get condition {
  
  return $WeatherCurrentConditionModelCopyWith<$Res>(_self.condition, (value) {
    return _then(_self.copyWith(condition: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeatherCurrentModel].
extension WeatherCurrentModelPatterns on WeatherCurrentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherCurrentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherCurrentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherCurrentModel value)  $default,){
final _that = this;
switch (_that) {
case _WeatherCurrentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherCurrentModel value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherCurrentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "last_updated_epoch")  int lastUpdatedEpoch, @JsonKey(name: "last_updated")  String lastUpdated, @JsonKey(name: "temp_c")  double tempC, @JsonKey(name: "temp_f")  double tempF, @JsonKey(name: "is_day")  int isDay, @JsonKey(name: "condition")  WeatherCurrentConditionModel condition, @JsonKey(name: "wind_mph")  double windMph, @JsonKey(name: "wind_kph")  double windKph, @JsonKey(name: "wind_degree")  int windDegree, @JsonKey(name: "wind_dir")  String windDir, @JsonKey(name: "pressure_mb")  int pressureMb, @JsonKey(name: "pressure_in")  double pressureIn, @JsonKey(name: "precip_mm")  int precipMm, @JsonKey(name: "precip_in")  int precipIn, @JsonKey(name: "humidity")  int humidity, @JsonKey(name: "cloud")  int cloud, @JsonKey(name: "feelslike_c")  double feelslikeC, @JsonKey(name: "feelslike_f")  int feelslikeF, @JsonKey(name: "windchill_c")  double windchillC, @JsonKey(name: "windchill_f")  double windchillF, @JsonKey(name: "heatindex_c")  double heatindexC, @JsonKey(name: "heatindex_f")  int heatindexF, @JsonKey(name: "dewpoint_c")  double dewpointC, @JsonKey(name: "dewpoint_f")  double dewpointF, @JsonKey(name: "vis_km")  int visKm, @JsonKey(name: "vis_miles")  int visMiles, @JsonKey(name: "uv")  double uv, @JsonKey(name: "gust_mph")  double gustMph, @JsonKey(name: "gust_kph")  double gustKph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherCurrentModel() when $default != null:
return $default(_that.lastUpdatedEpoch,_that.lastUpdated,_that.tempC,_that.tempF,_that.isDay,_that.condition,_that.windMph,_that.windKph,_that.windDegree,_that.windDir,_that.pressureMb,_that.pressureIn,_that.precipMm,_that.precipIn,_that.humidity,_that.cloud,_that.feelslikeC,_that.feelslikeF,_that.windchillC,_that.windchillF,_that.heatindexC,_that.heatindexF,_that.dewpointC,_that.dewpointF,_that.visKm,_that.visMiles,_that.uv,_that.gustMph,_that.gustKph);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "last_updated_epoch")  int lastUpdatedEpoch, @JsonKey(name: "last_updated")  String lastUpdated, @JsonKey(name: "temp_c")  double tempC, @JsonKey(name: "temp_f")  double tempF, @JsonKey(name: "is_day")  int isDay, @JsonKey(name: "condition")  WeatherCurrentConditionModel condition, @JsonKey(name: "wind_mph")  double windMph, @JsonKey(name: "wind_kph")  double windKph, @JsonKey(name: "wind_degree")  int windDegree, @JsonKey(name: "wind_dir")  String windDir, @JsonKey(name: "pressure_mb")  int pressureMb, @JsonKey(name: "pressure_in")  double pressureIn, @JsonKey(name: "precip_mm")  int precipMm, @JsonKey(name: "precip_in")  int precipIn, @JsonKey(name: "humidity")  int humidity, @JsonKey(name: "cloud")  int cloud, @JsonKey(name: "feelslike_c")  double feelslikeC, @JsonKey(name: "feelslike_f")  int feelslikeF, @JsonKey(name: "windchill_c")  double windchillC, @JsonKey(name: "windchill_f")  double windchillF, @JsonKey(name: "heatindex_c")  double heatindexC, @JsonKey(name: "heatindex_f")  int heatindexF, @JsonKey(name: "dewpoint_c")  double dewpointC, @JsonKey(name: "dewpoint_f")  double dewpointF, @JsonKey(name: "vis_km")  int visKm, @JsonKey(name: "vis_miles")  int visMiles, @JsonKey(name: "uv")  double uv, @JsonKey(name: "gust_mph")  double gustMph, @JsonKey(name: "gust_kph")  double gustKph)  $default,) {final _that = this;
switch (_that) {
case _WeatherCurrentModel():
return $default(_that.lastUpdatedEpoch,_that.lastUpdated,_that.tempC,_that.tempF,_that.isDay,_that.condition,_that.windMph,_that.windKph,_that.windDegree,_that.windDir,_that.pressureMb,_that.pressureIn,_that.precipMm,_that.precipIn,_that.humidity,_that.cloud,_that.feelslikeC,_that.feelslikeF,_that.windchillC,_that.windchillF,_that.heatindexC,_that.heatindexF,_that.dewpointC,_that.dewpointF,_that.visKm,_that.visMiles,_that.uv,_that.gustMph,_that.gustKph);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "last_updated_epoch")  int lastUpdatedEpoch, @JsonKey(name: "last_updated")  String lastUpdated, @JsonKey(name: "temp_c")  double tempC, @JsonKey(name: "temp_f")  double tempF, @JsonKey(name: "is_day")  int isDay, @JsonKey(name: "condition")  WeatherCurrentConditionModel condition, @JsonKey(name: "wind_mph")  double windMph, @JsonKey(name: "wind_kph")  double windKph, @JsonKey(name: "wind_degree")  int windDegree, @JsonKey(name: "wind_dir")  String windDir, @JsonKey(name: "pressure_mb")  int pressureMb, @JsonKey(name: "pressure_in")  double pressureIn, @JsonKey(name: "precip_mm")  int precipMm, @JsonKey(name: "precip_in")  int precipIn, @JsonKey(name: "humidity")  int humidity, @JsonKey(name: "cloud")  int cloud, @JsonKey(name: "feelslike_c")  double feelslikeC, @JsonKey(name: "feelslike_f")  int feelslikeF, @JsonKey(name: "windchill_c")  double windchillC, @JsonKey(name: "windchill_f")  double windchillF, @JsonKey(name: "heatindex_c")  double heatindexC, @JsonKey(name: "heatindex_f")  int heatindexF, @JsonKey(name: "dewpoint_c")  double dewpointC, @JsonKey(name: "dewpoint_f")  double dewpointF, @JsonKey(name: "vis_km")  int visKm, @JsonKey(name: "vis_miles")  int visMiles, @JsonKey(name: "uv")  double uv, @JsonKey(name: "gust_mph")  double gustMph, @JsonKey(name: "gust_kph")  double gustKph)?  $default,) {final _that = this;
switch (_that) {
case _WeatherCurrentModel() when $default != null:
return $default(_that.lastUpdatedEpoch,_that.lastUpdated,_that.tempC,_that.tempF,_that.isDay,_that.condition,_that.windMph,_that.windKph,_that.windDegree,_that.windDir,_that.pressureMb,_that.pressureIn,_that.precipMm,_that.precipIn,_that.humidity,_that.cloud,_that.feelslikeC,_that.feelslikeF,_that.windchillC,_that.windchillF,_that.heatindexC,_that.heatindexF,_that.dewpointC,_that.dewpointF,_that.visKm,_that.visMiles,_that.uv,_that.gustMph,_that.gustKph);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _WeatherCurrentModel implements WeatherCurrentModel {
  const _WeatherCurrentModel({@JsonKey(name: "last_updated_epoch") required this.lastUpdatedEpoch, @JsonKey(name: "last_updated") required this.lastUpdated, @JsonKey(name: "temp_c") required this.tempC, @JsonKey(name: "temp_f") required this.tempF, @JsonKey(name: "is_day") required this.isDay, @JsonKey(name: "condition") required this.condition, @JsonKey(name: "wind_mph") required this.windMph, @JsonKey(name: "wind_kph") required this.windKph, @JsonKey(name: "wind_degree") required this.windDegree, @JsonKey(name: "wind_dir") required this.windDir, @JsonKey(name: "pressure_mb") required this.pressureMb, @JsonKey(name: "pressure_in") required this.pressureIn, @JsonKey(name: "precip_mm") required this.precipMm, @JsonKey(name: "precip_in") required this.precipIn, @JsonKey(name: "humidity") required this.humidity, @JsonKey(name: "cloud") required this.cloud, @JsonKey(name: "feelslike_c") required this.feelslikeC, @JsonKey(name: "feelslike_f") required this.feelslikeF, @JsonKey(name: "windchill_c") required this.windchillC, @JsonKey(name: "windchill_f") required this.windchillF, @JsonKey(name: "heatindex_c") required this.heatindexC, @JsonKey(name: "heatindex_f") required this.heatindexF, @JsonKey(name: "dewpoint_c") required this.dewpointC, @JsonKey(name: "dewpoint_f") required this.dewpointF, @JsonKey(name: "vis_km") required this.visKm, @JsonKey(name: "vis_miles") required this.visMiles, @JsonKey(name: "uv") required this.uv, @JsonKey(name: "gust_mph") required this.gustMph, @JsonKey(name: "gust_kph") required this.gustKph});
  factory _WeatherCurrentModel.fromJson(Map<String, dynamic> json) => _$WeatherCurrentModelFromJson(json);

@override@JsonKey(name: "last_updated_epoch") final  int lastUpdatedEpoch;
@override@JsonKey(name: "last_updated") final  String lastUpdated;
@override@JsonKey(name: "temp_c") final  double tempC;
@override@JsonKey(name: "temp_f") final  double tempF;
@override@JsonKey(name: "is_day") final  int isDay;
@override@JsonKey(name: "condition") final  WeatherCurrentConditionModel condition;
@override@JsonKey(name: "wind_mph") final  double windMph;
@override@JsonKey(name: "wind_kph") final  double windKph;
@override@JsonKey(name: "wind_degree") final  int windDegree;
@override@JsonKey(name: "wind_dir") final  String windDir;
@override@JsonKey(name: "pressure_mb") final  int pressureMb;
@override@JsonKey(name: "pressure_in") final  double pressureIn;
@override@JsonKey(name: "precip_mm") final  int precipMm;
@override@JsonKey(name: "precip_in") final  int precipIn;
@override@JsonKey(name: "humidity") final  int humidity;
@override@JsonKey(name: "cloud") final  int cloud;
@override@JsonKey(name: "feelslike_c") final  double feelslikeC;
@override@JsonKey(name: "feelslike_f") final  int feelslikeF;
@override@JsonKey(name: "windchill_c") final  double windchillC;
@override@JsonKey(name: "windchill_f") final  double windchillF;
@override@JsonKey(name: "heatindex_c") final  double heatindexC;
@override@JsonKey(name: "heatindex_f") final  int heatindexF;
@override@JsonKey(name: "dewpoint_c") final  double dewpointC;
@override@JsonKey(name: "dewpoint_f") final  double dewpointF;
@override@JsonKey(name: "vis_km") final  int visKm;
@override@JsonKey(name: "vis_miles") final  int visMiles;
@override@JsonKey(name: "uv") final  double uv;
@override@JsonKey(name: "gust_mph") final  double gustMph;
@override@JsonKey(name: "gust_kph") final  double gustKph;

/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCurrentModelCopyWith<_WeatherCurrentModel> get copyWith => __$WeatherCurrentModelCopyWithImpl<_WeatherCurrentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherCurrentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherCurrentModel&&(identical(other.lastUpdatedEpoch, lastUpdatedEpoch) || other.lastUpdatedEpoch == lastUpdatedEpoch)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.tempC, tempC) || other.tempC == tempC)&&(identical(other.tempF, tempF) || other.tempF == tempF)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.windMph, windMph) || other.windMph == windMph)&&(identical(other.windKph, windKph) || other.windKph == windKph)&&(identical(other.windDegree, windDegree) || other.windDegree == windDegree)&&(identical(other.windDir, windDir) || other.windDir == windDir)&&(identical(other.pressureMb, pressureMb) || other.pressureMb == pressureMb)&&(identical(other.pressureIn, pressureIn) || other.pressureIn == pressureIn)&&(identical(other.precipMm, precipMm) || other.precipMm == precipMm)&&(identical(other.precipIn, precipIn) || other.precipIn == precipIn)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.cloud, cloud) || other.cloud == cloud)&&(identical(other.feelslikeC, feelslikeC) || other.feelslikeC == feelslikeC)&&(identical(other.feelslikeF, feelslikeF) || other.feelslikeF == feelslikeF)&&(identical(other.windchillC, windchillC) || other.windchillC == windchillC)&&(identical(other.windchillF, windchillF) || other.windchillF == windchillF)&&(identical(other.heatindexC, heatindexC) || other.heatindexC == heatindexC)&&(identical(other.heatindexF, heatindexF) || other.heatindexF == heatindexF)&&(identical(other.dewpointC, dewpointC) || other.dewpointC == dewpointC)&&(identical(other.dewpointF, dewpointF) || other.dewpointF == dewpointF)&&(identical(other.visKm, visKm) || other.visKm == visKm)&&(identical(other.visMiles, visMiles) || other.visMiles == visMiles)&&(identical(other.uv, uv) || other.uv == uv)&&(identical(other.gustMph, gustMph) || other.gustMph == gustMph)&&(identical(other.gustKph, gustKph) || other.gustKph == gustKph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,lastUpdatedEpoch,lastUpdated,tempC,tempF,isDay,condition,windMph,windKph,windDegree,windDir,pressureMb,pressureIn,precipMm,precipIn,humidity,cloud,feelslikeC,feelslikeF,windchillC,windchillF,heatindexC,heatindexF,dewpointC,dewpointF,visKm,visMiles,uv,gustMph,gustKph]);

@override
String toString() {
  return 'WeatherCurrentModel(lastUpdatedEpoch: $lastUpdatedEpoch, lastUpdated: $lastUpdated, tempC: $tempC, tempF: $tempF, isDay: $isDay, condition: $condition, windMph: $windMph, windKph: $windKph, windDegree: $windDegree, windDir: $windDir, pressureMb: $pressureMb, pressureIn: $pressureIn, precipMm: $precipMm, precipIn: $precipIn, humidity: $humidity, cloud: $cloud, feelslikeC: $feelslikeC, feelslikeF: $feelslikeF, windchillC: $windchillC, windchillF: $windchillF, heatindexC: $heatindexC, heatindexF: $heatindexF, dewpointC: $dewpointC, dewpointF: $dewpointF, visKm: $visKm, visMiles: $visMiles, uv: $uv, gustMph: $gustMph, gustKph: $gustKph)';
}


}

/// @nodoc
abstract mixin class _$WeatherCurrentModelCopyWith<$Res> implements $WeatherCurrentModelCopyWith<$Res> {
  factory _$WeatherCurrentModelCopyWith(_WeatherCurrentModel value, $Res Function(_WeatherCurrentModel) _then) = __$WeatherCurrentModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "last_updated_epoch") int lastUpdatedEpoch,@JsonKey(name: "last_updated") String lastUpdated,@JsonKey(name: "temp_c") double tempC,@JsonKey(name: "temp_f") double tempF,@JsonKey(name: "is_day") int isDay,@JsonKey(name: "condition") WeatherCurrentConditionModel condition,@JsonKey(name: "wind_mph") double windMph,@JsonKey(name: "wind_kph") double windKph,@JsonKey(name: "wind_degree") int windDegree,@JsonKey(name: "wind_dir") String windDir,@JsonKey(name: "pressure_mb") int pressureMb,@JsonKey(name: "pressure_in") double pressureIn,@JsonKey(name: "precip_mm") int precipMm,@JsonKey(name: "precip_in") int precipIn,@JsonKey(name: "humidity") int humidity,@JsonKey(name: "cloud") int cloud,@JsonKey(name: "feelslike_c") double feelslikeC,@JsonKey(name: "feelslike_f") int feelslikeF,@JsonKey(name: "windchill_c") double windchillC,@JsonKey(name: "windchill_f") double windchillF,@JsonKey(name: "heatindex_c") double heatindexC,@JsonKey(name: "heatindex_f") int heatindexF,@JsonKey(name: "dewpoint_c") double dewpointC,@JsonKey(name: "dewpoint_f") double dewpointF,@JsonKey(name: "vis_km") int visKm,@JsonKey(name: "vis_miles") int visMiles,@JsonKey(name: "uv") double uv,@JsonKey(name: "gust_mph") double gustMph,@JsonKey(name: "gust_kph") double gustKph
});


@override $WeatherCurrentConditionModelCopyWith<$Res> get condition;

}
/// @nodoc
class __$WeatherCurrentModelCopyWithImpl<$Res>
    implements _$WeatherCurrentModelCopyWith<$Res> {
  __$WeatherCurrentModelCopyWithImpl(this._self, this._then);

  final _WeatherCurrentModel _self;
  final $Res Function(_WeatherCurrentModel) _then;

/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdatedEpoch = null,Object? lastUpdated = null,Object? tempC = null,Object? tempF = null,Object? isDay = null,Object? condition = null,Object? windMph = null,Object? windKph = null,Object? windDegree = null,Object? windDir = null,Object? pressureMb = null,Object? pressureIn = null,Object? precipMm = null,Object? precipIn = null,Object? humidity = null,Object? cloud = null,Object? feelslikeC = null,Object? feelslikeF = null,Object? windchillC = null,Object? windchillF = null,Object? heatindexC = null,Object? heatindexF = null,Object? dewpointC = null,Object? dewpointF = null,Object? visKm = null,Object? visMiles = null,Object? uv = null,Object? gustMph = null,Object? gustKph = null,}) {
  return _then(_WeatherCurrentModel(
lastUpdatedEpoch: null == lastUpdatedEpoch ? _self.lastUpdatedEpoch : lastUpdatedEpoch // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,tempC: null == tempC ? _self.tempC : tempC // ignore: cast_nullable_to_non_nullable
as double,tempF: null == tempF ? _self.tempF : tempF // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCurrentConditionModel,windMph: null == windMph ? _self.windMph : windMph // ignore: cast_nullable_to_non_nullable
as double,windKph: null == windKph ? _self.windKph : windKph // ignore: cast_nullable_to_non_nullable
as double,windDegree: null == windDegree ? _self.windDegree : windDegree // ignore: cast_nullable_to_non_nullable
as int,windDir: null == windDir ? _self.windDir : windDir // ignore: cast_nullable_to_non_nullable
as String,pressureMb: null == pressureMb ? _self.pressureMb : pressureMb // ignore: cast_nullable_to_non_nullable
as int,pressureIn: null == pressureIn ? _self.pressureIn : pressureIn // ignore: cast_nullable_to_non_nullable
as double,precipMm: null == precipMm ? _self.precipMm : precipMm // ignore: cast_nullable_to_non_nullable
as int,precipIn: null == precipIn ? _self.precipIn : precipIn // ignore: cast_nullable_to_non_nullable
as int,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,cloud: null == cloud ? _self.cloud : cloud // ignore: cast_nullable_to_non_nullable
as int,feelslikeC: null == feelslikeC ? _self.feelslikeC : feelslikeC // ignore: cast_nullable_to_non_nullable
as double,feelslikeF: null == feelslikeF ? _self.feelslikeF : feelslikeF // ignore: cast_nullable_to_non_nullable
as int,windchillC: null == windchillC ? _self.windchillC : windchillC // ignore: cast_nullable_to_non_nullable
as double,windchillF: null == windchillF ? _self.windchillF : windchillF // ignore: cast_nullable_to_non_nullable
as double,heatindexC: null == heatindexC ? _self.heatindexC : heatindexC // ignore: cast_nullable_to_non_nullable
as double,heatindexF: null == heatindexF ? _self.heatindexF : heatindexF // ignore: cast_nullable_to_non_nullable
as int,dewpointC: null == dewpointC ? _self.dewpointC : dewpointC // ignore: cast_nullable_to_non_nullable
as double,dewpointF: null == dewpointF ? _self.dewpointF : dewpointF // ignore: cast_nullable_to_non_nullable
as double,visKm: null == visKm ? _self.visKm : visKm // ignore: cast_nullable_to_non_nullable
as int,visMiles: null == visMiles ? _self.visMiles : visMiles // ignore: cast_nullable_to_non_nullable
as int,uv: null == uv ? _self.uv : uv // ignore: cast_nullable_to_non_nullable
as double,gustMph: null == gustMph ? _self.gustMph : gustMph // ignore: cast_nullable_to_non_nullable
as double,gustKph: null == gustKph ? _self.gustKph : gustKph // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of WeatherCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherCurrentConditionModelCopyWith<$Res> get condition {
  
  return $WeatherCurrentConditionModelCopyWith<$Res>(_self.condition, (value) {
    return _then(_self.copyWith(condition: value));
  });
}
}

// dart format on
