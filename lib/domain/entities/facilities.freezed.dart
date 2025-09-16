// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Facilities {

 String get name; String get id;
/// Create a copy of Facilities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FacilitiesCopyWith<Facilities> get copyWith => _$FacilitiesCopyWithImpl<Facilities>(this as Facilities, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Facilities&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'Facilities(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class $FacilitiesCopyWith<$Res>  {
  factory $FacilitiesCopyWith(Facilities value, $Res Function(Facilities) _then) = _$FacilitiesCopyWithImpl;
@useResult
$Res call({
 String name, String id
});




}
/// @nodoc
class _$FacilitiesCopyWithImpl<$Res>
    implements $FacilitiesCopyWith<$Res> {
  _$FacilitiesCopyWithImpl(this._self, this._then);

  final Facilities _self;
  final $Res Function(Facilities) _then;

/// Create a copy of Facilities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Facilities].
extension FacilitiesPatterns on Facilities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Facilities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Facilities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Facilities value)  $default,){
final _that = this;
switch (_that) {
case _Facilities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Facilities value)?  $default,){
final _that = this;
switch (_that) {
case _Facilities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Facilities() when $default != null:
return $default(_that.name,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String id)  $default,) {final _that = this;
switch (_that) {
case _Facilities():
return $default(_that.name,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String id)?  $default,) {final _that = this;
switch (_that) {
case _Facilities() when $default != null:
return $default(_that.name,_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _Facilities implements Facilities {
  const _Facilities({required this.name, required this.id});
  

@override final  String name;
@override final  String id;

/// Create a copy of Facilities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FacilitiesCopyWith<_Facilities> get copyWith => __$FacilitiesCopyWithImpl<_Facilities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Facilities&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'Facilities(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class _$FacilitiesCopyWith<$Res> implements $FacilitiesCopyWith<$Res> {
  factory _$FacilitiesCopyWith(_Facilities value, $Res Function(_Facilities) _then) = __$FacilitiesCopyWithImpl;
@override @useResult
$Res call({
 String name, String id
});




}
/// @nodoc
class __$FacilitiesCopyWithImpl<$Res>
    implements _$FacilitiesCopyWith<$Res> {
  __$FacilitiesCopyWithImpl(this._self, this._then);

  final _Facilities _self;
  final $Res Function(_Facilities) _then;

/// Create a copy of Facilities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = null,}) {
  return _then(_Facilities(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
