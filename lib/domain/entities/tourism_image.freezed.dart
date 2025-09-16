// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TourismImage {

 String get id; String get label; String get fileName;
/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismImageCopyWith<TourismImage> get copyWith => _$TourismImageCopyWithImpl<TourismImage>(this as TourismImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismImage&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,fileName);

@override
String toString() {
  return 'TourismImage(id: $id, label: $label, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $TourismImageCopyWith<$Res>  {
  factory $TourismImageCopyWith(TourismImage value, $Res Function(TourismImage) _then) = _$TourismImageCopyWithImpl;
@useResult
$Res call({
 String id, String label, String fileName
});




}
/// @nodoc
class _$TourismImageCopyWithImpl<$Res>
    implements $TourismImageCopyWith<$Res> {
  _$TourismImageCopyWithImpl(this._self, this._then);

  final TourismImage _self;
  final $Res Function(TourismImage) _then;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? fileName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TourismImage].
extension TourismImagePatterns on TourismImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismImage value)  $default,){
final _that = this;
switch (_that) {
case _TourismImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismImage value)?  $default,){
final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String fileName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
return $default(_that.id,_that.label,_that.fileName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String fileName)  $default,) {final _that = this;
switch (_that) {
case _TourismImage():
return $default(_that.id,_that.label,_that.fileName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String fileName)?  $default,) {final _that = this;
switch (_that) {
case _TourismImage() when $default != null:
return $default(_that.id,_that.label,_that.fileName);case _:
  return null;

}
}

}

/// @nodoc


class _TourismImage implements TourismImage {
  const _TourismImage({required this.id, required this.label, required this.fileName});
  

@override final  String id;
@override final  String label;
@override final  String fileName;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismImageCopyWith<_TourismImage> get copyWith => __$TourismImageCopyWithImpl<_TourismImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismImage&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,fileName);

@override
String toString() {
  return 'TourismImage(id: $id, label: $label, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class _$TourismImageCopyWith<$Res> implements $TourismImageCopyWith<$Res> {
  factory _$TourismImageCopyWith(_TourismImage value, $Res Function(_TourismImage) _then) = __$TourismImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String fileName
});




}
/// @nodoc
class __$TourismImageCopyWithImpl<$Res>
    implements _$TourismImageCopyWith<$Res> {
  __$TourismImageCopyWithImpl(this._self, this._then);

  final _TourismImage _self;
  final $Res Function(_TourismImage) _then;

/// Create a copy of TourismImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? fileName = null,}) {
  return _then(_TourismImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
