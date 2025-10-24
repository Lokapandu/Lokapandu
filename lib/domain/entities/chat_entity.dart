import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_entity.freezed.dart';

@freezed
abstract class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String userId,
    required String content,
    required bool isFromUser,
    required DateTime createdAt,
  }) = _Chat;
}
