// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Weather {

 String get city; String get region; String get country; double get lat; double get lon; String get tzId; DateTime get lastUpdated; double get fahrenheitTemperature; double get celciusTemperature; String get text; String get icon;
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCopyWith<Weather> get copyWith => _$WeatherCopyWithImpl<Weather>(this as Weather, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Weather&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.tzId, tzId) || other.tzId == tzId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.fahrenheitTemperature, fahrenheitTemperature) || other.fahrenheitTemperature == fahrenheitTemperature)&&(identical(other.celciusTemperature, celciusTemperature) || other.celciusTemperature == celciusTemperature)&&(identical(other.text, text) || other.text == text)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,city,region,country,lat,lon,tzId,lastUpdated,fahrenheitTemperature,celciusTemperature,text,icon);

@override
String toString() {
  return 'Weather(city: $city, region: $region, country: $country, lat: $lat, lon: $lon, tzId: $tzId, lastUpdated: $lastUpdated, fahrenheitTemperature: $fahrenheitTemperature, celciusTemperature: $celciusTemperature, text: $text, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $WeatherCopyWith<$Res>  {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) _then) = _$WeatherCopyWithImpl;
@useResult
$Res call({
 String city, String region, String country, double lat, double lon, String tzId, DateTime lastUpdated, double fahrenheitTemperature, double celciusTemperature, String text, String icon
});




}
/// @nodoc
class _$WeatherCopyWithImpl<$Res>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._self, this._then);

  final Weather _self;
  final $Res Function(Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? region = null,Object? country = null,Object? lat = null,Object? lon = null,Object? tzId = null,Object? lastUpdated = null,Object? fahrenheitTemperature = null,Object? celciusTemperature = null,Object? text = null,Object? icon = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,tzId: null == tzId ? _self.tzId : tzId // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,fahrenheitTemperature: null == fahrenheitTemperature ? _self.fahrenheitTemperature : fahrenheitTemperature // ignore: cast_nullable_to_non_nullable
as double,celciusTemperature: null == celciusTemperature ? _self.celciusTemperature : celciusTemperature // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Weather].
extension WeatherPatterns on Weather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Weather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Weather value)  $default,){
final _that = this;
switch (_that) {
case _Weather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Weather value)?  $default,){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  String region,  String country,  double lat,  double lon,  String tzId,  DateTime lastUpdated,  double fahrenheitTemperature,  double celciusTemperature,  String text,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.city,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.lastUpdated,_that.fahrenheitTemperature,_that.celciusTemperature,_that.text,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  String region,  String country,  double lat,  double lon,  String tzId,  DateTime lastUpdated,  double fahrenheitTemperature,  double celciusTemperature,  String text,  String icon)  $default,) {final _that = this;
switch (_that) {
case _Weather():
return $default(_that.city,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.lastUpdated,_that.fahrenheitTemperature,_that.celciusTemperature,_that.text,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  String region,  String country,  double lat,  double lon,  String tzId,  DateTime lastUpdated,  double fahrenheitTemperature,  double celciusTemperature,  String text,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.city,_that.region,_that.country,_that.lat,_that.lon,_that.tzId,_that.lastUpdated,_that.fahrenheitTemperature,_that.celciusTemperature,_that.text,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _Weather implements Weather {
  const _Weather({required this.city, required this.region, required this.country, required this.lat, required this.lon, required this.tzId, required this.lastUpdated, required this.fahrenheitTemperature, required this.celciusTemperature, required this.text, required this.icon});
  

@override final  String city;
@override final  String region;
@override final  String country;
@override final  double lat;
@override final  double lon;
@override final  String tzId;
@override final  DateTime lastUpdated;
@override final  double fahrenheitTemperature;
@override final  double celciusTemperature;
@override final  String text;
@override final  String icon;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCopyWith<_Weather> get copyWith => __$WeatherCopyWithImpl<_Weather>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Weather&&(identical(other.city, city) || other.city == city)&&(identical(other.region, region) || other.region == region)&&(identical(other.country, country) || other.country == country)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.tzId, tzId) || other.tzId == tzId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.fahrenheitTemperature, fahrenheitTemperature) || other.fahrenheitTemperature == fahrenheitTemperature)&&(identical(other.celciusTemperature, celciusTemperature) || other.celciusTemperature == celciusTemperature)&&(identical(other.text, text) || other.text == text)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,city,region,country,lat,lon,tzId,lastUpdated,fahrenheitTemperature,celciusTemperature,text,icon);

@override
String toString() {
  return 'Weather(city: $city, region: $region, country: $country, lat: $lat, lon: $lon, tzId: $tzId, lastUpdated: $lastUpdated, fahrenheitTemperature: $fahrenheitTemperature, celciusTemperature: $celciusTemperature, text: $text, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$WeatherCopyWith(_Weather value, $Res Function(_Weather) _then) = __$WeatherCopyWithImpl;
@override @useResult
$Res call({
 String city, String region, String country, double lat, double lon, String tzId, DateTime lastUpdated, double fahrenheitTemperature, double celciusTemperature, String text, String icon
});




}
/// @nodoc
class __$WeatherCopyWithImpl<$Res>
    implements _$WeatherCopyWith<$Res> {
  __$WeatherCopyWithImpl(this._self, this._then);

  final _Weather _self;
  final $Res Function(_Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? region = null,Object? country = null,Object? lat = null,Object? lon = null,Object? tzId = null,Object? lastUpdated = null,Object? fahrenheitTemperature = null,Object? celciusTemperature = null,Object? text = null,Object? icon = null,}) {
  return _then(_Weather(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,tzId: null == tzId ? _self.tzId : tzId // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,fahrenheitTemperature: null == fahrenheitTemperature ? _self.fahrenheitTemperature : fahrenheitTemperature // ignore: cast_nullable_to_non_nullable
as double,celciusTemperature: null == celciusTemperature ? _self.celciusTemperature : celciusTemperature // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
