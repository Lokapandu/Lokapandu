import 'package:flutter/material.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/usecases/chats/ask_ai.dart';
import 'package:lokapandu/domain/usecases/chats/delete_chats.dart';
import 'package:lokapandu/domain/usecases/chats/store_chat.dart';
import 'package:lokapandu/domain/usecases/chats/stream_chats.dart';
import 'package:lokapandu/presentation/ai_chat/models/chat_message_model.dart';

class AiChatNotifier extends ChangeNotifier {
  final StreamChats _streamChats;
  final ClearChatHistory _clearChatHistory;
  final AskAi _askAi;
  final StoreChat _storeChat;

  AiChatNotifier({
    required StreamChats streamChats,
    required ClearChatHistory clearChatHistory,
    required AskAi askAi,
    required StoreChat storeChat,
  }) : _streamChats = streamChats,
       _clearChatHistory = clearChatHistory,
       _askAi = askAi,
       _storeChat = storeChat;

  Stream<List<ChatMessage>> get chatsStream => _streamChats.execute().map((
    data,
  ) {
    if (data.isEmpty) {
      String message =
          'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?';
      return [ChatMessage(text: message, isFromUser: false)];
    }
    return data
        .map((e) => ChatMessage(isFromUser: e.isFromUser, text: e.content))
        .toList();
  });

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  Future<void> loadChatHistory() async {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> sendMessage(String userMessageText) async {
    try {
      _isLoading = true;
      notifyListeners();
      // store message
      await _storeChat.execute(userMessageText, true);
      // retrieve from AI
      final aiMessage = await _askAi.execute(userMessageText);
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearChatHistory() async {
    _isLoading = true;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    failure.maybeWhen(
      server: (message) => _errorMessage = 'Server Error: $message',
      connection: (message) => _errorMessage = 'Connection Error: $message',
      database: (message) => _errorMessage = 'Database Error: $message',
      orElse: () => _errorMessage = 'Unknown Error',
    );
  }
}
