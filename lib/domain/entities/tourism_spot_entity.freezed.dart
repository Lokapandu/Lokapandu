// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_spot_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TourismSpotEntity {

 int get id; String get name; String get description; String get category; String get city; String get province; String get address; double get latitude; double get longitude; String get openTime; String get closeTime; String get mapsLink; List<TourismImageEntity> get images; String get facilities; DateTime get createdAt;
/// Create a copy of TourismSpotEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismSpotEntityCopyWith<TourismSpotEntity> get copyWith => _$TourismSpotEntityCopyWithImpl<TourismSpotEntity>(this as TourismSpotEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismSpotEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.mapsLink, mapsLink) || other.mapsLink == mapsLink)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.facilities, facilities) || other.facilities == facilities)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,city,province,address,latitude,longitude,openTime,closeTime,mapsLink,const DeepCollectionEquality().hash(images),facilities,createdAt);

@override
String toString() {
  return 'TourismSpotEntity(id: $id, name: $name, description: $description, category: $category, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, mapsLink: $mapsLink, images: $images, facilities: $facilities, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TourismSpotEntityCopyWith<$Res>  {
  factory $TourismSpotEntityCopyWith(TourismSpotEntity value, $Res Function(TourismSpotEntity) _then) = _$TourismSpotEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String description, String category, String city, String province, String address, double latitude, double longitude, String openTime, String closeTime, String mapsLink, List<TourismImageEntity> images, String facilities, DateTime createdAt
});




}
/// @nodoc
class _$TourismSpotEntityCopyWithImpl<$Res>
    implements $TourismSpotEntityCopyWith<$Res> {
  _$TourismSpotEntityCopyWithImpl(this._self, this._then);

  final TourismSpotEntity _self;
  final $Res Function(TourismSpotEntity) _then;

/// Create a copy of TourismSpotEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? mapsLink = null,Object? images = null,Object? facilities = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,mapsLink: null == mapsLink ? _self.mapsLink : mapsLink // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<TourismImageEntity>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TourismSpotEntity].
extension TourismSpotEntityPatterns on TourismSpotEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismSpotEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismSpotEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismSpotEntity value)  $default,){
final _that = this;
switch (_that) {
case _TourismSpotEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismSpotEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TourismSpotEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String category,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String mapsLink,  List<TourismImageEntity> images,  String facilities,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismSpotEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.images,_that.facilities,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String category,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String mapsLink,  List<TourismImageEntity> images,  String facilities,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TourismSpotEntity():
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.images,_that.facilities,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String description,  String category,  String city,  String province,  String address,  double latitude,  double longitude,  String openTime,  String closeTime,  String mapsLink,  List<TourismImageEntity> images,  String facilities,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TourismSpotEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.images,_that.facilities,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _TourismSpotEntity implements TourismSpotEntity {
  const _TourismSpotEntity({required this.id, required this.name, required this.description, required this.category, required this.city, required this.province, required this.address, required this.latitude, required this.longitude, required this.openTime, required this.closeTime, required this.mapsLink, required final  List<TourismImageEntity> images, required this.facilities, required this.createdAt}): _images = images;
  

@override final  int id;
@override final  String name;
@override final  String description;
@override final  String category;
@override final  String city;
@override final  String province;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override final  String openTime;
@override final  String closeTime;
@override final  String mapsLink;
 final  List<TourismImageEntity> _images;
@override List<TourismImageEntity> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  String facilities;
@override final  DateTime createdAt;

/// Create a copy of TourismSpotEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismSpotEntityCopyWith<_TourismSpotEntity> get copyWith => __$TourismSpotEntityCopyWithImpl<_TourismSpotEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismSpotEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.mapsLink, mapsLink) || other.mapsLink == mapsLink)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.facilities, facilities) || other.facilities == facilities)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,city,province,address,latitude,longitude,openTime,closeTime,mapsLink,const DeepCollectionEquality().hash(_images),facilities,createdAt);

@override
String toString() {
  return 'TourismSpotEntity(id: $id, name: $name, description: $description, category: $category, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, mapsLink: $mapsLink, images: $images, facilities: $facilities, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TourismSpotEntityCopyWith<$Res> implements $TourismSpotEntityCopyWith<$Res> {
  factory _$TourismSpotEntityCopyWith(_TourismSpotEntity value, $Res Function(_TourismSpotEntity) _then) = __$TourismSpotEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String description, String category, String city, String province, String address, double latitude, double longitude, String openTime, String closeTime, String mapsLink, List<TourismImageEntity> images, String facilities, DateTime createdAt
});




}
/// @nodoc
class __$TourismSpotEntityCopyWithImpl<$Res>
    implements _$TourismSpotEntityCopyWith<$Res> {
  __$TourismSpotEntityCopyWithImpl(this._self, this._then);

  final _TourismSpotEntity _self;
  final $Res Function(_TourismSpotEntity) _then;

/// Create a copy of TourismSpotEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? mapsLink = null,Object? images = null,Object? facilities = null,Object? createdAt = null,}) {
  return _then(_TourismSpotEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,mapsLink: null == mapsLink ? _self.mapsLink : mapsLink // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<TourismImageEntity>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
