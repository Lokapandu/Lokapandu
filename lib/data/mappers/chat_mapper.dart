import 'package:lokapandu/brick/models/chat.model.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';

extension ChatModelMapper on ChatModel {
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
