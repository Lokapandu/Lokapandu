import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/data/mappers/chat_mapper.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:lokapandu/presentation/ai_chat/models/chat_message_model.dart';

class AiChatNotifier extends ChangeNotifier {
  final ChatRepository _repository;
  final AnalyticsManager _manager;

  AiChatNotifier({
    required ChatRepository repository,
    required AnalyticsManager manager,
  }) : _repository = repository,
       _manager = manager;

  final List<ChatMessage> _chats = [];
  StreamSubscription<List<Chat>>? _chatsStream;

  List<ChatMessage> get chats => _chats;

  Future<void> loadChatHistory() async {
    try {
      final initialChats = await _repository.getChatHistory();
      _chats.clear();
      if (initialChats.isEmpty) {
        _chats.add(
          ChatMessage(
            text:
                'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
            isFromUser: false,
          ),
        );
      }
      _chats.addAll(initialChats.map((e) => e.toChatMessage()));
      notifyListeners();
    } catch (e) {
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void initStream() {
    _chatsStream = _repository.subscribeChat().listen((newChats) {
      // Remove typing indicators and clear existing chats
      _chats.removeWhere((chat) => chat.isTyping);
      _chats.clear();

      // Add welcome message if no chats exist
      if (newChats.isEmpty) {
        _chats.add(
          ChatMessage(
            text:
                'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
            isFromUser: false,
          ),
        );
      } else {
        // Add all chats from the stream
        _chats.addAll(newChats.map((chat) => chat.toChatMessage()));
      }

      notifyListeners();
    });
  }

  bool _isLoading = false;
  bool _isClearing = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  bool get isClearing => _isClearing;

  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  Future<void> sendMessage(String userMessageText) async {
    if (userMessageText.isEmpty || _isLoading) return;
    final userMessage = ChatMessage(text: userMessageText, isFromUser: true);
    final typingIndicator = ChatMessage(
      text: '...',
      isFromUser: false,
      isTyping: true,
    );

    _chats.addAll([userMessage, typingIndicator]);
    notifyListeners();

    try {
      // generate response
      final responseText = await _repository.generateResponse(userMessageText);
      if (responseText == null) {
        _errorMessage = 'Failed to generate response.';
        return;
      }
      // store response
      await _repository.storeChat(userMessageText, true);
      await _repository.storeChat(responseText, false);
    } catch (e) {
      _chats.removeWhere((msg) => msg.isTyping);
      _chats.add(ChatMessage(text: 'Error!', isFromUser: false, isError: true));
      _isLoading = false;
      _errorMessage = 'Unexpected error: ${e.toString()}';
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearChatHistory() async {
    try {
      _isClearing = true;
      notifyListeners();

      // Clear history in repository
      await _repository.clearHistory();

      // Immediately clear local chats and show welcome message
      // This provides instant feedback while stream catches up
      _chats.clear();
      _chats.add(
        ChatMessage(
          text:
              'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
          isFromUser: false,
        ),
      );

      _isClearing = false;
      _errorMessage = null; // Clear any previous errors
    } catch (e) {
      _isClearing = false;
      _errorMessage = 'Unexpected error: ${e.toString()}';
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _chatsStream?.cancel();
    super.dispose();
  }
}
