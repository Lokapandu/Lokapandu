// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get message;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClientFailure value)?  client,TResult Function( ServerFailure value)?  server,TResult Function( ParsingFailure value)?  parsing,TResult Function( ConnectionFailure value)?  connection,TResult Function( DatabaseFailure value)?  database,TResult Function( ValidationFailure value)?  validation,TResult Function( SchedulingConflictFailure value)?  schedulingConflict,TResult Function( InvalidTimeRangeFailure value)?  invalidTimeRange,TResult Function( InvalidTimeFormatFailure value)?  invalidTimeFormat,TResult Function( MissingFieldFailure value)?  missingField,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClientFailure() when client != null:
return client(_that);case ServerFailure() when server != null:
return server(_that);case ParsingFailure() when parsing != null:
return parsing(_that);case ConnectionFailure() when connection != null:
return connection(_that);case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case SchedulingConflictFailure() when schedulingConflict != null:
return schedulingConflict(_that);case InvalidTimeRangeFailure() when invalidTimeRange != null:
return invalidTimeRange(_that);case InvalidTimeFormatFailure() when invalidTimeFormat != null:
return invalidTimeFormat(_that);case MissingFieldFailure() when missingField != null:
return missingField(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClientFailure value)  client,required TResult Function( ServerFailure value)  server,required TResult Function( ParsingFailure value)  parsing,required TResult Function( ConnectionFailure value)  connection,required TResult Function( DatabaseFailure value)  database,required TResult Function( ValidationFailure value)  validation,required TResult Function( SchedulingConflictFailure value)  schedulingConflict,required TResult Function( InvalidTimeRangeFailure value)  invalidTimeRange,required TResult Function( InvalidTimeFormatFailure value)  invalidTimeFormat,required TResult Function( MissingFieldFailure value)  missingField,}){
final _that = this;
switch (_that) {
case ClientFailure():
return client(_that);case ServerFailure():
return server(_that);case ParsingFailure():
return parsing(_that);case ConnectionFailure():
return connection(_that);case DatabaseFailure():
return database(_that);case ValidationFailure():
return validation(_that);case SchedulingConflictFailure():
return schedulingConflict(_that);case InvalidTimeRangeFailure():
return invalidTimeRange(_that);case InvalidTimeFormatFailure():
return invalidTimeFormat(_that);case MissingFieldFailure():
return missingField(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClientFailure value)?  client,TResult? Function( ServerFailure value)?  server,TResult? Function( ParsingFailure value)?  parsing,TResult? Function( ConnectionFailure value)?  connection,TResult? Function( DatabaseFailure value)?  database,TResult? Function( ValidationFailure value)?  validation,TResult? Function( SchedulingConflictFailure value)?  schedulingConflict,TResult? Function( InvalidTimeRangeFailure value)?  invalidTimeRange,TResult? Function( InvalidTimeFormatFailure value)?  invalidTimeFormat,TResult? Function( MissingFieldFailure value)?  missingField,}){
final _that = this;
switch (_that) {
case ClientFailure() when client != null:
return client(_that);case ServerFailure() when server != null:
return server(_that);case ParsingFailure() when parsing != null:
return parsing(_that);case ConnectionFailure() when connection != null:
return connection(_that);case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case SchedulingConflictFailure() when schedulingConflict != null:
return schedulingConflict(_that);case InvalidTimeRangeFailure() when invalidTimeRange != null:
return invalidTimeRange(_that);case InvalidTimeFormatFailure() when invalidTimeFormat != null:
return invalidTimeFormat(_that);case MissingFieldFailure() when missingField != null:
return missingField(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  client,TResult Function( String message)?  server,TResult Function( String message)?  parsing,TResult Function( String message)?  connection,TResult Function( String message)?  database,TResult Function( String message)?  validation,TResult Function( String message)?  schedulingConflict,TResult Function( String message)?  invalidTimeRange,TResult Function( String message)?  invalidTimeFormat,TResult Function( String message)?  missingField,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClientFailure() when client != null:
return client(_that.message);case ServerFailure() when server != null:
return server(_that.message);case ParsingFailure() when parsing != null:
return parsing(_that.message);case ConnectionFailure() when connection != null:
return connection(_that.message);case DatabaseFailure() when database != null:
return database(_that.message);case ValidationFailure() when validation != null:
return validation(_that.message);case SchedulingConflictFailure() when schedulingConflict != null:
return schedulingConflict(_that.message);case InvalidTimeRangeFailure() when invalidTimeRange != null:
return invalidTimeRange(_that.message);case InvalidTimeFormatFailure() when invalidTimeFormat != null:
return invalidTimeFormat(_that.message);case MissingFieldFailure() when missingField != null:
return missingField(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  client,required TResult Function( String message)  server,required TResult Function( String message)  parsing,required TResult Function( String message)  connection,required TResult Function( String message)  database,required TResult Function( String message)  validation,required TResult Function( String message)  schedulingConflict,required TResult Function( String message)  invalidTimeRange,required TResult Function( String message)  invalidTimeFormat,required TResult Function( String message)  missingField,}) {final _that = this;
switch (_that) {
case ClientFailure():
return client(_that.message);case ServerFailure():
return server(_that.message);case ParsingFailure():
return parsing(_that.message);case ConnectionFailure():
return connection(_that.message);case DatabaseFailure():
return database(_that.message);case ValidationFailure():
return validation(_that.message);case SchedulingConflictFailure():
return schedulingConflict(_that.message);case InvalidTimeRangeFailure():
return invalidTimeRange(_that.message);case InvalidTimeFormatFailure():
return invalidTimeFormat(_that.message);case MissingFieldFailure():
return missingField(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  client,TResult? Function( String message)?  server,TResult? Function( String message)?  parsing,TResult? Function( String message)?  connection,TResult? Function( String message)?  database,TResult? Function( String message)?  validation,TResult? Function( String message)?  schedulingConflict,TResult? Function( String message)?  invalidTimeRange,TResult? Function( String message)?  invalidTimeFormat,TResult? Function( String message)?  missingField,}) {final _that = this;
switch (_that) {
case ClientFailure() when client != null:
return client(_that.message);case ServerFailure() when server != null:
return server(_that.message);case ParsingFailure() when parsing != null:
return parsing(_that.message);case ConnectionFailure() when connection != null:
return connection(_that.message);case DatabaseFailure() when database != null:
return database(_that.message);case ValidationFailure() when validation != null:
return validation(_that.message);case SchedulingConflictFailure() when schedulingConflict != null:
return schedulingConflict(_that.message);case InvalidTimeRangeFailure() when invalidTimeRange != null:
return invalidTimeRange(_that.message);case InvalidTimeFormatFailure() when invalidTimeFormat != null:
return invalidTimeFormat(_that.message);case MissingFieldFailure() when missingField != null:
return missingField(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ClientFailure implements Failure {
  const ClientFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientFailureCopyWith<ClientFailure> get copyWith => _$ClientFailureCopyWithImpl<ClientFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.client(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ClientFailureCopyWith(ClientFailure value, $Res Function(ClientFailure) _then) = _$ClientFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ClientFailureCopyWithImpl<$Res>
    implements $ClientFailureCopyWith<$Res> {
  _$ClientFailureCopyWithImpl(this._self, this._then);

  final ClientFailure _self;
  final $Res Function(ClientFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClientFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParsingFailure implements Failure {
  const ParsingFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsingFailureCopyWith<ParsingFailure> get copyWith => _$ParsingFailureCopyWithImpl<ParsingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsingFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.parsing(message: $message)';
}


}

/// @nodoc
abstract mixin class $ParsingFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ParsingFailureCopyWith(ParsingFailure value, $Res Function(ParsingFailure) _then) = _$ParsingFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ParsingFailureCopyWithImpl<$Res>
    implements $ParsingFailureCopyWith<$Res> {
  _$ParsingFailureCopyWithImpl(this._self, this._then);

  final ParsingFailure _self;
  final $Res Function(ParsingFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ParsingFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ConnectionFailure implements Failure {
  const ConnectionFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionFailureCopyWith<ConnectionFailure> get copyWith => _$ConnectionFailureCopyWithImpl<ConnectionFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.connection(message: $message)';
}


}

/// @nodoc
abstract mixin class $ConnectionFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ConnectionFailureCopyWith(ConnectionFailure value, $Res Function(ConnectionFailure) _then) = _$ConnectionFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ConnectionFailureCopyWithImpl<$Res>
    implements $ConnectionFailureCopyWith<$Res> {
  _$ConnectionFailureCopyWithImpl(this._self, this._then);

  final ConnectionFailure _self;
  final $Res Function(ConnectionFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ConnectionFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DatabaseFailure implements Failure {
  const DatabaseFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseFailureCopyWith<DatabaseFailure> get copyWith => _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.database(message: $message)';
}


}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(DatabaseFailure value, $Res Function(DatabaseFailure) _then) = _$DatabaseFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DatabaseFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ValidationFailure implements Failure {
  const ValidationFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.validation(message: $message)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ValidationFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SchedulingConflictFailure implements Failure {
  const SchedulingConflictFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchedulingConflictFailureCopyWith<SchedulingConflictFailure> get copyWith => _$SchedulingConflictFailureCopyWithImpl<SchedulingConflictFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulingConflictFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.schedulingConflict(message: $message)';
}


}

/// @nodoc
abstract mixin class $SchedulingConflictFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $SchedulingConflictFailureCopyWith(SchedulingConflictFailure value, $Res Function(SchedulingConflictFailure) _then) = _$SchedulingConflictFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SchedulingConflictFailureCopyWithImpl<$Res>
    implements $SchedulingConflictFailureCopyWith<$Res> {
  _$SchedulingConflictFailureCopyWithImpl(this._self, this._then);

  final SchedulingConflictFailure _self;
  final $Res Function(SchedulingConflictFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SchedulingConflictFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidTimeRangeFailure implements Failure {
  const InvalidTimeRangeFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidTimeRangeFailureCopyWith<InvalidTimeRangeFailure> get copyWith => _$InvalidTimeRangeFailureCopyWithImpl<InvalidTimeRangeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidTimeRangeFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.invalidTimeRange(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidTimeRangeFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $InvalidTimeRangeFailureCopyWith(InvalidTimeRangeFailure value, $Res Function(InvalidTimeRangeFailure) _then) = _$InvalidTimeRangeFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidTimeRangeFailureCopyWithImpl<$Res>
    implements $InvalidTimeRangeFailureCopyWith<$Res> {
  _$InvalidTimeRangeFailureCopyWithImpl(this._self, this._then);

  final InvalidTimeRangeFailure _self;
  final $Res Function(InvalidTimeRangeFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidTimeRangeFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidTimeFormatFailure implements Failure {
  const InvalidTimeFormatFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidTimeFormatFailureCopyWith<InvalidTimeFormatFailure> get copyWith => _$InvalidTimeFormatFailureCopyWithImpl<InvalidTimeFormatFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidTimeFormatFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.invalidTimeFormat(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidTimeFormatFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $InvalidTimeFormatFailureCopyWith(InvalidTimeFormatFailure value, $Res Function(InvalidTimeFormatFailure) _then) = _$InvalidTimeFormatFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidTimeFormatFailureCopyWithImpl<$Res>
    implements $InvalidTimeFormatFailureCopyWith<$Res> {
  _$InvalidTimeFormatFailureCopyWithImpl(this._self, this._then);

  final InvalidTimeFormatFailure _self;
  final $Res Function(InvalidTimeFormatFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidTimeFormatFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MissingFieldFailure implements Failure {
  const MissingFieldFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissingFieldFailureCopyWith<MissingFieldFailure> get copyWith => _$MissingFieldFailureCopyWithImpl<MissingFieldFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingFieldFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.missingField(message: $message)';
}


}

/// @nodoc
abstract mixin class $MissingFieldFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $MissingFieldFailureCopyWith(MissingFieldFailure value, $Res Function(MissingFieldFailure) _then) = _$MissingFieldFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MissingFieldFailureCopyWithImpl<$Res>
    implements $MissingFieldFailureCopyWith<$Res> {
  _$MissingFieldFailureCopyWithImpl(this._self, this._then);

  final MissingFieldFailure _self;
  final $Res Function(MissingFieldFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MissingFieldFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
