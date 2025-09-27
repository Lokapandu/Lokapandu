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
mixin _$TourismImage {

 int get id; TourismSpot get tourismSpot; String get label; String get imageUrl; DateTime get createdAt;
/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismImageCopyWith<TourismImage> get copyWith => _$TourismImageCopyWithImpl<TourismImage>(this as TourismImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismImage&&(identical(other.id, id) || other.id == id)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tourismSpot,label,imageUrl,createdAt);

@override
String toString() {
  return 'TourismImage(id: $id, tourismSpot: $tourismSpot, label: $label, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TourismImageCopyWith<$Res>  {
  factory $TourismImageCopyWith(TourismImage value, $Res Function(TourismImage) _then) = _$TourismImageCopyWithImpl;
@useResult
$Res call({
 int id, TourismSpot tourismSpot, String label, String imageUrl, DateTime createdAt
});


$TourismSpotCopyWith<$Res> get tourismSpot;

}
/// @nodoc
class _$TourismImageCopyWithImpl<$Res>
    implements $TourismImageCopyWith<$Res> {
  _$TourismImageCopyWithImpl(this._self, this._then);

  final TourismImage _self;
  final $Res Function(TourismImage) _then;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tourismSpot = null,Object? label = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpot,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotCopyWith<$Res> get tourismSpot {
  
  return $TourismSpotCopyWith<$Res>(_self.tourismSpot, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}


/// Adds pattern-matching-related methods to [TourismImage].
extension TourismImagePatterns on TourismImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismImage value)  $default,){
final _that = this;
switch (_that) {
case _TourismImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismImage value)?  $default,){
final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  TourismSpot tourismSpot,  String label,  String imageUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  TourismSpot tourismSpot,  String label,  String imageUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TourismImage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  TourismSpot tourismSpot,  String label,  String imageUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
return $default(_that.id,_that.tourismSpot,_that.label,_that.imageUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _TourismImage implements TourismImage {
  const _TourismImage({required this.id, required this.tourismSpot, required this.label, required this.imageUrl, required this.createdAt});
  

@override final  int id;
@override final  TourismSpot tourismSpot;
@override final  String label;
@override final  String imageUrl;
@override final  DateTime createdAt;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismImageCopyWith<_TourismImage> get copyWith => __$TourismImageCopyWithImpl<_TourismImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismImage&&(identical(other.id, id) || other.id == id)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tourismSpot,label,imageUrl,createdAt);

@override
String toString() {
  return 'TourismImage(id: $id, tourismSpot: $tourismSpot, label: $label, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TourismImageCopyWith<$Res> implements $TourismImageCopyWith<$Res> {
  factory _$TourismImageCopyWith(_TourismImage value, $Res Function(_TourismImage) _then) = __$TourismImageCopyWithImpl;
@override @useResult
$Res call({
 int id, TourismSpot tourismSpot, String label, String imageUrl, DateTime createdAt
});


@override $TourismSpotCopyWith<$Res> get tourismSpot;

}
/// @nodoc
class __$TourismImageCopyWithImpl<$Res>
    implements _$TourismImageCopyWith<$Res> {
  __$TourismImageCopyWithImpl(this._self, this._then);

  final _TourismImage _self;
  final $Res Function(_TourismImage) _then;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tourismSpot = null,Object? label = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_TourismImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpot,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotCopyWith<$Res> get tourismSpot {
  
  return $TourismSpotCopyWith<$Res>(_self.tourismSpot, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}

// dart format on
