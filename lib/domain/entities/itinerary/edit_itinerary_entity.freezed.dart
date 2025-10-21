// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_itinerary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditItinerary {

 String get id; String? get name; String? get notes; DateTime? get startTime; DateTime? get endTime; int? get tourismSpot; String? get userId;
/// Create a copy of EditItinerary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditItineraryCopyWith<EditItinerary> get copyWith => _$EditItineraryCopyWithImpl<EditItinerary>(this as EditItinerary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditItinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,notes,startTime,endTime,tourismSpot,userId);

@override
String toString() {
  return 'EditItinerary(id: $id, name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, tourismSpot: $tourismSpot, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $EditItineraryCopyWith<$Res>  {
  factory $EditItineraryCopyWith(EditItinerary value, $Res Function(EditItinerary) _then) = _$EditItineraryCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? notes, DateTime? startTime, DateTime? endTime, int? tourismSpot, String? userId
});




}
/// @nodoc
class _$EditItineraryCopyWithImpl<$Res>
    implements $EditItineraryCopyWith<$Res> {
  _$EditItineraryCopyWithImpl(this._self, this._then);

  final EditItinerary _self;
  final $Res Function(EditItinerary) _then;

/// Create a copy of EditItinerary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? notes = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? tourismSpot = freezed,Object? userId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,tourismSpot: freezed == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditItinerary].
extension EditItineraryPatterns on EditItinerary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditItinerary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditItinerary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditItinerary value)  $default,){
final _that = this;
switch (_that) {
case _EditItinerary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditItinerary value)?  $default,){
final _that = this;
switch (_that) {
case _EditItinerary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? notes,  DateTime? startTime,  DateTime? endTime,  int? tourismSpot,  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditItinerary() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? notes,  DateTime? startTime,  DateTime? endTime,  int? tourismSpot,  String? userId)  $default,) {final _that = this;
switch (_that) {
case _EditItinerary():
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? notes,  DateTime? startTime,  DateTime? endTime,  int? tourismSpot,  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _EditItinerary() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.tourismSpot,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _EditItinerary implements EditItinerary {
  const _EditItinerary({required this.id, this.name, this.notes, this.startTime, this.endTime, this.tourismSpot, this.userId});
  

@override final  String id;
@override final  String? name;
@override final  String? notes;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  int? tourismSpot;
@override final  String? userId;

/// Create a copy of EditItinerary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditItineraryCopyWith<_EditItinerary> get copyWith => __$EditItineraryCopyWithImpl<_EditItinerary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditItinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,notes,startTime,endTime,tourismSpot,userId);

@override
String toString() {
  return 'EditItinerary(id: $id, name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, tourismSpot: $tourismSpot, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$EditItineraryCopyWith<$Res> implements $EditItineraryCopyWith<$Res> {
  factory _$EditItineraryCopyWith(_EditItinerary value, $Res Function(_EditItinerary) _then) = __$EditItineraryCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? notes, DateTime? startTime, DateTime? endTime, int? tourismSpot, String? userId
});




}
/// @nodoc
class __$EditItineraryCopyWithImpl<$Res>
    implements _$EditItineraryCopyWith<$Res> {
  __$EditItineraryCopyWithImpl(this._self, this._then);

  final _EditItinerary _self;
  final $Res Function(_EditItinerary) _then;

/// Create a copy of EditItinerary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? notes = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? tourismSpot = freezed,Object? userId = freezed,}) {
  return _then(_EditItinerary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,tourismSpot: freezed == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
