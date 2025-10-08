// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maps_routes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapsRoutesModel {

 List<MapsRouteModel> get routes;
/// Create a copy of MapsRoutesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsRoutesModelCopyWith<MapsRoutesModel> get copyWith => _$MapsRoutesModelCopyWithImpl<MapsRoutesModel>(this as MapsRoutesModel, _$identity);

  /// Serializes this MapsRoutesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsRoutesModel&&const DeepCollectionEquality().equals(other.routes, routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(routes));

@override
String toString() {
  return 'MapsRoutesModel(routes: $routes)';
}


}

/// @nodoc
abstract mixin class $MapsRoutesModelCopyWith<$Res>  {
  factory $MapsRoutesModelCopyWith(MapsRoutesModel value, $Res Function(MapsRoutesModel) _then) = _$MapsRoutesModelCopyWithImpl;
@useResult
$Res call({
 List<MapsRouteModel> routes
});




}
/// @nodoc
class _$MapsRoutesModelCopyWithImpl<$Res>
    implements $MapsRoutesModelCopyWith<$Res> {
  _$MapsRoutesModelCopyWithImpl(this._self, this._then);

  final MapsRoutesModel _self;
  final $Res Function(MapsRoutesModel) _then;

/// Create a copy of MapsRoutesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routes = null,}) {
  return _then(_self.copyWith(
routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<MapsRouteModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapsRoutesModel].
extension MapsRoutesModelPatterns on MapsRoutesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapsRoutesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapsRoutesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapsRoutesModel value)  $default,){
final _that = this;
switch (_that) {
case _MapsRoutesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapsRoutesModel value)?  $default,){
final _that = this;
switch (_that) {
case _MapsRoutesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MapsRouteModel> routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapsRoutesModel() when $default != null:
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MapsRouteModel> routes)  $default,) {final _that = this;
switch (_that) {
case _MapsRoutesModel():
return $default(_that.routes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MapsRouteModel> routes)?  $default,) {final _that = this;
switch (_that) {
case _MapsRoutesModel() when $default != null:
return $default(_that.routes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapsRoutesModel implements MapsRoutesModel {
  const _MapsRoutesModel({required final  List<MapsRouteModel> routes}): _routes = routes;
  factory _MapsRoutesModel.fromJson(Map<String, dynamic> json) => _$MapsRoutesModelFromJson(json);

 final  List<MapsRouteModel> _routes;
@override List<MapsRouteModel> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of MapsRoutesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapsRoutesModelCopyWith<_MapsRoutesModel> get copyWith => __$MapsRoutesModelCopyWithImpl<_MapsRoutesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapsRoutesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapsRoutesModel&&const DeepCollectionEquality().equals(other._routes, _routes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));

@override
String toString() {
  return 'MapsRoutesModel(routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$MapsRoutesModelCopyWith<$Res> implements $MapsRoutesModelCopyWith<$Res> {
  factory _$MapsRoutesModelCopyWith(_MapsRoutesModel value, $Res Function(_MapsRoutesModel) _then) = __$MapsRoutesModelCopyWithImpl;
@override @useResult
$Res call({
 List<MapsRouteModel> routes
});




}
/// @nodoc
class __$MapsRoutesModelCopyWithImpl<$Res>
    implements _$MapsRoutesModelCopyWith<$Res> {
  __$MapsRoutesModelCopyWithImpl(this._self, this._then);

  final _MapsRoutesModel _self;
  final $Res Function(_MapsRoutesModel) _then;

/// Create a copy of MapsRoutesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(_MapsRoutesModel(
routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<MapsRouteModel>,
  ));
}


}


/// @nodoc
mixin _$MapsRouteModel {

 int get distanceMeters; String get duration;
/// Create a copy of MapsRouteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsRouteModelCopyWith<MapsRouteModel> get copyWith => _$MapsRouteModelCopyWithImpl<MapsRouteModel>(this as MapsRouteModel, _$identity);

  /// Serializes this MapsRouteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsRouteModel&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceMeters,duration);

@override
String toString() {
  return 'MapsRouteModel(distanceMeters: $distanceMeters, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $MapsRouteModelCopyWith<$Res>  {
  factory $MapsRouteModelCopyWith(MapsRouteModel value, $Res Function(MapsRouteModel) _then) = _$MapsRouteModelCopyWithImpl;
@useResult
$Res call({
 int distanceMeters, String duration
});




}
/// @nodoc
class _$MapsRouteModelCopyWithImpl<$Res>
    implements $MapsRouteModelCopyWith<$Res> {
  _$MapsRouteModelCopyWithImpl(this._self, this._then);

  final MapsRouteModel _self;
  final $Res Function(MapsRouteModel) _then;

/// Create a copy of MapsRouteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distanceMeters = null,Object? duration = null,}) {
  return _then(_self.copyWith(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MapsRouteModel].
extension MapsRouteModelPatterns on MapsRouteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapsRouteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapsRouteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapsRouteModel value)  $default,){
final _that = this;
switch (_that) {
case _MapsRouteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapsRouteModel value)?  $default,){
final _that = this;
switch (_that) {
case _MapsRouteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int distanceMeters,  String duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapsRouteModel() when $default != null:
return $default(_that.distanceMeters,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int distanceMeters,  String duration)  $default,) {final _that = this;
switch (_that) {
case _MapsRouteModel():
return $default(_that.distanceMeters,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int distanceMeters,  String duration)?  $default,) {final _that = this;
switch (_that) {
case _MapsRouteModel() when $default != null:
return $default(_that.distanceMeters,_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapsRouteModel implements MapsRouteModel {
  const _MapsRouteModel({required this.distanceMeters, required this.duration});
  factory _MapsRouteModel.fromJson(Map<String, dynamic> json) => _$MapsRouteModelFromJson(json);

@override final  int distanceMeters;
@override final  String duration;

/// Create a copy of MapsRouteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapsRouteModelCopyWith<_MapsRouteModel> get copyWith => __$MapsRouteModelCopyWithImpl<_MapsRouteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapsRouteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapsRouteModel&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceMeters,duration);

@override
String toString() {
  return 'MapsRouteModel(distanceMeters: $distanceMeters, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$MapsRouteModelCopyWith<$Res> implements $MapsRouteModelCopyWith<$Res> {
  factory _$MapsRouteModelCopyWith(_MapsRouteModel value, $Res Function(_MapsRouteModel) _then) = __$MapsRouteModelCopyWithImpl;
@override @useResult
$Res call({
 int distanceMeters, String duration
});




}
/// @nodoc
class __$MapsRouteModelCopyWithImpl<$Res>
    implements _$MapsRouteModelCopyWith<$Res> {
  __$MapsRouteModelCopyWithImpl(this._self, this._then);

  final _MapsRouteModel _self;
  final $Res Function(_MapsRouteModel) _then;

/// Create a copy of MapsRouteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distanceMeters = null,Object? duration = null,}) {
  return _then(_MapsRouteModel(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
