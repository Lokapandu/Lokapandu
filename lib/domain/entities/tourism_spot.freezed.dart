// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TourismSpot {

 String get id; String get name; String get description; String get city; String get province; String get address; double get latitude; double get longitude; String get openTime; String get closeTime; String get googleMapsLink; List<TourismImage> get images; List<Facilities> get facilities;
/// Create a copy of TourismSpot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismSpotCopyWith<TourismSpot> get copyWith => _$TourismSpotCopyWithImpl<TourismSpot>(this as TourismSpot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.googleMapsLink, googleMapsLink) || other.googleMapsLink == googleMapsLink)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.facilities, facilities));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,city,province,address,latitude,longitude,openTime,closeTime,googleMapsLink,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(facilities));

@override
String toString() {
  return 'TourismSpot(id: $id, name: $name, description: $description, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, googleMapsLink: $googleMapsLink, images: $images, facilities: $facilities)';
}


}

/// @nodoc
abstract mixin class $TourismSpotCopyWith<$Res>  {
  factory $TourismSpotCopyWith(TourismSpot value, $Res Function(TourismSpot) _then) = _$TourismSpotCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String city, String province, String address, double latitude, double longitude, String openTime, String closeTime, String googleMapsLink, List<TourismImage> images, List<Facilities> facilities
});




}
/// @nodoc
class _$TourismSpotCopyWithImpl<$Res>
    implements $TourismSpotCopyWith<$Res> {
  _$TourismSpotCopyWithImpl(this._self, this._then);

  final TourismSpot _self;
  final $Res Function(TourismSpot) _then;

/// Create a copy of TourismSpot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? googleMapsLink = null,Object? images = null,Object? facilities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,googleMapsLink: null == googleMapsLink ? _self.googleMapsLink : googleMapsLink // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<TourismImage>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<Facilities>,
  ));
}

}


/// Adds pattern-matching-related methods to [TourismSpot].
extension TourismSpotPatterns on TourismSpot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismSpot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismSpot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismSpot value)  $default,){
final _that = this;
switch (_that) {
case _TourismSpot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismSpot value)?  $default,){
final _that = this;
switch (_that) {
case _TourismSpot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String googleMapsLink,  List<TourismImage> images,  List<Facilities> facilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismSpot() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.googleMapsLink,_that.images,_that.facilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String googleMapsLink,  List<TourismImage> images,  List<Facilities> facilities)  $default,) {final _that = this;
switch (_that) {
case _TourismSpot():
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.googleMapsLink,_that.images,_that.facilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String googleMapsLink,  List<TourismImage> images,  List<Facilities> facilities)?  $default,) {final _that = this;
switch (_that) {
case _TourismSpot() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.googleMapsLink,_that.images,_that.facilities);case _:
  return null;

}
}

}

/// @nodoc


class _TourismSpot implements TourismSpot {
  const _TourismSpot({required this.id, required this.name, required this.description, required this.city, required this.province, required this.address, required this.latitude, required this.longitude, required this.openTime, required this.closeTime, required this.googleMapsLink, required final  List<TourismImage> images, required final  List<Facilities> facilities}): _images = images,_facilities = facilities;
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String city;
@override final  String province;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override final  String openTime;
@override final  String closeTime;
@override final  String googleMapsLink;
 final  List<TourismImage> _images;
@override List<TourismImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<Facilities> _facilities;
@override List<Facilities> get facilities {
  if (_facilities is EqualUnmodifiableListView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facilities);
}


/// Create a copy of TourismSpot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismSpotCopyWith<_TourismSpot> get copyWith => __$TourismSpotCopyWithImpl<_TourismSpot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.googleMapsLink, googleMapsLink) || other.googleMapsLink == googleMapsLink)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._facilities, _facilities));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,city,province,address,latitude,longitude,openTime,closeTime,googleMapsLink,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_facilities));

@override
String toString() {
  return 'TourismSpot(id: $id, name: $name, description: $description, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, googleMapsLink: $googleMapsLink, images: $images, facilities: $facilities)';
}


}

/// @nodoc
abstract mixin class _$TourismSpotCopyWith<$Res> implements $TourismSpotCopyWith<$Res> {
  factory _$TourismSpotCopyWith(_TourismSpot value, $Res Function(_TourismSpot) _then) = __$TourismSpotCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String city, String province, String address, double latitude, double longitude, String openTime, String closeTime, String googleMapsLink, List<TourismImage> images, List<Facilities> facilities
});




}
/// @nodoc
class __$TourismSpotCopyWithImpl<$Res>
    implements _$TourismSpotCopyWith<$Res> {
  __$TourismSpotCopyWithImpl(this._self, this._then);

  final _TourismSpot _self;
  final $Res Function(_TourismSpot) _then;

/// Create a copy of TourismSpot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? googleMapsLink = null,Object? images = null,Object? facilities = null,}) {
  return _then(_TourismSpot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,googleMapsLink: null == googleMapsLink ? _self.googleMapsLink : googleMapsLink // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<TourismImage>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as List<Facilities>,
  ));
}


}

// dart format on
