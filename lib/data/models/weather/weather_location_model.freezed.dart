// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherLocationModel {

@JsonKey(name: "name") String get name;@JsonKey(name: "region") String get region;@JsonKey(name: "country") String get country;@JsonKey(name: "lat") double get lat;@JsonKey(name: "lon") double get lon;@JsonKey(name: "tz_id") String get tzId;@JsonKey(name: "localtime_epoch") int get localtimeEpoch;@JsonKey(name: "localtime") String get localtime;
/// Create a copy of WeatherLocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherLocationModelCopyWith<WeatherLocationModel> get copyWith => _$WeatherLocationModelCopyWithImpl<WeatherLocationModel>(this as WeatherLocationModel, _$identity);

  /// Serializes this WeatherLocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherLocationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.tzId, tzId) || other.tzId == tzId)&&(identical(other.localtimeEpoch, localtimeEpoch) || other.localtimeEpoch == localtimeEpoch)&&(identical(other.localtime, localtime) || other.localtime == localtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,region,country,lat,lon,tzId,localtimeEpoch,localtime);

@override
String toString() {
  return 'WeatherLocationModel(name: $name, region: $region, country: $country, lat: $lat, lon: $lon, tzId: $tzId, localtimeEpoch: $localtimeEpoch, localtime: $localtime)';
}


}

/// @nodoc
abstract mixin class $WeatherLocationModelCopyWith<$Res>  {
  factory $WeatherLocationModelCopyWith(WeatherLocationModel value, $Res Function(WeatherLocationModel) _then) = _$WeatherLocationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "name") String name,@JsonKey(name: "region") String region,@JsonKey(name: "country") String country,@JsonKey(name: "lat") double lat,@JsonKey(name: "lon") double lon,@JsonKey(name: "tz_id") String tzId,@JsonKey(name: "localtime_epoch") int localtimeEpoch,@JsonKey(name: "localtime") String localtime
});




}
/// @nodoc
class _$WeatherLocationModelCopyWithImpl<$Res>
    implements $WeatherLocationModelCopyWith<$Res> {
  _$WeatherLocationModelCopyWithImpl(this._self, this._then);

  final WeatherLocationModel _self;
  final $Res Function(WeatherLocationModel) _then;

/// Create a copy of WeatherLocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? region = null,Object? country = null,Object? lat = null,Object? lon = null,Object? tzId = null,Object? localtimeEpoch = null,Object? localtime = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,tzId: null == tzId ? _self.tzId : tzId // ignore: cast_nullable_to_non_nullable
as String,localtimeEpoch: null == localtimeEpoch ? _self.localtimeEpoch : localtimeEpoch // ignore: cast_nullable_to_non_nullable
as int,localtime: null == localtime ? _self.localtime : localtime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherLocationModel].
extension WeatherLocationModelPatterns on WeatherLocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherLocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherLocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherLocationModel value)  $default,){
final _that = this;
switch (_that) {
case _WeatherLocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherLocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherLocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String name, @JsonKey(name: "region")  String region, @JsonKey(name: "country")  String country, @JsonKey(name: "lat")  double lat, @JsonKey(name: "lon")  double lon, @JsonKey(name: "tz_id")  String tzId, @JsonKey(name: "localtime_epoch")  int localtimeEpoch, @JsonKey(name: "localtime")  String localtime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherLocationModel() when $default != null:
return $default(_that.name,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.localtimeEpoch,_that.localtime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String name, @JsonKey(name: "region")  String region, @JsonKey(name: "country")  String country, @JsonKey(name: "lat")  double lat, @JsonKey(name: "lon")  double lon, @JsonKey(name: "tz_id")  String tzId, @JsonKey(name: "localtime_epoch")  int localtimeEpoch, @JsonKey(name: "localtime")  String localtime)  $default,) {final _that = this;
switch (_that) {
case _WeatherLocationModel():
return $default(_that.name,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.localtimeEpoch,_that.localtime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "name")  String name, @JsonKey(name: "region")  String region, @JsonKey(name: "country")  String country, @JsonKey(name: "lat")  double lat, @JsonKey(name: "lon")  double lon, @JsonKey(name: "tz_id")  String tzId, @JsonKey(name: "localtime_epoch")  int localtimeEpoch, @JsonKey(name: "localtime")  String localtime)?  $default,) {final _that = this;
switch (_that) {
case _WeatherLocationModel() when $default != null:
return $default(_that.name,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.localtimeEpoch,_that.localtime);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _WeatherLocationModel implements WeatherLocationModel {
   _WeatherLocationModel({@JsonKey(name: "name") required this.name, @JsonKey(name: "region") required this.region, @JsonKey(name: "country") required this.country, @JsonKey(name: "lat") required this.lat, @JsonKey(name: "lon") required this.lon, @JsonKey(name: "tz_id") required this.tzId, @JsonKey(name: "localtime_epoch") required this.localtimeEpoch, @JsonKey(name: "localtime") required this.localtime});
  factory _WeatherLocationModel.fromJson(Map<String, dynamic> json) => _$WeatherLocationModelFromJson(json);

@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "region") final  String region;
@override@JsonKey(name: "country") final  String country;
@override@JsonKey(name: "lat") final  double lat;
@override@JsonKey(name: "lon") final  double lon;
@override@JsonKey(name: "tz_id") final  String tzId;
@override@JsonKey(name: "localtime_epoch") final  int localtimeEpoch;
@override@JsonKey(name: "localtime") final  String localtime;

/// Create a copy of WeatherLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherLocationModelCopyWith<_WeatherLocationModel> get copyWith => __$WeatherLocationModelCopyWithImpl<_WeatherLocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherLocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherLocationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.tzId, tzId) || other.tzId == tzId)&&(identical(other.localtimeEpoch, localtimeEpoch) || other.localtimeEpoch == localtimeEpoch)&&(identical(other.localtime, localtime) || other.localtime == localtime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,region,country,lat,lon,tzId,localtimeEpoch,localtime);

@override
String toString() {
  return 'WeatherLocationModel(name: $name, region: $region, country: $country, lat: $lat, lon: $lon, tzId: $tzId, localtimeEpoch: $localtimeEpoch, localtime: $localtime)';
}


}

/// @nodoc
abstract mixin class _$WeatherLocationModelCopyWith<$Res> implements $WeatherLocationModelCopyWith<$Res> {
  factory _$WeatherLocationModelCopyWith(_WeatherLocationModel value, $Res Function(_WeatherLocationModel) _then) = __$WeatherLocationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "name") String name,@JsonKey(name: "region") String region,@JsonKey(name: "country") String country,@JsonKey(name: "lat") double lat,@JsonKey(name: "lon") double lon,@JsonKey(name: "tz_id") String tzId,@JsonKey(name: "localtime_epoch") int localtimeEpoch,@JsonKey(name: "localtime") String localtime
});




}
/// @nodoc
class __$WeatherLocationModelCopyWithImpl<$Res>
    implements _$WeatherLocationModelCopyWith<$Res> {
  __$WeatherLocationModelCopyWithImpl(this._self, this._then);

  final _WeatherLocationModel _self;
  final $Res Function(_WeatherLocationModel) _then;

/// Create a copy of WeatherLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? region = null,Object? country = null,Object? lat = null,Object? lon = null,Object? tzId = null,Object? localtimeEpoch = null,Object? localtime = null,}) {
  return _then(_WeatherLocationModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,tzId: null == tzId ? _self.tzId : tzId // ignore: cast_nullable_to_non_nullable
as String,localtimeEpoch: null == localtimeEpoch ? _self.localtimeEpoch : localtimeEpoch // ignore: cast_nullable_to_non_nullable
as int,localtime: null == localtime ? _self.localtime : localtime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
