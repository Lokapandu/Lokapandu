import 'package:lokapandu/data/models/ai_chat_model.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/presentation/ai_chat/models/chat_message_model.dart';

extension AiChatModelMapper on AiChatModel {
  Chat toEntity() {
    return Chat(
      id: id,
      userId: userId,
      content: content,
      isFromUser: isFromUser,
      createdAt: createdAt,
    );
  }
}

extension ChatEntityMapper on Chat {
  AiChatModel toModel() {
    return AiChatModel(
      id: id,
      userId: userId,
      content: content,
      isFromUser: isFromUser,
      createdAt: createdAt,
    );
  }
}

extension ChatMessageMapper on Chat {
  ChatMessage toChatMessage() {
    return ChatMessage(text: content, isFromUser: isFromUser);
  }
}
