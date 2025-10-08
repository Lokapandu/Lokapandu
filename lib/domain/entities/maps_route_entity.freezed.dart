// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maps_route_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapsRoutes {

 List<MapsRoute> get routes;
/// Create a copy of MapsRoutes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsRoutesCopyWith<MapsRoutes> get copyWith => _$MapsRoutesCopyWithImpl<MapsRoutes>(this as MapsRoutes, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsRoutes&&const DeepCollectionEquality().equals(other.routes, routes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(routes));

@override
String toString() {
  return 'MapsRoutes(routes: $routes)';
}


}

/// @nodoc
abstract mixin class $MapsRoutesCopyWith<$Res>  {
  factory $MapsRoutesCopyWith(MapsRoutes value, $Res Function(MapsRoutes) _then) = _$MapsRoutesCopyWithImpl;
@useResult
$Res call({
 List<MapsRoute> routes
});




}
/// @nodoc
class _$MapsRoutesCopyWithImpl<$Res>
    implements $MapsRoutesCopyWith<$Res> {
  _$MapsRoutesCopyWithImpl(this._self, this._then);

  final MapsRoutes _self;
  final $Res Function(MapsRoutes) _then;

/// Create a copy of MapsRoutes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routes = null,}) {
  return _then(_self.copyWith(
routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<MapsRoute>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapsRoutes].
extension MapsRoutesPatterns on MapsRoutes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapsRoutes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapsRoutes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapsRoutes value)  $default,){
final _that = this;
switch (_that) {
case _MapsRoutes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapsRoutes value)?  $default,){
final _that = this;
switch (_that) {
case _MapsRoutes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MapsRoute> routes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapsRoutes() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MapsRoute> routes)  $default,) {final _that = this;
switch (_that) {
case _MapsRoutes():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MapsRoute> routes)?  $default,) {final _that = this;
switch (_that) {
case _MapsRoutes() when $default != null:
return $default(_that.routes);case _:
  return null;

}
}

}

/// @nodoc


class _MapsRoutes implements MapsRoutes {
  const _MapsRoutes({required final  List<MapsRoute> routes}): _routes = routes;
  

 final  List<MapsRoute> _routes;
@override List<MapsRoute> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of MapsRoutes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapsRoutesCopyWith<_MapsRoutes> get copyWith => __$MapsRoutesCopyWithImpl<_MapsRoutes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapsRoutes&&const DeepCollectionEquality().equals(other._routes, _routes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));

@override
String toString() {
  return 'MapsRoutes(routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$MapsRoutesCopyWith<$Res> implements $MapsRoutesCopyWith<$Res> {
  factory _$MapsRoutesCopyWith(_MapsRoutes value, $Res Function(_MapsRoutes) _then) = __$MapsRoutesCopyWithImpl;
@override @useResult
$Res call({
 List<MapsRoute> routes
});




}
/// @nodoc
class __$MapsRoutesCopyWithImpl<$Res>
    implements _$MapsRoutesCopyWith<$Res> {
  __$MapsRoutesCopyWithImpl(this._self, this._then);

  final _MapsRoutes _self;
  final $Res Function(_MapsRoutes) _then;

/// Create a copy of MapsRoutes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(_MapsRoutes(
routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<MapsRoute>,
  ));
}


}

/// @nodoc
mixin _$MapsRoute {

 int get distanceMeters; String get duration;
/// Create a copy of MapsRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapsRouteCopyWith<MapsRoute> get copyWith => _$MapsRouteCopyWithImpl<MapsRoute>(this as MapsRoute, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapsRoute&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,distanceMeters,duration);

@override
String toString() {
  return 'MapsRoute(distanceMeters: $distanceMeters, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $MapsRouteCopyWith<$Res>  {
  factory $MapsRouteCopyWith(MapsRoute value, $Res Function(MapsRoute) _then) = _$MapsRouteCopyWithImpl;
@useResult
$Res call({
 int distanceMeters, String duration
});




}
/// @nodoc
class _$MapsRouteCopyWithImpl<$Res>
    implements $MapsRouteCopyWith<$Res> {
  _$MapsRouteCopyWithImpl(this._self, this._then);

  final MapsRoute _self;
  final $Res Function(MapsRoute) _then;

/// Create a copy of MapsRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distanceMeters = null,Object? duration = null,}) {
  return _then(_self.copyWith(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MapsRoute].
extension MapsRoutePatterns on MapsRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapsRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapsRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapsRoute value)  $default,){
final _that = this;
switch (_that) {
case _MapsRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapsRoute value)?  $default,){
final _that = this;
switch (_that) {
case _MapsRoute() when $default != null:
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
case _MapsRoute() when $default != null:
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
case _MapsRoute():
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
case _MapsRoute() when $default != null:
return $default(_that.distanceMeters,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _MapsRoute implements MapsRoute {
  const _MapsRoute({required this.distanceMeters, required this.duration});
  

@override final  int distanceMeters;
@override final  String duration;

/// Create a copy of MapsRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapsRouteCopyWith<_MapsRoute> get copyWith => __$MapsRouteCopyWithImpl<_MapsRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapsRoute&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,distanceMeters,duration);

@override
String toString() {
  return 'MapsRoute(distanceMeters: $distanceMeters, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$MapsRouteCopyWith<$Res> implements $MapsRouteCopyWith<$Res> {
  factory _$MapsRouteCopyWith(_MapsRoute value, $Res Function(_MapsRoute) _then) = __$MapsRouteCopyWithImpl;
@override @useResult
$Res call({
 int distanceMeters, String duration
});




}
/// @nodoc
class __$MapsRouteCopyWithImpl<$Res>
    implements _$MapsRouteCopyWith<$Res> {
  __$MapsRouteCopyWithImpl(this._self, this._then);

  final _MapsRoute _self;
  final $Res Function(_MapsRoute) _then;

/// Create a copy of MapsRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distanceMeters = null,Object? duration = null,}) {
  return _then(_MapsRoute(
distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
