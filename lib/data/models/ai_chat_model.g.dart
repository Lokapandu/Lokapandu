// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiChatModel _$AiChatModelFromJson(Map<String, dynamic> json) => _AiChatModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  content: json['content'] as String,
  isFromUser: json['is_from_user'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AiChatModelToJson(_AiChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'is_from_user': instance.isFromUser,
      'created_at': instance.createdAt.toIso8601String(),
    };
