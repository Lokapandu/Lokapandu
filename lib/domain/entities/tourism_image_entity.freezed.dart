// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_image_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TourismImageEntity {

 int get id; TourismSpotEntity get tourismSpot; String get label; String get imageUrl; DateTime get createdAt;
/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismImageEntityCopyWith<TourismImageEntity> get copyWith => _$TourismImageEntityCopyWithImpl<TourismImageEntity>(this as TourismImageEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismImageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tourismSpot,label,imageUrl,createdAt);

@override
String toString() {
  return 'TourismImageEntity(id: $id, tourismSpot: $tourismSpot, label: $label, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TourismImageEntityCopyWith<$Res>  {
  factory $TourismImageEntityCopyWith(TourismImageEntity value, $Res Function(TourismImageEntity) _then) = _$TourismImageEntityCopyWithImpl;
@useResult
$Res call({
 int id, TourismSpotEntity tourismSpot, String label, String imageUrl, DateTime createdAt
});


$TourismSpotEntityCopyWith<$Res> get tourismSpot;

}
/// @nodoc
class _$TourismImageEntityCopyWithImpl<$Res>
    implements $TourismImageEntityCopyWith<$Res> {
  _$TourismImageEntityCopyWithImpl(this._self, this._then);

  final TourismImageEntity _self;
  final $Res Function(TourismImageEntity) _then;

/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tourismSpot = null,Object? label = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpotEntity,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotEntityCopyWith<$Res> get tourismSpot {
  
  return $TourismSpotEntityCopyWith<$Res>(_self.tourismSpot, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}


/// Adds pattern-matching-related methods to [TourismImageEntity].
extension TourismImageEntityPatterns on TourismImageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismImageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismImageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismImageEntity value)  $default,){
final _that = this;
switch (_that) {
case _TourismImageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismImageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TourismImageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  TourismSpotEntity tourismSpot,  String label,  String imageUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismImageEntity() when $default != null:
return $default(_that.id,_that.tourismSpot,_that.label,_that.imageUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  TourismSpotEntity tourismSpot,  String label,  String imageUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TourismImageEntity():
return $default(_that.id,_that.tourismSpot,_that.label,_that.imageUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  TourismSpotEntity tourismSpot,  String label,  String imageUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TourismImageEntity() when $default != null:
return $default(_that.id,_that.tourismSpot,_that.label,_that.imageUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _TourismImageEntity implements TourismImageEntity {
  const _TourismImageEntity({required this.id, required this.tourismSpot, required this.label, required this.imageUrl, required this.createdAt});
  

@override final  int id;
@override final  TourismSpotEntity tourismSpot;
@override final  String label;
@override final  String imageUrl;
@override final  DateTime createdAt;

/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismImageEntityCopyWith<_TourismImageEntity> get copyWith => __$TourismImageEntityCopyWithImpl<_TourismImageEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismImageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tourismSpot,label,imageUrl,createdAt);

@override
String toString() {
  return 'TourismImageEntity(id: $id, tourismSpot: $tourismSpot, label: $label, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TourismImageEntityCopyWith<$Res> implements $TourismImageEntityCopyWith<$Res> {
  factory _$TourismImageEntityCopyWith(_TourismImageEntity value, $Res Function(_TourismImageEntity) _then) = __$TourismImageEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, TourismSpotEntity tourismSpot, String label, String imageUrl, DateTime createdAt
});


@override $TourismSpotEntityCopyWith<$Res> get tourismSpot;

}
/// @nodoc
class __$TourismImageEntityCopyWithImpl<$Res>
    implements _$TourismImageEntityCopyWith<$Res> {
  __$TourismImageEntityCopyWithImpl(this._self, this._then);

  final _TourismImageEntity _self;
  final $Res Function(_TourismImageEntity) _then;

/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tourismSpot = null,Object? label = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_TourismImageEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpotEntity,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of TourismImageEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotEntityCopyWith<$Res> get tourismSpot {
  
  return $TourismSpotEntityCopyWith<$Res>(_self.tourismSpot, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}

// dart format on
