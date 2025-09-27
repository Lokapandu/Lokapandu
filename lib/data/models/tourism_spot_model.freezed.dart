// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_spot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TourismSpotModel {

 int get id; String get name;@JsonKey(name: 'description') String? get description; String get city; String get province; String get address; double get latitude; double get longitude;@JsonKey(name: 'open_time') String get openTime;@JsonKey(name: 'close_time') String get closeTime;@JsonKey(name: 'maps_link') String? get mapsLink; String? get facilities;@JsonKey(name: 'created_at') DateTime get createdAt; String? get category; String? get embedding;
/// Create a copy of TourismSpotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismSpotModelCopyWith<TourismSpotModel> get copyWith => _$TourismSpotModelCopyWithImpl<TourismSpotModel>(this as TourismSpotModel, _$identity);

  /// Serializes this TourismSpotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismSpotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.mapsLink, mapsLink) || other.mapsLink == mapsLink)&&(identical(other.facilities, facilities) || other.facilities == facilities)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.embedding, embedding) || other.embedding == embedding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,city,province,address,latitude,longitude,openTime,closeTime,mapsLink,facilities,createdAt,category,embedding);

@override
String toString() {
  return 'TourismSpotModel(id: $id, name: $name, description: $description, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, mapsLink: $mapsLink, facilities: $facilities, createdAt: $createdAt, category: $category, embedding: $embedding)';
}


}

/// @nodoc
abstract mixin class $TourismSpotModelCopyWith<$Res>  {
  factory $TourismSpotModelCopyWith(TourismSpotModel value, $Res Function(TourismSpotModel) _then) = _$TourismSpotModelCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'description') String? description, String city, String province, String address, double latitude, double longitude,@JsonKey(name: 'open_time') String openTime,@JsonKey(name: 'close_time') String closeTime,@JsonKey(name: 'maps_link') String? mapsLink, String? facilities,@JsonKey(name: 'created_at') DateTime createdAt, String? category, String? embedding
});




}
/// @nodoc
class _$TourismSpotModelCopyWithImpl<$Res>
    implements $TourismSpotModelCopyWith<$Res> {
  _$TourismSpotModelCopyWithImpl(this._self, this._then);

  final TourismSpotModel _self;
  final $Res Function(TourismSpotModel) _then;

/// Create a copy of TourismSpotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? mapsLink = freezed,Object? facilities = freezed,Object? createdAt = null,Object? category = freezed,Object? embedding = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,mapsLink: freezed == mapsLink ? _self.mapsLink : mapsLink // ignore: cast_nullable_to_non_nullable
as String?,facilities: freezed == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TourismSpotModel].
extension TourismSpotModelPatterns on TourismSpotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismSpotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismSpotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismSpotModel value)  $default,){
final _that = this;
switch (_that) {
case _TourismSpotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismSpotModel value)?  $default,){
final _that = this;
switch (_that) {
case _TourismSpotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'description')  String? description,  String city,  String province,  String address,  double latitude,  double longitude, @JsonKey(name: 'open_time')  String openTime, @JsonKey(name: 'close_time')  String closeTime, @JsonKey(name: 'maps_link')  String? mapsLink,  String? facilities, @JsonKey(name: 'created_at')  DateTime createdAt,  String? category,  String? embedding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismSpotModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.facilities,_that.createdAt,_that.category,_that.embedding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'description')  String? description,  String city,  String province,  String address,  double latitude,  double longitude, @JsonKey(name: 'open_time')  String openTime, @JsonKey(name: 'close_time')  String closeTime, @JsonKey(name: 'maps_link')  String? mapsLink,  String? facilities, @JsonKey(name: 'created_at')  DateTime createdAt,  String? category,  String? embedding)  $default,) {final _that = this;
switch (_that) {
case _TourismSpotModel():
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.facilities,_that.createdAt,_that.category,_that.embedding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'description')  String? description,  String city,  String province,  String address,  double latitude,  double longitude, @JsonKey(name: 'open_time')  String openTime, @JsonKey(name: 'close_time')  String closeTime, @JsonKey(name: 'maps_link')  String? mapsLink,  String? facilities, @JsonKey(name: 'created_at')  DateTime createdAt,  String? category,  String? embedding)?  $default,) {final _that = this;
switch (_that) {
case _TourismSpotModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.province,_that.address,_that.latitude,_that.longitude,_that.openTime,_that.closeTime,_that.mapsLink,_that.facilities,_that.createdAt,_that.category,_that.embedding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TourismSpotModel implements TourismSpotModel {
  const _TourismSpotModel({required this.id, required this.name, @JsonKey(name: 'description') this.description, required this.city, required this.province, required this.address, required this.latitude, required this.longitude, @JsonKey(name: 'open_time') required this.openTime, @JsonKey(name: 'close_time') required this.closeTime, @JsonKey(name: 'maps_link') this.mapsLink, this.facilities, @JsonKey(name: 'created_at') required this.createdAt, this.category, this.embedding});
  factory _TourismSpotModel.fromJson(Map<String, dynamic> json) => _$TourismSpotModelFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'description') final  String? description;
@override final  String city;
@override final  String province;
@override final  String address;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'open_time') final  String openTime;
@override@JsonKey(name: 'close_time') final  String closeTime;
@override@JsonKey(name: 'maps_link') final  String? mapsLink;
@override final  String? facilities;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  String? category;
@override final  String? embedding;

/// Create a copy of TourismSpotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismSpotModelCopyWith<_TourismSpotModel> get copyWith => __$TourismSpotModelCopyWithImpl<_TourismSpotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TourismSpotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismSpotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime)&&(identical(other.mapsLink, mapsLink) || other.mapsLink == mapsLink)&&(identical(other.facilities, facilities) || other.facilities == facilities)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.embedding, embedding) || other.embedding == embedding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,city,province,address,latitude,longitude,openTime,closeTime,mapsLink,facilities,createdAt,category,embedding);

@override
String toString() {
  return 'TourismSpotModel(id: $id, name: $name, description: $description, city: $city, province: $province, address: $address, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime, mapsLink: $mapsLink, facilities: $facilities, createdAt: $createdAt, category: $category, embedding: $embedding)';
}


}

/// @nodoc
abstract mixin class _$TourismSpotModelCopyWith<$Res> implements $TourismSpotModelCopyWith<$Res> {
  factory _$TourismSpotModelCopyWith(_TourismSpotModel value, $Res Function(_TourismSpotModel) _then) = __$TourismSpotModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'description') String? description, String city, String province, String address, double latitude, double longitude,@JsonKey(name: 'open_time') String openTime,@JsonKey(name: 'close_time') String closeTime,@JsonKey(name: 'maps_link') String? mapsLink, String? facilities,@JsonKey(name: 'created_at') DateTime createdAt, String? category, String? embedding
});




}
/// @nodoc
class __$TourismSpotModelCopyWithImpl<$Res>
    implements _$TourismSpotModelCopyWith<$Res> {
  __$TourismSpotModelCopyWithImpl(this._self, this._then);

  final _TourismSpotModel _self;
  final $Res Function(_TourismSpotModel) _then;

/// Create a copy of TourismSpotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? city = null,Object? province = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? openTime = null,Object? closeTime = null,Object? mapsLink = freezed,Object? facilities = freezed,Object? createdAt = null,Object? category = freezed,Object? embedding = freezed,}) {
  return _then(_TourismSpotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as String,closeTime: null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as String,mapsLink: freezed == mapsLink ? _self.mapsLink : mapsLink // ignore: cast_nullable_to_non_nullable
as String?,facilities: freezed == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
