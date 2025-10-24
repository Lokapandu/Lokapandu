// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_model.freezed.dart';
part 'ai_chat_model.g.dart';

@freezed
abstract class AiChatModel with _$AiChatModel {
  const factory AiChatModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String content,
    @JsonKey(name: 'is_from_user') required bool isFromUser,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AiChatModel;

  factory AiChatModel.fromJson(Map<String, dynamic> json) =>
      _$AiChatModelFromJson(json);
}
