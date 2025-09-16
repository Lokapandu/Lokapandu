// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tourism_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TourismImageModel {

 String get id; String get label; String get fileName;
/// Create a copy of TourismImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourismImageModelCopyWith<TourismImageModel> get copyWith => _$TourismImageModelCopyWithImpl<TourismImageModel>(this as TourismImageModel, _$identity);

  /// Serializes this TourismImageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourismImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,fileName);

@override
String toString() {
  return 'TourismImageModel(id: $id, label: $label, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $TourismImageModelCopyWith<$Res>  {
  factory $TourismImageModelCopyWith(TourismImageModel value, $Res Function(TourismImageModel) _then) = _$TourismImageModelCopyWithImpl;
@useResult
$Res call({
 String id, String label, String fileName
});




}
/// @nodoc
class _$TourismImageModelCopyWithImpl<$Res>
    implements $TourismImageModelCopyWith<$Res> {
  _$TourismImageModelCopyWithImpl(this._self, this._then);

  final TourismImageModel _self;
  final $Res Function(TourismImageModel) _then;

/// Create a copy of TourismImageModel
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


/// Adds pattern-matching-related methods to [TourismImageModel].
extension TourismImageModelPatterns on TourismImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourismImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourismImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourismImageModel value)  $default,){
final _that = this;
switch (_that) {
case _TourismImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourismImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _TourismImageModel() when $default != null:
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
case _TourismImageModel() when $default != null:
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
case _TourismImageModel():
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
case _TourismImageModel() when $default != null:
return $default(_that.id,_that.label,_that.fileName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TourismImageModel implements TourismImageModel {
  const _TourismImageModel({required this.id, required this.label, required this.fileName});
  factory _TourismImageModel.fromJson(Map<String, dynamic> json) => _$TourismImageModelFromJson(json);

@override final  String id;
@override final  String label;
@override final  String fileName;

/// Create a copy of TourismImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourismImageModelCopyWith<_TourismImageModel> get copyWith => __$TourismImageModelCopyWithImpl<_TourismImageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TourismImageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourismImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,fileName);

@override
String toString() {
  return 'TourismImageModel(id: $id, label: $label, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class _$TourismImageModelCopyWith<$Res> implements $TourismImageModelCopyWith<$Res> {
  factory _$TourismImageModelCopyWith(_TourismImageModel value, $Res Function(_TourismImageModel) _then) = __$TourismImageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String fileName
});




}
/// @nodoc
class __$TourismImageModelCopyWithImpl<$Res>
    implements _$TourismImageModelCopyWith<$Res> {
  __$TourismImageModelCopyWithImpl(this._self, this._then);

  final _TourismImageModel _self;
  final $Res Function(_TourismImageModel) _then;

/// Create a copy of TourismImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? fileName = null,}) {
  return _then(_TourismImageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
