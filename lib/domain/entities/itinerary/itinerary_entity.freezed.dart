// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'itinerary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Itinerary {

 String get id; String get name; String? get notes; DateTime get startTime; DateTime get endTime; DateTime get createdAt; TourismSpot? get tourismSpot;
/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItineraryCopyWith<Itinerary> get copyWith => _$ItineraryCopyWithImpl<Itinerary>(this as Itinerary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Itinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,notes,startTime,endTime,createdAt,tourismSpot);

@override
String toString() {
  return 'Itinerary(id: $id, name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, tourismSpot: $tourismSpot)';
}


}

/// @nodoc
abstract mixin class $ItineraryCopyWith<$Res>  {
  factory $ItineraryCopyWith(Itinerary value, $Res Function(Itinerary) _then) = _$ItineraryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? notes, DateTime startTime, DateTime endTime, DateTime createdAt, TourismSpot? tourismSpot
});


$TourismSpotCopyWith<$Res>? get tourismSpot;

}
/// @nodoc
class _$ItineraryCopyWithImpl<$Res>
    implements $ItineraryCopyWith<$Res> {
  _$ItineraryCopyWithImpl(this._self, this._then);

  final Itinerary _self;
  final $Res Function(Itinerary) _then;

/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? notes = freezed,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? tourismSpot = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,tourismSpot: freezed == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpot?,
  ));
}
/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotCopyWith<$Res>? get tourismSpot {
    if (_self.tourismSpot == null) {
    return null;
  }

  return $TourismSpotCopyWith<$Res>(_self.tourismSpot!, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}


/// Adds pattern-matching-related methods to [Itinerary].
extension ItineraryPatterns on Itinerary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Itinerary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Itinerary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Itinerary value)  $default,){
final _that = this;
switch (_that) {
case _Itinerary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Itinerary value)?  $default,){
final _that = this;
switch (_that) {
case _Itinerary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? notes,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  TourismSpot? tourismSpot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Itinerary() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.createdAt,_that.tourismSpot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? notes,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  TourismSpot? tourismSpot)  $default,) {final _that = this;
switch (_that) {
case _Itinerary():
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.createdAt,_that.tourismSpot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? notes,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  TourismSpot? tourismSpot)?  $default,) {final _that = this;
switch (_that) {
case _Itinerary() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.startTime,_that.endTime,_that.createdAt,_that.tourismSpot);case _:
  return null;

}
}

}

/// @nodoc


class _Itinerary implements Itinerary {
  const _Itinerary({required this.id, required this.name, this.notes, required this.startTime, required this.endTime, required this.createdAt, this.tourismSpot});
  

@override final  String id;
@override final  String name;
@override final  String? notes;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  DateTime createdAt;
@override final  TourismSpot? tourismSpot;

/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItineraryCopyWith<_Itinerary> get copyWith => __$ItineraryCopyWithImpl<_Itinerary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Itinerary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.tourismSpot, tourismSpot) || other.tourismSpot == tourismSpot));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,notes,startTime,endTime,createdAt,tourismSpot);

@override
String toString() {
  return 'Itinerary(id: $id, name: $name, notes: $notes, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, tourismSpot: $tourismSpot)';
}


}

/// @nodoc
abstract mixin class _$ItineraryCopyWith<$Res> implements $ItineraryCopyWith<$Res> {
  factory _$ItineraryCopyWith(_Itinerary value, $Res Function(_Itinerary) _then) = __$ItineraryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? notes, DateTime startTime, DateTime endTime, DateTime createdAt, TourismSpot? tourismSpot
});


@override $TourismSpotCopyWith<$Res>? get tourismSpot;

}
/// @nodoc
class __$ItineraryCopyWithImpl<$Res>
    implements _$ItineraryCopyWith<$Res> {
  __$ItineraryCopyWithImpl(this._self, this._then);

  final _Itinerary _self;
  final $Res Function(_Itinerary) _then;

/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? notes = freezed,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? tourismSpot = freezed,}) {
  return _then(_Itinerary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,tourismSpot: freezed == tourismSpot ? _self.tourismSpot : tourismSpot // ignore: cast_nullable_to_non_nullable
as TourismSpot?,
  ));
}

/// Create a copy of Itinerary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TourismSpotCopyWith<$Res>? get tourismSpot {
    if (_self.tourismSpot == null) {
    return null;
  }

  return $TourismSpotCopyWith<$Res>(_self.tourismSpot!, (value) {
    return _then(_self.copyWith(tourismSpot: value));
  });
}
}

// dart format on
