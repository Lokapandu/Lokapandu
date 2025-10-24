import 'package:lokapandu/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChatHistory();

  Stream<Chat> subscribeChat();

  Future<String?> generateResponse(String message);

  Future<void> storeChat(String message, bool isUser);

  Future<void> clearHistory();
}
