// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_itinerary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserItinerary {

 int get id; String get userId; int get itinerariesId; DateTime get createdAt;
/// Create a copy of UserItinerary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserItineraryCopyWith<UserItinerary> get copyWith => _$UserItineraryCopyWithImpl<UserItinerary>(this as UserItinerary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserItinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.itinerariesId, itinerariesId) || other.itinerariesId == itinerariesId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,itinerariesId,createdAt);

@override
String toString() {
  return 'UserItinerary(id: $id, userId: $userId, itinerariesId: $itinerariesId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserItineraryCopyWith<$Res>  {
  factory $UserItineraryCopyWith(UserItinerary value, $Res Function(UserItinerary) _then) = _$UserItineraryCopyWithImpl;
@useResult
$Res call({
 int id, String userId, int itinerariesId, DateTime createdAt
});




}
/// @nodoc
class _$UserItineraryCopyWithImpl<$Res>
    implements $UserItineraryCopyWith<$Res> {
  _$UserItineraryCopyWithImpl(this._self, this._then);

  final UserItinerary _self;
  final $Res Function(UserItinerary) _then;

/// Create a copy of UserItinerary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? itinerariesId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,itinerariesId: null == itinerariesId ? _self.itinerariesId : itinerariesId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserItinerary].
extension UserItineraryPatterns on UserItinerary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserItinerary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserItinerary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserItinerary value)  $default,){
final _that = this;
switch (_that) {
case _UserItinerary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserItinerary value)?  $default,){
final _that = this;
switch (_that) {
case _UserItinerary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String userId,  int itinerariesId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserItinerary() when $default != null:
return $default(_that.id,_that.userId,_that.itinerariesId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String userId,  int itinerariesId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserItinerary():
return $default(_that.id,_that.userId,_that.itinerariesId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String userId,  int itinerariesId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserItinerary() when $default != null:
return $default(_that.id,_that.userId,_that.itinerariesId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserItinerary implements UserItinerary {
  const _UserItinerary({required this.id, required this.userId, required this.itinerariesId, required this.createdAt});
  

@override final  int id;
@override final  String userId;
@override final  int itinerariesId;
@override final  DateTime createdAt;

/// Create a copy of UserItinerary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserItineraryCopyWith<_UserItinerary> get copyWith => __$UserItineraryCopyWithImpl<_UserItinerary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserItinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.itinerariesId, itinerariesId) || other.itinerariesId == itinerariesId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,itinerariesId,createdAt);

@override
String toString() {
  return 'UserItinerary(id: $id, userId: $userId, itinerariesId: $itinerariesId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserItineraryCopyWith<$Res> implements $UserItineraryCopyWith<$Res> {
  factory _$UserItineraryCopyWith(_UserItinerary value, $Res Function(_UserItinerary) _then) = __$UserItineraryCopyWithImpl;
@override @useResult
$Res call({
 int id, String userId, int itinerariesId, DateTime createdAt
});




}
/// @nodoc
class __$UserItineraryCopyWithImpl<$Res>
    implements _$UserItineraryCopyWith<$Res> {
  __$UserItineraryCopyWithImpl(this._self, this._then);

  final _UserItinerary _self;
  final $Res Function(_UserItinerary) _then;

/// Create a copy of UserItinerary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? itinerariesId = null,Object? createdAt = null,}) {
  return _then(_UserItinerary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,itinerariesId: null == itinerariesId ? _self.itinerariesId : itinerariesId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
