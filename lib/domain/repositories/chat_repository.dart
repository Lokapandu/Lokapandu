import 'package:lokapandu/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChatHistory();

  Stream<List<Chat>> subscribeChat();

  Future<String?> generateResponse(String message);

  Future<void> storeChat(String message, bool isUser);

  /// Store multiple chat messages in a single atomic operation
  Future<void> storeMultipleChats(List<({String message, bool isUser})> messages);

  Future<void> clearHistory();
}
