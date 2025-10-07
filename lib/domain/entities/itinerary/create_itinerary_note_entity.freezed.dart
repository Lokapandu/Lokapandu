// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_itinerary_note_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateItineraryNote {

 String get name; String get notes; DateTime get startTime; DateTime get endTime;
/// Create a copy of CreateItineraryNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateItineraryNoteCopyWith<CreateItineraryNote> get copyWith => _$CreateItineraryNoteCopyWithImpl<CreateItineraryNote>(this as CreateItineraryNote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateItineraryNote&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}


@override
int get hashCode => Object.hash(runtimeType,name,notes,startTime,endTime);

@override
String toString() {
  return 'CreateItineraryNote(name: $name, notes: $notes, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $CreateItineraryNoteCopyWith<$Res>  {
  factory $CreateItineraryNoteCopyWith(CreateItineraryNote value, $Res Function(CreateItineraryNote) _then) = _$CreateItineraryNoteCopyWithImpl;
@useResult
$Res call({
 String name, String notes, DateTime startTime, DateTime endTime
});




}
/// @nodoc
class _$CreateItineraryNoteCopyWithImpl<$Res>
    implements $CreateItineraryNoteCopyWith<$Res> {
  _$CreateItineraryNoteCopyWithImpl(this._self, this._then);

  final CreateItineraryNote _self;
  final $Res Function(CreateItineraryNote) _then;

/// Create a copy of CreateItineraryNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? notes = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateItineraryNote].
extension CreateItineraryNotePatterns on CreateItineraryNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateItineraryNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateItineraryNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateItineraryNote value)  $default,){
final _that = this;
switch (_that) {
case _CreateItineraryNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateItineraryNote value)?  $default,){
final _that = this;
switch (_that) {
case _CreateItineraryNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String notes,  DateTime startTime,  DateTime endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateItineraryNote() when $default != null:
return $default(_that.name,_that.notes,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String notes,  DateTime startTime,  DateTime endTime)  $default,) {final _that = this;
switch (_that) {
case _CreateItineraryNote():
return $default(_that.name,_that.notes,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String notes,  DateTime startTime,  DateTime endTime)?  $default,) {final _that = this;
switch (_that) {
case _CreateItineraryNote() when $default != null:
return $default(_that.name,_that.notes,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc


class _CreateItineraryNote implements CreateItineraryNote {
  const _CreateItineraryNote({required this.name, required this.notes, required this.startTime, required this.endTime});
  

@override final  String name;
@override final  String notes;
@override final  DateTime startTime;
@override final  DateTime endTime;

/// Create a copy of CreateItineraryNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateItineraryNoteCopyWith<_CreateItineraryNote> get copyWith => __$CreateItineraryNoteCopyWithImpl<_CreateItineraryNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateItineraryNote&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}


@override
int get hashCode => Object.hash(runtimeType,name,notes,startTime,endTime);

@override
String toString() {
  return 'CreateItineraryNote(name: $name, notes: $notes, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$CreateItineraryNoteCopyWith<$Res> implements $CreateItineraryNoteCopyWith<$Res> {
  factory _$CreateItineraryNoteCopyWith(_CreateItineraryNote value, $Res Function(_CreateItineraryNote) _then) = __$CreateItineraryNoteCopyWithImpl;
@override @useResult
$Res call({
 String name, String notes, DateTime startTime, DateTime endTime
});




}
/// @nodoc
class __$CreateItineraryNoteCopyWithImpl<$Res>
    implements _$CreateItineraryNoteCopyWith<$Res> {
  __$CreateItineraryNoteCopyWithImpl(this._self, this._then);

  final _CreateItineraryNote _self;
  final $Res Function(_CreateItineraryNote) _then;

/// Create a copy of CreateItineraryNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? notes = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_CreateItineraryNote(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
