// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_itinerary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateItinerary {

 String get name; String? get notes; DateTime get startTime; DateTime get endTime; int get tourismSpot; String get userId;
/// Create a copy of CreateItinerary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateItineraryCopyWith<CreateItinerary> get copyWith => _$CreateItineraryCopyWithImpl<CreateItinerary>(this as CreateItinerary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateItinerary&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,name,notes,startTime,endTime,tourismSpot,userId);

@override
String toString() {
  return 'CreateItinerary(name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, tourismSpot: $tourismSpot, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $CreateItineraryCopyWith<$Res>  {
  factory $CreateItineraryCopyWith(CreateItinerary value, $Res Function(CreateItinerary) _then) = _$CreateItineraryCopyWithImpl;
@useResult
$Res call({
 String name, String? notes, DateTime startTime, DateTime endTime, int tourismSpot, String userId
});




}
/// @nodoc
class _$CreateItineraryCopyWithImpl<$Res>
    implements $CreateItineraryCopyWith<$Res> {
  _$CreateItineraryCopyWithImpl(this._self, this._then);

  final CreateItinerary _self;
  final $Res Function(CreateItinerary) _then;

/// Create a copy of CreateItinerary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? notes = freezed,Object? startTime = null,Object? endTime = null,Object? tourismSpot = null,Object? userId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateItinerary].
extension CreateItineraryPatterns on CreateItinerary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateItinerary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateItinerary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateItinerary value)  $default,){
final _that = this;
switch (_that) {
case _CreateItinerary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateItinerary value)?  $default,){
final _that = this;
switch (_that) {
case _CreateItinerary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? notes,  DateTime startTime,  DateTime endTime,  int tourismSpot,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateItinerary() when $default != null:
return $default(_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? notes,  DateTime startTime,  DateTime endTime,  int tourismSpot,  String userId)  $default,) {final _that = this;
switch (_that) {
case _CreateItinerary():
return $default(_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? notes,  DateTime startTime,  DateTime endTime,  int tourismSpot,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _CreateItinerary() when $default != null:
return $default(_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _CreateItinerary implements CreateItinerary {
  const _CreateItinerary({required this.name, this.notes, required this.startTime, required this.endTime, required this.tourismSpot, required this.userId});
  

@override final  String name;
@override final  String? notes;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  int tourismSpot;
@override final  String userId;

/// Create a copy of CreateItinerary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateItineraryCopyWith<_CreateItinerary> get copyWith => __$CreateItineraryCopyWithImpl<_CreateItinerary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateItinerary&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,name,notes,startTime,endTime,tourismSpot,userId);

@override
String toString() {
  return 'CreateItinerary(name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, tourismSpot: $tourismSpot, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$CreateItineraryCopyWith<$Res> implements $CreateItineraryCopyWith<$Res> {
  factory _$CreateItineraryCopyWith(_CreateItinerary value, $Res Function(_CreateItinerary) _then) = __$CreateItineraryCopyWithImpl;
@override @useResult
$Res call({
 String name, String? notes, DateTime startTime, DateTime endTime, int tourismSpot, String userId
});




}
/// @nodoc
class __$CreateItineraryCopyWithImpl<$Res>
    implements _$CreateItineraryCopyWith<$Res> {
  __$CreateItineraryCopyWithImpl(this._self, this._then);

  final _CreateItinerary _self;
  final $Res Function(_CreateItinerary) _then;

/// Create a copy of CreateItinerary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? notes = freezed,Object? startTime = null,Object? endTime = null,Object? tourismSpot = null,Object? userId = null,}) {
  return _then(_CreateItinerary(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,tourismSpot: null == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
