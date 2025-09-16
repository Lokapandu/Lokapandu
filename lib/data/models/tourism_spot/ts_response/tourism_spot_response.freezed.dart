// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_spot_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TourismSpotResponse {

 List<TourismSpotModel> get models;
/// Create a copy of TourismSpotResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismSpotResponseCopyWith<TourismSpotResponse> get copyWith => _$TourismSpotResponseCopyWithImpl<TourismSpotResponse>(this as TourismSpotResponse, _$identity);

  /// Serializes this TourismSpotResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismSpotResponse&&const DeepCollectionEquality().equals(other.models, models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(models));

@override
String toString() {
  return 'TourismSpotResponse(models: $models)';
}


}

/// @nodoc
abstract mixin class $TourismSpotResponseCopyWith<$Res>  {
  factory $TourismSpotResponseCopyWith(TourismSpotResponse value, $Res Function(TourismSpotResponse) _then) = _$TourismSpotResponseCopyWithImpl;
@useResult
$Res call({
 List<TourismSpotModel> models
});




}
/// @nodoc
class _$TourismSpotResponseCopyWithImpl<$Res>
    implements $TourismSpotResponseCopyWith<$Res> {
  _$TourismSpotResponseCopyWithImpl(this._self, this._then);

  final TourismSpotResponse _self;
  final $Res Function(TourismSpotResponse) _then;

/// Create a copy of TourismSpotResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? models = null,}) {
  return _then(_self.copyWith(
models: null == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<TourismSpotModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TourismSpotResponse].
extension TourismSpotResponsePatterns on TourismSpotResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismSpotResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismSpotResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismSpotResponse value)  $default,){
final _that = this;
switch (_that) {
case _TourismSpotResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismSpotResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TourismSpotResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TourismSpotModel> models)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismSpotResponse() when $default != null:
return $default(_that.models);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TourismSpotModel> models)  $default,) {final _that = this;
switch (_that) {
case _TourismSpotResponse():
return $default(_that.models);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TourismSpotModel> models)?  $default,) {final _that = this;
switch (_that) {
case _TourismSpotResponse() when $default != null:
return $default(_that.models);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TourismSpotResponse implements TourismSpotResponse {
  const _TourismSpotResponse({required final  List<TourismSpotModel> models}): _models = models;
  factory _TourismSpotResponse.fromJson(Map<String, dynamic> json) => _$TourismSpotResponseFromJson(json);

 final  List<TourismSpotModel> _models;
@override List<TourismSpotModel> get models {
  if (_models is EqualUnmodifiableListView) return _models;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_models);
}


/// Create a copy of TourismSpotResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismSpotResponseCopyWith<_TourismSpotResponse> get copyWith => __$TourismSpotResponseCopyWithImpl<_TourismSpotResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TourismSpotResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismSpotResponse&&const DeepCollectionEquality().equals(other._models, _models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_models));

@override
String toString() {
  return 'TourismSpotResponse(models: $models)';
}


}

/// @nodoc
abstract mixin class _$TourismSpotResponseCopyWith<$Res> implements $TourismSpotResponseCopyWith<$Res> {
  factory _$TourismSpotResponseCopyWith(_TourismSpotResponse value, $Res Function(_TourismSpotResponse) _then) = __$TourismSpotResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TourismSpotModel> models
});




}
/// @nodoc
class __$TourismSpotResponseCopyWithImpl<$Res>
    implements _$TourismSpotResponseCopyWith<$Res> {
  __$TourismSpotResponseCopyWithImpl(this._self, this._then);

  final _TourismSpotResponse _self;
  final $Res Function(_TourismSpotResponse) _then;

/// Create a copy of TourismSpotResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? models = null,}) {
  return _then(_TourismSpotResponse(
models: null == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<TourismSpotModel>,
  ));
}


}

// dart format on
