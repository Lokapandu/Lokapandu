// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiChatModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get content;@JsonKey(name: 'is_from_user') bool get isFromUser;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of AiChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatModelCopyWith<AiChatModel> get copyWith => _$AiChatModelCopyWithImpl<AiChatModel>(this as AiChatModel, _$identity);

  /// Serializes this AiChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.isFromUser, isFromUser) || other.isFromUser == isFromUser)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,content,isFromUser,createdAt);

@override
String toString() {
  return 'AiChatModel(id: $id, userId: $userId, content: $content, isFromUser: $isFromUser, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AiChatModelCopyWith<$Res>  {
  factory $AiChatModelCopyWith(AiChatModel value, $Res Function(AiChatModel) _then) = _$AiChatModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String content,@JsonKey(name: 'is_from_user') bool isFromUser,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AiChatModelCopyWithImpl<$Res>
    implements $AiChatModelCopyWith<$Res> {
  _$AiChatModelCopyWithImpl(this._self, this._then);

  final AiChatModel _self;
  final $Res Function(AiChatModel) _then;

/// Create a copy of AiChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? content = null,Object? isFromUser = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isFromUser: null == isFromUser ? _self.isFromUser : isFromUser // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AiChatModel].
extension AiChatModelPatterns on AiChatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatModel value)  $default,){
final _that = this;
switch (_that) {
case _AiChatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatModel value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'is_from_user')  bool isFromUser, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatModel() when $default != null:
return $default(_that.id,_that.userId,_that.content,_that.isFromUser,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'is_from_user')  bool isFromUser, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AiChatModel():
return $default(_that.id,_that.userId,_that.content,_that.isFromUser,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'is_from_user')  bool isFromUser, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AiChatModel() when $default != null:
return $default(_that.id,_that.userId,_that.content,_that.isFromUser,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiChatModel implements AiChatModel {
  const _AiChatModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.content, @JsonKey(name: 'is_from_user') required this.isFromUser, @JsonKey(name: 'created_at') required this.createdAt});
  factory _AiChatModel.fromJson(Map<String, dynamic> json) => _$AiChatModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String content;
@override@JsonKey(name: 'is_from_user') final  bool isFromUser;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of AiChatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatModelCopyWith<_AiChatModel> get copyWith => __$AiChatModelCopyWithImpl<_AiChatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiChatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.isFromUser, isFromUser) || other.isFromUser == isFromUser)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,content,isFromUser,createdAt);

@override
String toString() {
  return 'AiChatModel(id: $id, userId: $userId, content: $content, isFromUser: $isFromUser, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AiChatModelCopyWith<$Res> implements $AiChatModelCopyWith<$Res> {
  factory _$AiChatModelCopyWith(_AiChatModel value, $Res Function(_AiChatModel) _then) = __$AiChatModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String content,@JsonKey(name: 'is_from_user') bool isFromUser,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AiChatModelCopyWithImpl<$Res>
    implements _$AiChatModelCopyWith<$Res> {
  __$AiChatModelCopyWithImpl(this._self, this._then);

  final _AiChatModel _self;
  final $Res Function(_AiChatModel) _then;

/// Create a copy of AiChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? content = null,Object? isFromUser = null,Object? createdAt = null,}) {
  return _then(_AiChatModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isFromUser: null == isFromUser ? _self.isFromUser : isFromUser // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
